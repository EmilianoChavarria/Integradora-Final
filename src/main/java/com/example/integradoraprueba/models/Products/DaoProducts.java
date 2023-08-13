package com.example.integradoraprueba.models.Products;
import com.example.integradoraprueba.models.vehicle.DaoVehicle;
import com.example.integradoraprueba.models.vehicle.Vehicle;
import com.example.integradoraprueba.utils.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoProducts {

    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;
    private CallableStatement cs;

    public boolean saveProduct(Product object) throws SQLException {
        try{
            conn = new MySQLConnection().connect();
            String query = "insert into products (concept, price, piece, name) VALUES (?,?,?,?);";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, object.getConcept());
            pstm.setString(2, object.getPrice());
            pstm.setString(3, object.getPiece());
            pstm.setString(4, object.getName());
            return pstm.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoProducts.class.getName()).log(Level.SEVERE, "Error save "+ e.getMessage());
        }finally {
            close();
        }
        return false;
    }

    public List<Product> findAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM products;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId_product(rs.getLong("id_product"));
                product.setConcept(rs.getString("concept"));
                product.setPrice(rs.getString("price"));
                product.setPiece(rs.getString("piece"));
                product.setName(rs.getString("name"));
                products.add(product);
            }
            return products;
        } catch (SQLException e) {
            Logger.getLogger(DaoProducts.class.getName()).log(Level.SEVERE, "Error findAllProducts "+ e.getMessage());
        } finally {
            close();
        }
        return null;
    }

    public boolean deleteProduct(Long id_product) {
        try {
            conn = new MySQLConnection().connect();
            String query = "DELETE FROM products WHERE id_product=?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, id_product);
            return pstm.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoProducts.class.getName()).log(Level.SEVERE, "Error deleteProduct" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public boolean updateProduct(Product object) throws SQLException{
        try {

            conn = new MySQLConnection().connect();
            String query= "UPDATE products set  concept=?, price=?, piece=?, name=? WHERE id_product=?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1,object.getConcept());
            pstm.setString(2,object.getPrice());
            pstm.setString(3,object.getPiece());
            pstm.setString(4,object.getName());
            pstm.setLong(5,object.getId_product());
            System.out.println("Updating product with idProduct: " + object.getId_product());
            System.out.println("Concept: " + object.getConcept());
            System.out.println("Price: " + object.getPrice());
            System.out.println("Piece: " + object.getPiece());
            System.out.println("License Plate: " + object.getName());
            return pstm.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoProducts.class.getName()).log(Level.SEVERE, "ERROR updating " + e.getMessage());

        }finally {
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
