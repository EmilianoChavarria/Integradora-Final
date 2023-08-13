package com.example.integradoraprueba.models.user;

import com.example.integradoraprueba.models.Address.Address;
import com.example.integradoraprueba.models.Role.Role;
import com.example.integradoraprueba.models.vehicle.DaoVehicle;
import com.example.integradoraprueba.models.vehicle.Vehicle;
import com.example.integradoraprueba.utils.MySQLConnection;
import com.example.integradoraprueba.models.crud.DaoRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DaoUser implements DaoRepository<User> {

    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;
    private CallableStatement cs;

    //completo
    //select u.*, a.*, r.*  from users u
    //    join addresses a on u.id_address = a.id_address
    //    join roles r on u.id_role = r.id_role;

    public User loadUserByUsernameAndPassword(String username,
                                              String password) {
        System.out.println(username + password);
        try {
            conn = new MySQLConnection().connect();
            String query = "select users.id_user, users.username, users.name, users.surname, ifnull(lastname,'') as lastname, r.role from users  join roles r on users.id_role = r.id_role where username=? and password=?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, username);
            pstm.setString(2, password);
            rs = pstm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId_user(rs.getLong("id_user"));
                user.setUsername(rs.getString("username"));

                Role role = new Role();
                role.setRole(rs.getString("role"));
                user.setRole(role);
                return user;
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName())
                    .log(Level.SEVERE,
                            "Credentials mismatch: " + e.getMessage());
        } finally {
            close();
        }
        return null;
    }

    public boolean save(User user) {
        try {
            conn = new MySQLConnection().connect();
            String query = ("{CALL InsertAddressAndUser(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
            cs = conn.prepareCall(query);
            System.out.println("User object: " + user);
            System.out.println("Address object: " + user.getAddress());
            cs.setString(1, user.getAddress().getStreet());
            cs.setString(2, user.getAddress().getNeighborhood());
            cs.setString(3, user.getAddress().getApartment_number());
            cs.setString(4, user.getAddress().getStreet_apartment());
            cs.setString(5, user.getAddress().getPostal_code());
            cs.setString(6, user.getName());
            cs.setString(7, user.getMail());
            cs.setString(8, user.getSurname());
            cs.setString(9, user.getLastname());
            cs.setString(10, user.getCurp());
            cs.setString(11, user.getRfc());
            cs.setString(12, user.getSex());
            cs.setString(13, user.getUsername());
            cs.setString(14, user.getPassword());
            cs.setLong(15, user.getRole().getId_role());
            cs.setString(16, user.getPhone_number());
            cs.executeQuery();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error save " + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    @Override
    public boolean update(User user) throws SQLException {

        try {
            conn = new MySQLConnection().connect();
            String query = "CALL UpdateAddressAndUser(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
            pstm = conn.prepareStatement(query);

            // Setear los parámetros del procedimiento almacenado
            pstm.setLong(1, user.getAddress().getId());
            pstm.setString(2, user.getAddress().getStreet());
            pstm.setString(3, user.getAddress().getNeighborhood());
            pstm.setString(4, user.getAddress().getApartment_number());
            pstm.setString(5, user.getAddress().getStreet_apartment());
            pstm.setString(6, user.getAddress().getPostal_code());
            pstm.setLong(7, user.getId_user());
            pstm.setString(8, user.getName());
            pstm.setString(9, user.getMail());
            pstm.setString(10, user.getSurname());
            pstm.setString(11, user.getLastname());
            pstm.setString(12, user.getCurp());
            pstm.setString(13, user.getRfc());
            pstm.setString(14, user.getSex());
            pstm.setString(15, user.getUsername());
            pstm.setString(16, user.getPassword());
            pstm.setLong(17, user.getRole().getId_role());
            pstm.setString(18, user.getPhone_number());



            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR updating user: " + e.getMessage());
        } finally {
            if (pstm != null) {
                pstm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }


    public List<Vehicle> findVehicleByIdUser(Long id_user) {
        List<Vehicle> vehicles1 = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM vehicles WHERE id_user=?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, id_user);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setId_vehicle(rs.getLong("id_vehicle"));
                vehicle.setBrand(rs.getString("brand"));
                vehicle.setModel(rs.getString("model"));
                vehicle.setYear(rs.getString("year"));
                vehicle.setLicense_plate(rs.getString("license_plate"));
                vehicle.setColor(rs.getString("color"));
                vehicle.setTransmission(rs.getString("transmission"));
                vehicle.setType_fuel(rs.getString("type_fuel"));
                vehicle.setCapacity(rs.getString("capacity"));
                vehicle.setEngine_number(rs.getString("engine_number"));
                vehicles1.add(vehicle);
            }
            return vehicles1;
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error findVehicle " + e.getMessage());
        } finally {
            close();
        }
        return null;
    }


    //    public List<User> findAll() {
//        List<User> users = new ArrayList<>();
//        try {
//            conn = new MySQLConnection().connect();
//            String query = "select * from user_address_role_view;";
//            pstm = conn.prepareStatement(query);
//            rs = pstm.executeQuery();
//            while (rs.next()) {
//                User user = new User();
//                user.setId_user(rs.getLong("id_user"));
//                user.setName(rs.getString("name"));
//                user.setSurname(rs.getString("surname"));
//                user.setLastname(rs.getString("lastname"));
//                user.setMail(rs.getString("mail"));
//                user.setUsername(rs.getString("username"));
//                Role role = new Role();
//                role.setId_role(rs.getLong("id_role"));
//                role.setRole(rs.getString("role"));
//                user.setRole(role);
//                users.add(user);
//            }
//        } catch (SQLException e) {
//            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error findAll " + e.getMessage());
//        } finally {
//            close();
//        }
//        return users;
//    }
    @Override
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "select * from user_address_role_view;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId_user(rs.getLong("id_user"));
                user.setName(rs.getString("user_name"));
                user.setSurname(rs.getString("surname"));
                user.setLastname(rs.getString("lastname"));
                user.setMail(rs.getString("mail"));
                user.setCurp(rs.getString("curp"));
                user.setRfc(rs.getString("rfc"));
                user.setSex(rs.getString("sex"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setPhone_number(rs.getString("phone_number"));

                Role role = new Role();
                role.setId_role(rs.getLong("user_role_id"));
                role.setRole(rs.getString("role_name"));
                user.setRole(role);

                Address address = new Address();
                address.setId(rs.getLong("user_address_id"));
                address.setStreet(rs.getString("street"));
                address.setNeighborhood(rs.getString("neighborhood"));
                address.setApartment_number(rs.getString("apartment_number"));
                address.setStreet_apartment(rs.getString("street_apartment"));
                address.setPostal_code(rs.getString("postal_code"));
                user.setAddress(address);

                users.add(user);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error findAll " + e.getMessage());
        } finally {
            close();
        }
        return users;
    }


    public List<User> findAllClients() {
        List<User> users = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "select u.id_user,u.name,u.surname, u.lastname, u.mail, u.username, r.id_role, r.role from users u join roles r on r.id_role = u.id_role where r.role = 'cliente';";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId_user(rs.getLong("id_user"));
                user.setName(rs.getString("name"));
                user.setSurname(rs.getString("surname"));
                user.setLastname(rs.getString("lastname"));
                user.setMail(rs.getString("mail"));
                user.setUsername(rs.getString("username"));
                Role role = new Role();
                role.setId_role(rs.getLong("id_role"));
                role.setRole(rs.getString("role"));
                user.setRole(role);
                users.add(user);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error findAll " + e.getMessage());
        } finally {
            close();
        }
        return users;
    }

    @Override
    public User finOne(Long id_user) {
        //preguntar si se puede crear vista con lo anterior y ya sólo se iguala al id
        return null;
    }


    @Override
    public List<Role> searchRole() {
        List<Role> list = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM roles;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Role role = new Role();
                role.setId_role(rs.getLong("id_role"));
                role.setRole(rs.getString("role"));
                list.add(role);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR searchType" + e.getMessage());
        } finally {
            close();
        }
        return list;
    }



    @Override
    public boolean delete(Long id) {
        try {
            conn = new MySQLConnection().connect();

            // Obtener la dirección del usuario a eliminar antes de eliminarlo
            String findAddressQuery = "SELECT id_address FROM users WHERE id_user=?;";
            pstm = conn.prepareStatement(findAddressQuery);
            pstm.setLong(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                long addressId = rs.getLong("id_address");
                // Eliminar al usuario
                String UserQuery = "DELETE FROM users WHERE id_user=?;";
                pstm = conn.prepareStatement(UserQuery);
                pstm.setLong(1, id);
                int rowsAffectedUser = pstm.executeUpdate();

                // Si el usuario se eliminó correctamente, eliminar la dirección asociada
                if (rowsAffectedUser == 1) {
                    String AddressQuery = "DELETE FROM addresses WHERE id_address=?;";
                    pstm = conn.prepareStatement(AddressQuery);
                    pstm.setLong(1, addressId);
                    int rowsAffectedAddress = pstm.executeUpdate();

                    // Retornar true solo si se eliminaron tanto el usuario como la dirección
                    return rowsAffectedAddress == 1;
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error delete " + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public void close() {
        try {
            if (conn != null) conn.close();
            if (pstm != null) pstm.close();
            if (rs != null) rs.close();
        } catch (SQLException e) {

        }

    }
}
