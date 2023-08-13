package com.example.integradoraprueba.controllers.order;

import com.example.integradoraprueba.models.Order.DaoOrder;
import com.example.integradoraprueba.models.Order.Order;
import com.example.integradoraprueba.models.Package.DaoPackage;
import com.example.integradoraprueba.models.Package.ProductPackageSummary;
import com.example.integradoraprueba.models.Package.Product_package;
import com.example.integradoraprueba.models.Service.Service;
import com.example.integradoraprueba.models.user.User;
import com.example.integradoraprueba.models.vehicle.DaoVehicle;
import com.example.integradoraprueba.models.vehicle.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "order", urlPatterns = {
        "/order/save-order",
        "/order/view",
        "/order/save-service",
        "/order/update-status",
        "/order/update-statusend"
})
public class ServletOrder extends HttpServlet {

    private String action;
    private String redirect = "/order/view";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/order/view":
                List<Order> orders = new DaoOrder().findAllOrders();
                req.setAttribute("orders", orders);
                List<ProductPackageSummary> packageSummaries = new DaoPackage().findAllPackages();
                req.setAttribute("packageView", packageSummaries);
                List<Service> services = new DaoOrder().findAllServices();
                req.setAttribute("services", services);
                redirect = "/views/admins/orders-view.jsp";
                break;

        }
        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/order/save-order":
                try {
                    // obtener los datos desde el formulario
                    String id_vehicle = req.getParameter("id_vehicle");
                    String mileage = req.getParameter("mileage");

                    Vehicle vehicle = new Vehicle();
                    vehicle.setId_vehicle(Long.parseLong(id_vehicle));

                    // Crear una instancia de Order con los datos recibidos
                    Order order = new Order();
                    order.setVehicle(vehicle);
                    order.setMileage(mileage);


                    boolean result = new DaoOrder().save(order);

                    if (result) {
                        redirect = "/order/view?&result=true&message=" + URLEncoder.encode("¡Éxito! Orden almacenada correctamente.",
                                StandardCharsets.UTF_8);
                    } else {
                        redirect = "/order/view?&result=false&message=" + URLEncoder.encode("¡Error! Orden no almacenada correctamente.",
                                StandardCharsets.UTF_8);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    resp.getWriter().write("Error processing order data: " + e.getMessage());
                }
                break;
            case "/order/save-service":
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
                        redirect = "/order/view?result=true&message=" + URLEncoder
                                .encode("Servicio registrado correctamente", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/order/view?result=false&message=" + URLEncoder
                                .encode("Error guardando el servicio", StandardCharsets.UTF_8);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    redirect = "/order/view?result=false&message=" + URLEncoder
                            .encode("Error guardando el servicio: " + e.getMessage(),
                                    StandardCharsets.UTF_8);
                }
                break;
            case "/order/update-status":
                try {
                    String orderIdStr = req.getParameter("id_order");
                    long orderId = Long.parseLong(orderIdStr);
                    System.out.println(orderId);
                    boolean result = new DaoOrder().updateOrder(orderId);

                    if (result) {
                        redirect = "/order/view?result=true&message=" + URLEncoder.encode("Orden finalizada correctamente.", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/order/view?result=false&message=" + URLEncoder.encode("Error al finalizar la orden.", StandardCharsets.UTF_8);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    redirect = "/order/view?result=false&message=" + URLEncoder.encode("Error al finalizar la orden: " + e.getMessage(), StandardCharsets.UTF_8);
                }
                break;
            case "/order/update-statusend":
                try {
                    String orderIdStr = req.getParameter("id_order_");
                    long orderId = Long.parseLong(orderIdStr);
                    System.out.println(orderId);
                    boolean result = new DaoOrder().updateLastStatus(orderId);

                    if (result) {
                        redirect = "/order/view?result=true&message=" + URLEncoder.encode("Orden finalizada correctamente.", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/order/view?result=false&message=" + URLEncoder.encode("Error al finalizar la orden.", StandardCharsets.UTF_8);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    redirect = "/order/view?result=false&message=" + URLEncoder.encode("Error al finalizar la orden: " + e.getMessage(), StandardCharsets.UTF_8);
                }
                break;
        }

        resp.sendRedirect(req.getContextPath()
                + redirect);
    }
}
