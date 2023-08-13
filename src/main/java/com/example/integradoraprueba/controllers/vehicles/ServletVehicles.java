package com.example.integradoraprueba.controllers.vehicles;

import com.example.integradoraprueba.models.Order.DaoOrder;
import com.example.integradoraprueba.models.Order.Order;
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
import java.util.List;

@WebServlet(name = "vehicle",
        urlPatterns = {
                "/api/vehicle/all",
                "/api/vehicle/one",
                "/api/vehicle/user",
                "/api/vehicle/create",
                "/vehicle/view",
                "/vehicle/view2",
                "/vehicle/view3",
                "/api/vehicle/save",
                "/api/vehicle/save-order",
                "/api/vehicle/delete",
                "/api/vehicle/edit",
                "/api/vehicle/update",
                "/api/vehicle/enable-disable"
        })
public class ServletVehicles extends HttpServlet {
    private String action;
    private String redirect = "/api/vehicle/all";
    private Long id_user;
    private String vehicleId;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/api/vehicle/all":
                redirect = "/views/admins/vehicle-view.jsp";
                break;
            case "/vehicle/view":
                req.setAttribute("users", new DaoUser().findAllClients());
                redirect = "/views/admins/vehicle-add.jsp";
                break;
            case "/vehicle/view2":
                // id_user = req.getParameter("id_user");
//                long id_user = Long.parseLong(req.getParameter("id_user"));
//                String id_userS = String.valueOf(id_user);
//                List<Vehicle> vehicles = new DaoVehicle().findVehicleByUser(id_user);
                long id_user = Long.parseLong(req.getParameter("id_user"));
                System.out.println(id_user);
                List<Vehicle> vehicles = new DaoVehicle().findVehicleByUser(id_user);
                req.setAttribute("vehicles", vehicles);
                req.setAttribute("id_usuario", id_user);
                redirect = "/api/vehicle/all";
                break;
            case "/vehicle/view3":
                redirect = "/vehicle/view3";
                break;
        }
        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        action = req.getServletPath();
        switch (action) {

            case "/api/vehicle/save":
                // Obtener los datos del formulario
                try {

                    String brand = req.getParameter("brand");
                    String model = req.getParameter("model");
                    String year = req.getParameter("year");
                    String licensePlate = req.getParameter("license_plate");
                    String color = req.getParameter("color");
                    String transmission = req.getParameter("transmission");
                    String typeFuel = req.getParameter("type_fuel");
                    String capacity = req.getParameter("capacity");
                    String engineNumber = req.getParameter("engine_number");
                    Long userId = Long.parseLong(req.getParameter("id_user"));


                    Vehicle vehicle = new Vehicle();
                    vehicle.setBrand(brand);
                    vehicle.setModel(model);
                    vehicle.setYear(year);
                    vehicle.setLicense_plate(licensePlate);
                    vehicle.setColor(color);
                    vehicle.setTransmission(transmission);
                    vehicle.setType_fuel(typeFuel);
                    vehicle.setCapacity(capacity);
                    vehicle.setEngine_number(engineNumber);
                    User user = new User();
                    user.setId_user(userId);
                    vehicle.setUser(user);
                    boolean result = new DaoVehicle().saveVehicle(vehicle);
                    if (result) {
                        redirect = "/vehicle/view2?id_user=" + userId + "&result= " + result + "&message=" + URLEncoder.encode("¡Éxito! Vehiculo registrado correctamente.", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/vehicle/view2?id_user=" + userId + "&result= " + result + "&message=" + URLEncoder.encode("¡Error! Acción no realizada correctamente.", StandardCharsets.UTF_8);
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }

                break;
            case "/api/vehicle/update":
                try {
                    String vehicleId = req.getParameter("id_vehicle");
                    String userId = req.getParameter("id_user");
                    String brand = req.getParameter("brand");
                    String model = req.getParameter("model");
                    String year = req.getParameter("year");
                    String licensePlate = req.getParameter("license_plate");
                    String color = req.getParameter("color");
                    String transmission = req.getParameter("transmission");
                    String typeFuel = req.getParameter("type_fuel");
                    String capacity = req.getParameter("capacity");
                    String engineNumber = req.getParameter("engine_number");

                    System.out.println("-------------------------------------");
                    System.out.println(vehicleId);
                    System.out.println(brand);
                    System.out.println(model);
                    System.out.println(year);
                    System.out.println(licensePlate);
                    System.out.println(color);
                    System.out.println(transmission);
                    System.out.println(typeFuel);
                    System.out.println(capacity);
                    System.out.println(engineNumber);

                    Vehicle vehicle = new Vehicle();
                    vehicle.setId_vehicle(Long.parseLong(vehicleId));
                    vehicle.setBrand(brand);
                    vehicle.setModel(model);
                    vehicle.setYear(year);
                    vehicle.setLicense_plate(licensePlate);
                    vehicle.setColor(color);
                    vehicle.setTransmission(transmission);
                    vehicle.setType_fuel(typeFuel);
                    vehicle.setCapacity(capacity);
                    vehicle.setEngine_number(engineNumber);
                    User user = new User();
                    user.setId_user(Long.parseLong(userId));
                    vehicle.setUser(user);
                    boolean result =new DaoVehicle().updateVehicle(vehicle);

                    if (result) {
                        redirect = "/vehicle/view2?id_user=" + userId + "&result= " + result + "&message=" + URLEncoder.encode("¡Éxito! Vehiculo modificado correctamente.", StandardCharsets.UTF_8);

                    } else {
                        redirect = "/vehicle/view2?id_user=" + userId + "&result= " + result + "&message=" + URLEncoder.encode("¡Error! Acción no realizada correctamente.", StandardCharsets.UTF_8);
                                          }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            case "/api/vehicle/delete":
                try {

                    Long id_vehicle = Long.parseLong(req.getParameter("id_vehicle"));
                    Long id = Long.parseLong(req.getParameter("id"));
                    boolean result = new DaoVehicle().deleteVehicle(id_vehicle);

                    if (result) {
                        redirect = "/vehicle/view2?id_user=" + id + "&id_vehicle=" + id_vehicle + "&result=" + result + "&message=" + URLEncoder.encode("¡Vehiculo eliminado correctamente.", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/vehicle/view2?id_user=" + id + "&id_vehicle=" + id_vehicle + "&result=" + result + "&message=" + URLEncoder.encode("¡Error al eliminar el vehiculo.", StandardCharsets.UTF_8);
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                break;

        }
        resp.sendRedirect(req.getContextPath()
                + redirect);
    }

}
