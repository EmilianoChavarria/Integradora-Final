package com.example.integradoraprueba.models.vehicle;

import com.example.integradoraprueba.models.user.User;

public class Vehicle {
private Long id_vehicle;
private String brand;
private String model;
private String year;
private String license_plate;
private String color;
private String transmission;
private String type_fuel;
private String capacity;
private String engine_number;
private User user;

    public Vehicle() {
    }

    public Vehicle(Long id_vehicle, String brand, String model, String year, String license_plate, String color, String transmission, String type_fuel, String capacity, String engine_number, User user) {
        this.id_vehicle = id_vehicle;
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.license_plate = license_plate;
        this.color = color;
        this.transmission = transmission;
        this.type_fuel = type_fuel;
        this.capacity = capacity;
        this.engine_number = engine_number;
        this.user = user;
    }

    public Long getId_vehicle() {
        return id_vehicle;
    }

    public void setId_vehicle(Long id_vehicle) {
        this.id_vehicle = id_vehicle;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getLicense_plate() {
        return license_plate;
    }

    public void setLicense_plate(String license_plate) {
        this.license_plate = license_plate;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getTransmission() {
        return transmission;
    }

    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }

    public String getType_fuel() {
        return type_fuel;
    }

    public void setType_fuel(String type_fuel) {
        this.type_fuel = type_fuel;
    }

    public String getCapacity() {
        return capacity;
    }

    public void setCapacity(String capacity) {
        this.capacity = capacity;
    }

    public String getEngine_number() {
        return engine_number;
    }

    public void setEngine_number(String engine_number) {
        this.engine_number = engine_number;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
