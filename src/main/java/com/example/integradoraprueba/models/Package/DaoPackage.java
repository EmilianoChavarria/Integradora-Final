package com.example.integradoraprueba.models.Package;
import com.example.integradoraprueba.models.Products.Product;
import com.example.integradoraprueba.models.Package.Package;
import com.example.integradoraprueba.models.Role.Role;
import com.example.integradoraprueba.models.user.DaoUser;
import com.example.integradoraprueba.utils.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoPackage {
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;
    private CallableStatement cs;


    public List<Package> searchPackages(){
        List<Package> list = new ArrayList<>();
        try {
            conn= new MySQLConnection().connect();
            String query = "SELECT * FROM packages;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()){
                Package packages = new Package();
                packages.setId_package(rs.getLong("id_package"));
                packages.setName(rs.getString("name"));
                packages.setType_package(rs.getString("type_package"));
                list.add(packages);
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoPackage.class.getName()).log(Level.SEVERE, "ERROR searchPackages" + e.getMessage());
        } finally {
            close();
        }
        return list;
    }

    public boolean save(Product_package object) {
        try{
            conn = new MySQLConnection().connect();
            String query = "insert into product_packages (id_product, id_package, quantity) VALUES (?,?,?);";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,object.getProduct().getId_product());
            pstm.setLong(2,object.getPackages().getId_package());
            pstm.setString(3,object.getQuantity());
            return  pstm.executeUpdate() > 0;
        }catch (SQLException e){
            Logger.getLogger(DaoPackage.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());

        }finally {
            close();
        }
        return false;
    }

    public List<ProductPackageSummary> findAllPackages() {
        List<ProductPackageSummary> packageSummaries = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM product_package_summary;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()) {
                ProductPackageSummary productpackage = new ProductPackageSummary();
                productpackage.setIdProductPackage(rs.getLong("id_product_package"));
                productpackage.setProduct_name(rs.getString("product_name"));
                productpackage.setPackage_name(rs.getString("package_name"));
                productpackage.setPackage_type(rs.getString("package_type"));
                productpackage.setQuantity(rs.getInt("quantity"));
                productpackage.setTotal_price(rs.getFloat("total_price"));
                packageSummaries.add(productpackage);
            }
            return packageSummaries;
        } catch (SQLException e) {
            Logger.getLogger(DaoPackage.class.getName()).log(Level.SEVERE, "Error findAllPackages " + e.getMessage());
        } finally {
            close();
        }
        return null;
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
            Logger.getLogger(DaoPackage.class.getName()).log(Level.SEVERE, "Error findAllProducts "+ e.getMessage());
        } finally {
            close();
        }
        return null;
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
