package com.example.integradoraprueba.controllers.caja;

import com.example.integradoraprueba.models.Order.DaoOrder;
import com.example.integradoraprueba.models.Order.Order;
import com.example.integradoraprueba.models.Package.DaoPackage;
import com.example.integradoraprueba.models.Package.ProductPackageSummary;
import com.example.integradoraprueba.models.Products.DaoProducts;
import com.example.integradoraprueba.models.Service.Service;
import com.example.integradoraprueba.models.user.User;
import com.example.integradoraprueba.models.vehicle.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "caja", urlPatterns = {
        "/caja/main",
        "/caja/orders-view",
        "/caja/save-order",
        "/caja/save-service",
        "/caja/update-status",
        "/caja/update-statusend"


})
public class ServletCaja extends HttpServlet {

    private String action;
    private String redirect = "/caja/main";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/caja/main":
                redirect = "/views/caja/caja-main.jsp";
                break;
            case "/caja/orders-view":
                List<Order> orders = new DaoOrder().findAllOrders();
                req.setAttribute("orders", orders);
                List<ProductPackageSummary> packageSummaries = new DaoPackage().findAllPackages();
                req.setAttribute("packageView", packageSummaries);
                List<Service> services = new DaoOrder().findAllServices();
                req.setAttribute("services", services);
                redirect = "/views/caja/orders-view.jsp";
                break;
            case "/caja/all-products":
                req.setAttribute("products", new DaoProducts().findAllProducts());
                redirect ="/views/caja/products-view.jsp";
                break;
        }
        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/caja/save-order":
                try {
                    // obtener los datos desde el formulario
                    String id_vehicle = req.getParameter("id_vehicle");
                    String mileage = req.getParameter("mileage");

                    Vehicle vehicle = new Vehicle();
                    vehicle.setId_vehicle(Long.parseLong(id_vehicle));


                    Order order = new Order();
                    order.setVehicle(vehicle);
                    order.setMileage(mileage);


                    boolean result = new DaoOrder().save(order);

                    if (result) {
                        redirect = "/caja/orders-view?&result=true&message=" + URLEncoder.encode("¡Éxito! Orden almacenada correctamente.",
                                StandardCharsets.UTF_8);
                    } else {
                        redirect = "/caja/orders-view?&result=false&message=" + URLEncoder.encode("¡Error! Orden no almacenada correctamente.",
                                StandardCharsets.UTF_8);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    resp.getWriter().write("Error processing order data: " + e.getMessage());
                }
                break;
            case "/caja/save-service":
                try {
                    String id_order = req.getParameter("id_order");
                    String id_user = req.getParameter("id_user");
                    String id_product = req.getParameter("id_product");
                    String detail = req.getParameter("detail");

                    Order orders = new Order();
                    orders.setId_order(Long.parseLong(id_order));

                    User user = new User();
                    user.setId_user(Long.parseLong(id_user));

                    ProductPackageSummary ProductPackageSummary = new ProductPackageSummary();
                    ProductPackageSummary.setIdProductPackage(Long.parseLong(id_product));

                    Service service = new Service();
                    service.setDetail(detail);
                    service.setOrder(orders);
                    service.setUser(user);
                    service.setProductPackageSummary(ProductPackageSummary);
                    boolean result = new DaoOrder().saveService(service);
                    if (result) {
                        redirect = "/caja/orders-view?result=true&message=" + URLEncoder
                                .encode("Servicio registrado correctamente", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/caja/orders-view?result=false&message=" + URLEncoder
                                .encode("Error guardando el servicio", StandardCharsets.UTF_8);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    redirect = "/caja/orders-view?result=false&message=" + URLEncoder
                            .encode("Error guardando el servicio: " + e.getMessage(),
                                    StandardCharsets.UTF_8);
                }
                break;
            case "/mecanico/update-status":
                try {
                    String orderIdStr = req.getParameter("id_order");
                    long orderId = Long.parseLong(orderIdStr);
                    System.out.println(orderId);
                    boolean result = new DaoOrder().updateOrder(orderId);

                    if (result) {
                        redirect = "/caja/orders-view?result=true&message=" + URLEncoder.encode("Orden finalizada correctamente.", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/caja/orders-view?result=false&message=" + URLEncoder.encode("Error al finalizar la orden.", StandardCharsets.UTF_8);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    redirect = "/caja/orders-view?result=false&message=" + URLEncoder.encode("Error al finalizar la orden: " + e.getMessage(), StandardCharsets.UTF_8);
                }
                break;
            case "/caja/update-statusend":
                try {
                    String orderIdStr = req.getParameter("id_order_");
                    long orderId = Long.parseLong(orderIdStr);
                    System.out.println(orderId);
                    boolean result = new DaoOrder().updateLastStatus(orderId);

                    if (result) {
                        redirect = "/caja/orders-view?result=true&message=" + URLEncoder.encode("Orden finalizada correctamente.", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/caja/orders-view?result=false&message=" + URLEncoder.encode("Error al finalizar la orden.", StandardCharsets.UTF_8);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    redirect = "/caja/orders-view?result=false&message=" + URLEncoder.encode("Error al finalizar la orden: " + e.getMessage(), StandardCharsets.UTF_8);
                }
                break;
        }

        resp.sendRedirect(req.getContextPath()
                + redirect);
    }

}
