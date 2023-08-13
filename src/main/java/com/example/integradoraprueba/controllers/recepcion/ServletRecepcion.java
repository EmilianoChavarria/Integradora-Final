package com.example.integradoraprueba.controllers.recepcion;

import com.example.integradoraprueba.models.Address.Address;
import com.example.integradoraprueba.models.Role.Role;
import com.example.integradoraprueba.models.recepcion.DaoRecepcion;
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
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

@WebServlet(name = "recepcion", urlPatterns = {
        "/recepcion/main",
        "/recepcion/view",
        "/recepcion/vehicle-view",
        "/recepcion/vehicle-save",
        "/recepcion/save"

})
public class ServletRecepcion extends HttpServlet {
    private String action;
    private String redirect = "/recepcion/main";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/recepcion/main":
                redirect = "/views/recepcion/reception-main.jsp";
                break;
            case "/recepcion/view":
                List<User> users = new DaoRecepcion().findAllClients();
                req.setAttribute("users", users);
                req.setAttribute("roles", new DaoRecepcion().searchRoleClient());
                redirect = "/views/recepcion/client-list.jsp";
                break;
                case "/recepcion/vehicle-view":
                long id_user = Long.parseLong(req.getParameter("id_user"));
                System.out.println(id_user);
                List<Vehicle> vehicles = new DaoVehicle().findVehicleByUser(id_user);
                req.setAttribute("vehicles", vehicles);
                req.setAttribute("id_usuario",id_user);
                redirect = "/views/recepcion/vehicle-view.jsp";
                break;

        }
        System.out.println("Action: " + action);
        System.out.println("Redirect: " + redirect);
        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        action = req.getServletPath();
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        switch (action){
            case "/recepcion/vehicle-save":
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
                        redirect = "/recepcion/vehicle-view?id_user=" + userId + "&result= " + result + "&message=" + URLEncoder.encode("¡Éxito! Vehiculo registrado correctamente.", StandardCharsets.UTF_8);
                    } else {
                        redirect = "/recepcion/vehicle-view?id_user=" + userId + "&result= " + result + "&message=" + URLEncoder.encode("¡Error! Acción no realizada correctamente.", StandardCharsets.UTF_8);
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }

                break;
            case "/recepcion/save":
                String street = req.getParameter("street");
                String neighborhood = req.getParameter("neighborhood");
                String apartment_number = req.getParameter("apartment_number");
                String street_apartment = req.getParameter("street_apartment");
                String postal_code = req.getParameter("postal_code");
                String name = req.getParameter("name");
                String surname = req.getParameter("surname");
                String lastname = req.getParameter("lastname");
                String mail = req.getParameter("mail");
                String curp = req.getParameter("curp");
                String rfc = req.getParameter("rfc");
                String sex = req.getParameter("sex");
                String phone_number = req.getParameter("phone_number");
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String roleIdString = req.getParameter("role");
                DaoRecepcion daoRecepcion = new DaoRecepcion();
                Role role = daoRecepcion.searchRoleClient();

                System.out.println("Street: " + street);
                System.out.println("Neighborhood: " + neighborhood);
                System.out.println("Apartment Number: " + apartment_number);
                System.out.println("Street Apartment: " + street_apartment);
                System.out.println("Postal Code: " + postal_code);
                System.out.println("Name: " + name);
                System.out.println("Surname: " + surname);
                System.out.println("Lastname: " + lastname);
                System.out.println("Mail: " + mail);
                System.out.println("Curp: " + curp);
                System.out.println("Rfc: " + rfc);
                System.out.println("Sex: " + sex);
                System.out.println("Phone Number: " + phone_number);
                System.out.println("Username: " + username);
                System.out.println("Password: " + password);


                Address address = new Address();
                address.setStreet(street);
                address.setNeighborhood(neighborhood);
                address.setApartment_number(apartment_number);
                address.setStreet_apartment(street_apartment);
                address.setPostal_code(postal_code);

                // Crear el objeto User con los datos recibidos del formulario
                User user = new User();
                user.setName(name);
                user.setSurname(surname);
                user.setLastname(lastname);
                user.setMail(mail);
                user.setCurp(curp);
                user.setRfc(rfc);
                user.setSex(sex);
                user.setPhone_number(phone_number);
                user.setUsername(username);
                user.setPassword(password);
                user.setRole(role);
                user.setAddress(address);
                user.setRole(role);
                try {
                    if (new DaoRecepcion().save(user)) {
                        redirect = "/recepcion/view?result=true&message=" + URLEncoder.encode("Usuario registrado correctamente", StandardCharsets.UTF_8);
                    } else {
                        throw new Exception("Error");
                    }
                } catch (Exception e) {
                    redirect = "/recepcion/view?result=true&message=" + URLEncoder
                            .encode("Error guardando el usuario",
                                    StandardCharsets.UTF_8);
                    e.printStackTrace();
                }
                break;
        }
        System.out.println("Action: " + action);
        System.out.println("Redirect: " + redirect);
        resp.sendRedirect(req.getContextPath() + redirect);
    }
}
