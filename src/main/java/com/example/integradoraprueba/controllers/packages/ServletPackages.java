package com.example.integradoraprueba.controllers.packages;
import com.example.integradoraprueba.models.Package.DaoPackage;
import com.example.integradoraprueba.models.Package.Package;
import com.example.integradoraprueba.models.Package.ProductPackageSummary;
import com.example.integradoraprueba.models.Package.Product_package;
import com.example.integradoraprueba.models.Products.Product;
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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "packages", urlPatterns = {
        "/packages/view",
        "/packages/save"
})
public class ServletPackages extends HttpServlet {

    private String action;
    private String redirect = "/client/main";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/packages/view":
                req.setAttribute("packages", new DaoPackage().searchPackages());
                req.setAttribute("products", new DaoPackage().findAllProducts());
                List<ProductPackageSummary> packageSummaries = new DaoPackage().findAllPackages();
                req.setAttribute("packageView", packageSummaries);
                redirect = "/views/admins/packages-view.jsp";
                break;
        }
        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/packages/save":
                try {
                String id_product = req.getParameter("id_product");
                String id_package = req.getParameter("id_package");
                String quantity = req.getParameter("quantity");

                Package packages = new Package();
                packages.setId_package(Long.parseLong(id_package));

                Product product = new Product();
                product.setId_product(Long.parseLong(id_product));

                Product_package product_package = new Product_package();
                product_package.setProduct(product);
                product_package.setPackages(packages);
                product_package.setQuantity(quantity);
                boolean result = new DaoPackage().save(product_package);

                    if (result) {
                        redirect = "/packages/view?result=true&message=" + URLEncoder
                                .encode("Paquete registrado correctamente", StandardCharsets.UTF_8);
                    } else {
                        throw new Exception("Error");
                    }
                } catch (Exception e) {
                    redirect = "/packages/view?result=true&message=" + URLEncoder
                            .encode("Error guardando el paquete",
                                    StandardCharsets.UTF_8);
                    e.printStackTrace();
                }
                break;
        }

        resp.sendRedirect(req.getContextPath()
                + redirect);
    }

}
