package com.example.integradoraprueba.models.vehicle;

import com.example.integradoraprueba.models.Package.Package;
import com.example.integradoraprueba.models.Role.Role;
import com.example.integradoraprueba.models.user.DaoUser;
import com.example.integradoraprueba.models.user.User;
import com.example.integradoraprueba.utils.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoVehicle {
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;
    private CallableStatement cs;


    public boolean saveVehicle(Vehicle object) {
        try{
            conn = new MySQLConnection( ).connect();
            String query = "INSERT INTO vehicles (id_user, brand, model, year, license_plate, color, transmission, type_fuel, capacity, engine_number) VALUES (?, ?, ?, ?, ?,?, ?, ?, ?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,object.getUser().getId_user());
            pstm.setString(2,object.getBrand());
            pstm.setString(3,object.getModel());
            pstm.setString(4,object.getYear());
            pstm.setString(5,object.getLicense_plate());
            pstm.setString(6,object.getColor());
            pstm.setString(7,object.getTransmission());
            pstm.setString(8,object.getType_fuel());
            pstm.setString(9,object.getCapacity());
            pstm.setString(10,object.getEngine_number());

            return pstm.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoVehicle.class.getName()).log(Level.SEVERE, "Error save "+ e.getMessage());
        }finally {
            close();
        }
        return false;
    }

    public List<Package> searchServices() {
        List<Package> list = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM packages;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Package packages = new Package();
                packages.setId_package(rs.getLong("id_package"));
                packages.setName(rs.getString("name"));
                packages.setType_package(rs.getString("type_package"));
                list.add(packages);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR searchType" + e.getMessage());
        } finally {
            close();
        }
        return list;
    }

    public List<Vehicle> findVehicleByUser(Long id_user) {
        List<Vehicle> vehicles = new ArrayList<>();
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
                vehicles.add(vehicle);
            }
            return vehicles;
        } catch (SQLException e) {
            Logger.getLogger(DaoVehicle.class.getName()).log(Level.SEVERE, "Error findOne "+ e.getMessage());
        } finally {
            close();
        }
        return null;
    }

public boolean updateVehicle(Vehicle object) throws SQLException{
try {

conn = new MySQLConnection().connect();
String query= "UPDATE vehicles set  brand=?, model=?, year=?, license_plate=?, color=?, transmission=?, type_fuel=?, capacity=?, engine_number=? WHERE id_vehicle=?;";
pstm = conn.prepareStatement(query);
    pstm.setString(1,object.getBrand());
    pstm.setString(2,object.getModel());
    pstm.setString(3,object.getYear());
    pstm.setString(4,object.getLicense_plate());
    pstm.setString(5,object.getColor());
    pstm.setString(6,object.getTransmission());
    pstm.setString(7,object.getType_fuel());
    pstm.setString(8,object.getCapacity());
    pstm.setString(9,object.getEngine_number());
    pstm.setLong(10,object.getId_vehicle());
    System.out.println("Updating vehicle with id_vehicle: " + object.getId_vehicle());
    System.out.println("Brand: " + object.getBrand());
    System.out.println("Model: " + object.getModel());
    System.out.println("Year: " + object.getYear());
    System.out.println("License Plate: " + object.getLicense_plate());
    System.out.println("Color: " + object.getColor());
    System.out.println("Transmission: " + object.getTransmission());
    System.out.println("Type of Fuel: " + object.getType_fuel());
    System.out.println("Capacity: " + object.getCapacity());
    System.out.println("Engine Number: " + object.getEngine_number());
    return pstm.executeUpdate() > 0;
}catch (SQLException e){
    Logger.getLogger(DaoVehicle.class.getName()).log(Level.SEVERE, "ERROR updating " + e.getMessage());

}finally {
    close();
}
        return false;
}


    public boolean deleteVehicle(Long id_vehicle) {
        try {
            conn = new MySQLConnection().connect();
            String query = "DELETE FROM vehicles WHERE id_vehicle=?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, id_vehicle);
            System.out.println(id_vehicle);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoVehicle.class.getName()).log(Level.SEVERE, "Error deleteVehicle " + e.getMessage());
        } finally {
            close();
        }
        return false;
    }



    public void close() {
        try {
            if (conn != null)
                conn.close();
            if (pstm != null)
                pstm.close();
            if (cs != null)
                cs.close();
            if (rs != null)
                rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
