package com.example.integradoraprueba.controllers.cliente;

import com.example.integradoraprueba.models.Package.Package;
import com.example.integradoraprueba.models.user.DaoUser;
import com.example.integradoraprueba.models.vehicle.DaoVehicle;
import com.example.integradoraprueba.models.vehicle.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "clients", urlPatterns = {
        "/client/main",
        "/client/vehicle",
        "/client/services"
})
public class ServletClient extends HttpServlet {

    private String action;
    private String redirect = "/client/main";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/client/main":
                redirect = "/views/cliente/cliente-main.jsp";
                break;
            case "/client/vehicle":
                HttpSession session = req.getSession();
                Long id_user = (Long) session.getAttribute("id_user");
                List<Vehicle> vehicles = new DaoUser().findVehicleByIdUser(id_user);
                req.setAttribute("vehicles", vehicles);
                redirect = "/views/cliente/cliente-vehicle.jsp";
                break;
        }
        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        resp.sendRedirect(req.getContextPath()
                + redirect);
    }

}
