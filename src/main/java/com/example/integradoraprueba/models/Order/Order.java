package com.example.integradoraprueba.models.Order;

import com.example.integradoraprueba.models.user.User;
import com.example.integradoraprueba.models.vehicle.Vehicle;

public class Order {
    private Long id_order;
    private Vehicle vehicle;
    private Long status;
    private String mileage;
    private String date_entry;
    private String departure_date;
    private String payment;
    private User user;

    public Order() {
    }


    public Order(Long id_order, Vehicle vehicle, Long status, String mileage, String date_entry, String departure_date, String payment, User user) {
        this.id_order = id_order;
        this.vehicle = vehicle;
        this.status = status;
        this.mileage = mileage;
        this.date_entry = date_entry;
        this.departure_date = departure_date;
        this.payment = payment;
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Long getId_order() {
        return id_order;
    }

    public void setId_order(Long id_order) {
        this.id_order = id_order;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public void setVehicle(Vehicle vehicle) {
        this.vehicle = vehicle;
    }

    public Long getStatus() {
        return status;
    }

    public void setStatus(Long status) {
        this.status = status;
    }

    public String getMileage() {
        return mileage;
    }

    public void setMileage(String mileage) {
        this.mileage = mileage;
    }

    public String getDate_entry() {
        return date_entry;
    }

    public void setDate_entry(String date_entry) {
        this.date_entry = date_entry;
    }

    public String getDeparture_date() {
        return departure_date;
    }

    public void setDeparture_date(String departure_date) {
        this.departure_date = departure_date;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }
}
