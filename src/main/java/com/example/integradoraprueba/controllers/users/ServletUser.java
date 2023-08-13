package com.example.integradoraprueba.controllers.users;

import com.example.integradoraprueba.models.Address.Address;
import com.example.integradoraprueba.models.Role.Role;
import com.example.integradoraprueba.models.user.DaoUser;
import com.example.integradoraprueba.models.user.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.rmi.ServerException;
import java.sql.SQLException;
import java.util.List;

import static java.lang.Long.parseLong;

@WebServlet(name = "users", urlPatterns = {
        "/user/users",
        "/user/user",
        "/user/login",
        "/user/user-view",
        "/user/user-views",
        "/user/main",
        "/user/save",
        "/user/save-view",
        "/user/user-view-update",
        "/user/update",
        "/user/delete",
})


public class ServletUser extends HttpServlet {
    private String action;
    private String redirect = "/user/main";
    User user;
    HttpSession session;
    private String roleId, addressId, phoneId;
    private String id_user, name, mail, lastname, surname, curp, rfc, sex, username, password, phone_number;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/user/main":
                redirect = "/views/admins/admin-main.jsp";
                break;
            case "/user/save-view":
                redirect = "/views/admins/admin-user-add.jsp";
                break;
            case "/user/user-view":
                List<User> users = new DaoUser().findAll();
                req.setAttribute("users", users);
                req.setAttribute("roles", new DaoUser().searchRole());
                redirect = "/views/admins/admin-user-view.jsp";
                break;

            case "/user/login":
                redirect = "/index.jsp";
                break;
        }

        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServerException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        action = req.getServletPath();
        switch (action) {
            case "/user/main":
                username = req.getParameter("username");
                password = req.getParameter("password");
                try {
                    user = new DaoUser().loadUserByUsernameAndPassword(username, password);
                    if (user != null) {
                        session = req.getSession();
                        session.setAttribute("user", user);
                        session.setAttribute("id_user", user.getId_user());
                        switch (user.getRole().getRole()) {
                            case "gerente":
                                redirect = "/user/main";
                                break;
                            case "cliente":
                                redirect = "/client/main";
                                break;
                            case "recepcion":
                                redirect = "/recepcion/main";
                                break;
                            case "mecanico":
                                redirect = "/mecanico/main";
                                break;
                            case "caja":
                                redirect = "/caja/main";
                                break;
                        }
                    } else {
                        throw new Exception("Credentials mismatch");
                    }
                } catch (Exception e) {
                    redirect = "/user/login?result=false&message=" + URLEncoder
                            .encode("Usuario y/o contraseña incorrecta",
                                    StandardCharsets.UTF_8);
                }
                break;
            case "/user/save":
                String street = req.getParameter("street");
                String neighborhood = req.getParameter("neighborhood");
                String apartment_number = req.getParameter("apartment_number");
                String street_apartment = req.getParameter("street_apartment");
                String postal_code = req.getParameter("postal_code");
                name = req.getParameter("name");
                surname = req.getParameter("surname");
                lastname = req.getParameter("lastname");
                mail = req.getParameter("mail");
                curp = req.getParameter("curp");
                rfc = req.getParameter("rfc");
                sex = req.getParameter("sex");
                phone_number = req.getParameter("phone_number");
                username = req.getParameter("username");
                password = req.getParameter("password");
                String roleId = req.getParameter("role");


                Role role = new Role();
                role.setId_role(Long.parseLong(roleId));

                Address address = new Address();
                address.setStreet(street);
                address.setNeighborhood(neighborhood);
                address.setApartment_number(apartment_number);
                address.setStreet_apartment(street_apartment);
                address.setPostal_code(postal_code);


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
                try {
                    if (new DaoUser().save(user)) {
                        redirect = "/user/user-view?result=true&message=" + URLEncoder
                                .encode("Usuario registrado correctamente", StandardCharsets.UTF_8);
                    } else {
                        throw new Exception("Error");
                    }
                } catch (Exception e) {
                    redirect = "/user/user-view?result=true&message=" + URLEncoder
                            .encode("Error guardando el usuario",
                                    StandardCharsets.UTF_8);
                    e.printStackTrace();
                }
                break;
            case "/user/update":
                // Retrieve the necessary parameters from the request
                String streets = req.getParameter("upstreet");
                String neighborhoods = req.getParameter("upneighborhood");
                String apartment_numbers = req.getParameter("upapartment_number");
                String street_apartments = req.getParameter("upstreet_apartment");
                String postal_codes = req.getParameter("uppostal_code");
                id_user = req.getParameter("upid_user");
                name = req.getParameter("upname");
                surname = req.getParameter("upsurname");
                lastname = req.getParameter("uplastname");
                mail = req.getParameter("upmail");
                curp = req.getParameter("upcurp");
                rfc = req.getParameter("uprfc");
                sex = req.getParameter("upsex");
                phone_number = req.getParameter("upphone_number");
                username = req.getParameter("upusername");
                password = req.getParameter("uppassword");
                String rolesId = req.getParameter("uprole");
                addressId = req.getParameter("upid_address");

                System.out.println(streets);
                System.out.println(neighborhoods);
                System.out.println(apartment_numbers);
                System.out.println(street_apartments);
                System.out.println(postal_codes);
                System.out.println(id_user);
                System.out.println(name);
                System.out.println(surname);
                System.out.println(lastname);
                System.out.println(mail);
                System.out.println(curp);
                System.out.println(rfc);
                System.out.println(sex);
                System.out.println(phone_number);
                System.out.println(username);
                System.out.println(password);
                System.out.println(rolesId);
                System.out.println(addressId);

                Role roles = new Role();
                roles.setId_role(Long.parseLong(rolesId));

                Address addresses = new Address();
                addresses.setId(parseLong(addressId));
                addresses.setStreet(streets);
                addresses.setNeighborhood(neighborhoods);
                addresses.setApartment_number(apartment_numbers);
                addresses.setStreet_apartment(street_apartments);
                addresses.setPostal_code(postal_codes);


                user = new User();
                user.setId_user(parseLong(id_user));
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
                user.setRole(roles);
                user.setAddress(addresses);

                try {
                    if (new DaoUser().update(user)) { // Implement update method in your DaoUser class
                        redirect = "/user/user-view?result=true&message=" + URLEncoder
                                .encode("Usuario actualizado correctamente", StandardCharsets.UTF_8);
                    } else {
                        throw new Exception("Error");
                    }
                } catch (Exception e) {
                    redirect = "/user/user-view?result=false&message=" + URLEncoder.encode("Error actualizando el usuario",StandardCharsets.UTF_8);
                    e.printStackTrace();
                }
                break;

            case "/user/delete":
                try {
                    Long id_user = parseLong(req.getParameter("id_user"));
                    // Validar que el id_user no sea el del usuario con id 1 (si lo deseas)
                    if (id_user == 1) {
                        throw new Exception("No se permite eliminar al usuario con id 1.");
                    }

                    if (new DaoUser().delete(id_user)) {
                        redirect = "/user/user-view?result=true&message=" + URLEncoder.encode("Usuario eliminado correctamente", StandardCharsets.UTF_8);
                    } else {
                        throw new Exception("Error");
                    }
                } catch (Exception e) {
                    redirect = "/user/user-view?result=true&message=" + URLEncoder.encode("Error eliminando el usuario", StandardCharsets.UTF_8);
                    e.printStackTrace();
                }
                break;
        }
        System.out.println("Action: " + action);
        System.out.println("Redirect: " + redirect);
        resp.sendRedirect(req.getContextPath()
                + redirect);
    }


}
