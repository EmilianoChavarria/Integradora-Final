package com.example.integradoraprueba.controllers.productos;

import com.example.integradoraprueba.models.Products.DaoProducts;
import com.example.integradoraprueba.models.Products.Product;
import com.example.integradoraprueba.models.user.DaoUser;
import com.example.integradoraprueba.models.user.User;
import com.example.integradoraprueba.models.vehicle.DaoVehicle;
import com.example.integradoraprueba.models.vehicle.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

@WebServlet(name = "product",
        urlPatterns = {
                "/api/product/all",
                "/api/product/one",
                "/api/product/user",
                "/api/product/create",
                "/product/view",
                "/product/view2",
                "/product/view3",
                "/api/product/save",
                "/api/product/delete",
                "/api/product/edit",
                "/api/product/update"
        })
public class ServletProducts extends HttpServlet {
    private String action;
    private String redirect = "/api/product/all";
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/api/product/all":
                req.setAttribute("products", new DaoProducts().findAllProducts());
                redirect ="/views/admins/products-view.jsp";
                break;
        }
        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        action = req.getServletPath();
        switch (action){
            case "/api/product/save":
                try {
                    String concept = req.getParameter("concept");
                    String price = req.getParameter("price");
                    String piece = req.getParameter("piece");
                    String name = req.getParameter("name");
                    System.out.println();
                    Product product = new Product();
                    product.setConcept(concept);
                    product.setPrice(price);
                    product.setPiece(piece);
                    product.setName(name);

                    boolean result = new DaoProducts().saveProduct(product);
                    if (result) {
                        redirect = "/api/product/all?result= " + result + "&message=" + URLEncoder.encode("¡Éxito! Producto registrado correctamente.",
                                StandardCharsets.UTF_8);
                    } else {
                        redirect = "/api/product/all?result= " + result + "&message=" + URLEncoder.encode("¡Error! Acción no realizada correctamente.",
                                StandardCharsets.UTF_8);
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "/api/product/delete":
                try {
                    Long id_product= Long.parseLong(req.getParameter("id_product"));
                    boolean result = new DaoProducts().deleteProduct(id_product);
                    if (result) {
                        redirect = "/api/product/all?id_product="+id_product+"&result="+result+"&message=" + URLEncoder.encode("¡Vehiculo eliminado correctamente.", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/api/product/all?id_product="+id_product+"&result="+result+"&message=" + URLEncoder.encode("¡Error al eliminar el vehiculo.", StandardCharsets.UTF_8);
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                break;
            case "/api/product/update":
                try {
                    String idProduct = req.getParameter("id_product");
                    String name = req.getParameter("name");
                    String concept = req.getParameter("concept");
                    String piece = req.getParameter("piece");
                    String price = req.getParameter("price");


                    System.out.println("-------------------------------------");
                    System.out.println(idProduct);
                    System.out.println(name);
                    System.out.println(concept);
                    System.out.println(piece);
                    System.out.println(price);

                    Product product = new Product();

                    product.setId_product(Long.parseLong(idProduct));
                    product.setName(name);
                    product.setConcept(concept);
                    product.setPiece(piece);
                    product.setPrice(price);



                    boolean result = new DaoProducts().updateProduct(product);


                    if (result) {
                        redirect = "/api/product/all?result= " + result + "&message=" + URLEncoder.encode("¡Éxito! Producto registrado correctamente.",
                                StandardCharsets.UTF_8);
                    } else {
                        redirect = "/api/product/all?result= " + result + "&message=" + URLEncoder.encode("¡Error! Acción no realizada correctamente.",
                                StandardCharsets.UTF_8);
                    }
                }catch (SQLException e) {
                    throw new ServletException(e);
                }
                break;
        }

        resp.sendRedirect(req.getContextPath()
                + redirect);
    }

}
