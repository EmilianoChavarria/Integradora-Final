package com.example.integradoraprueba.models.Service;

import com.example.integradoraprueba.models.Order.Order;
import com.example.integradoraprueba.models.Package.ProductPackageSummary;
import com.example.integradoraprueba.models.Package.Product_package;
import com.example.integradoraprueba.models.user.User;
import com.example.integradoraprueba.models.vehicle.Vehicle;

public class Service {
    private Long id_service;
    private User user;
    private Order order;
    private ProductPackageSummary ProductPackageSummary;
    private String detail;
    private Vehicle vehicle;

    public Service() {

    }

    public Service(Long id_service, User user, Order order, com.example.integradoraprueba.models.Package.ProductPackageSummary productPackageSummary, String detail, Vehicle vehicle) {
        this.id_service = id_service;
        this.user = user;
        this.order = order;
        ProductPackageSummary = productPackageSummary;
        this.detail = detail;
        this.vehicle = vehicle;
    }

    public Long getId_service() {
        return id_service;
    }

    public void setId_service(Long id_service) {
        this.id_service = id_service;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public com.example.integradoraprueba.models.Package.ProductPackageSummary getProductPackageSummary() {
        return ProductPackageSummary;
    }

    public void setProductPackageSummary(com.example.integradoraprueba.models.Package.ProductPackageSummary productPackageSummary) {
        ProductPackageSummary = productPackageSummary;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public void setVehicle(Vehicle vehicle) {
        this.vehicle = vehicle;
    }
}
