package com.example.integradoraprueba.models.recepcion;

import com.example.integradoraprueba.models.Role.Role;
import com.example.integradoraprueba.models.user.DaoUser;
import com.example.integradoraprueba.models.user.User;
import com.example.integradoraprueba.utils.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoRecepcion {
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;
    private CallableStatement cs;

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
            Logger.getLogger(DaoRecepcion.class.getName()).log(Level.SEVERE, "Error findAll " + e.getMessage());
        } finally {
            close();
        }
        return users;
    }

    public Role searchRoleClient() {
        Role role = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM roles WHERE id_role = 3;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            if (rs.next()) {
                role = new Role();
                role.setId_role(rs.getLong("id_role"));
                role.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoRecepcion.class.getName()).log(Level.SEVERE, "ERROR searchRoleClient: " + e.getMessage());
        } finally {
            close();
        }
        return role;
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
            Logger.getLogger(DaoRecepcion.class.getName()).log(Level.SEVERE, "Error save " + e.getMessage());
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
