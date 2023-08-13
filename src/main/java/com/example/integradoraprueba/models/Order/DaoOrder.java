package com.example.integradoraprueba.models.Order;

import com.example.integradoraprueba.models.Package.DaoPackage;
import com.example.integradoraprueba.models.Package.ProductPackageSummary;
import com.example.integradoraprueba.models.Service.Service;
import com.example.integradoraprueba.models.user.User;
import com.example.integradoraprueba.models.vehicle.DaoVehicle;
import com.example.integradoraprueba.models.vehicle.Vehicle;
import com.example.integradoraprueba.utils.MySQLConnection;
import com.oracle.wls.shaded.org.apache.xpath.operations.Or;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;



public class DaoOrder {
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;
    private CallableStatement cs;

    public boolean save(Order order) throws SQLException {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO orders (id_vehicle, status, mileage, date_entry) VALUES (?, ?, ?, ?)";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, order.getVehicle().getId_vehicle());
            pstm.setInt(2, 1);
            pstm.setString(3, order.getMileage());
            pstm.setDate(4, Date.valueOf(LocalDate.now()));
            pstm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            close();
        }
        return false;
    }

    public List<Service> findAllServices() {
        List<Service> services = new ArrayList<>();

        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM all_info";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setId_service(rs.getLong("id_service"));

                Order order = new Order();
                order.setId_order(rs.getLong("id_order"));
                order.setStatus(rs.getLong("status"));
                order.setMileage(rs.getString("mileage"));
                order.setDate_entry(rs.getString("date_entry"));

                User user = new User();
                user.setId_user(rs.getLong("id_user"));
                user.setName(rs.getString("user_name"));
                user.setSurname(rs.getString("user_surname_name"));
                user.setLastname(rs.getString("user_last_name"));
                order.setUser(user);

                Vehicle vehicle = new Vehicle();
                vehicle.setBrand(rs.getString("vehicle_brand"));
                vehicle.setModel(rs.getString("vehicle_model"));
                order.setVehicle(vehicle);

                ProductPackageSummary packageSummary = new ProductPackageSummary();
                packageSummary.setIdProductPackage(rs.getLong("fk_product_package"));
                packageSummary.setPackage_name(rs.getString("package_name"));
                packageSummary.setPackage_type(rs.getString("package_type"));
                packageSummary.setTotal_price(rs.getFloat("total_service_price"));
                service.setProductPackageSummary(packageSummary);

                service.setDetail(rs.getString("detail"));
                service.setOrder(order);

                services.add(service);
            }

            return services;
        } catch (SQLException e) {
            Logger.getLogger(DaoOrder.class.getName()).log(Level.SEVERE, "Error findAllServices " + e.getMessage());
        } finally {
            close();
        }

        return services;
    }


    public boolean updateOrder(long orderId) {
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE orders SET status = 3, departure_date = CURDATE() WHERE id_order = ?";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, orderId);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoOrder.class.getName()).log(Level.SEVERE, "Error updateOrder " + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public boolean updateLastStatus(long orderId) {
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE orders SET status = 4 WHERE id_order = ?";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, orderId);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoOrder.class.getName()).log(Level.SEVERE, "Error updateOrder " + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public List<Order> findAllOrders() {
        List<Order> orders = new ArrayList<>();


        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM order_details_view;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId_order(rs.getLong("id_order"));
                Vehicle vehicle = new Vehicle();//Vehiculos
                vehicle.setBrand(rs.getString("vehicle_brand"));
                vehicle.setModel(rs.getString("vehicle_model"));
                User user = new User();//datos usuarios
                user.setId_user(rs.getLong("id_user"));
                user.setName(rs.getString("user_name"));
                user.setSurname(rs.getString("user_surname_name"));
                user.setLastname(rs.getString("user_last_name"));
                vehicle.setUser(user);
                order.setVehicle(vehicle);
                order.setStatus(rs.getLong("status"));
                order.setMileage(rs.getString("mileage"));
                order.setDate_entry(rs.getString("date_entry"));
                orders.add(order);
            }
            return orders;
        } catch (SQLException e) {
            Logger.getLogger(DaoOrder.class.getName()).log(Level.SEVERE, "Error findAllOrders " + e.getMessage());
        } finally {
            close();
        }
        return null;
    }

    //    public boolean saveService(Service service) {
//        try {
//            conn = new MySQLConnection().connect();
//            String query = "INSERT INTO services (fk_order, fk_product_package, detail, fk_user) " +
//                    "VALUES (?, ?, ?, ?, ?)";
//            pstm = conn.prepareStatement(query);
//            pstm.setLong(1, service.getOrder().getId_order());
//            pstm.setLong(2, service.getProduct_package().getId_product_package());
//            pstm.setString(3, service.getDetail());
//            pstm.setLong(4, service.getUser().getId_user());
//            pstm.executeUpdate();
//        } catch (SQLException e) {
//            Logger.getLogger(DaoOrder.class.getName()).log(Level.SEVERE, "Error saving service: " + e.getMessage());
//        } finally {
//            close();
//        }
//        return false;
//    }
    public boolean saveService(Service service) {
        try {
            conn = new MySQLConnection().connect();
            String query = "{CALL InsertServiceAndUpdateOrder(?, ?, ?, ?)}";
            cs = conn.prepareCall(query);
            cs.setLong(1, service.getOrder().getId_order());
            cs.setLong(2, service.getProductPackageSummary().getIdProductPackage());
            cs.setString(3, service.getDetail());
            cs.setLong(4, service.getUser().getId_user());
            cs.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DaoOrder.class.getName()).log(Level.SEVERE, "Error saving service: " + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

        public void close () {
            try {
                if (conn != null) conn.close();
                if (pstm != null) pstm.close();
                if (rs != null) rs.close();
            } catch (SQLException e) {

            }

        }

    }

