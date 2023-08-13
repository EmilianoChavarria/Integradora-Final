package com.example.integradoraprueba.models.Address;

public class Address {
    private Long id;
    private String street;
    private String neighborhood;
    private String apartment_number;
    private String street_apartment;
    private String postal_code;

    public Address() {
    }

    public Address(Long id, String street, String neighborhood, String apartment_number, String street_apartment, String postal_code) {
        this.id = id;
        this.street = street;
        this.neighborhood = neighborhood;
        this.apartment_number = apartment_number;
        this.street_apartment = street_apartment;
        this.postal_code = postal_code;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getNeighborhood() {
        return neighborhood;
    }

    public void setNeighborhood(String neighborhood) {
        this.neighborhood = neighborhood;
    }

    public String getApartment_number() {
        return apartment_number;
    }

    public void setApartment_number(String apartment_number) {
        this.apartment_number = apartment_number;
    }

    public String getStreet_apartment() {
        return street_apartment;
    }

    public void setStreet_apartment(String street_apartment) {
        this.street_apartment = street_apartment;
    }

    public String getPostal_code() {
        return postal_code;
    }

    public void setPostal_code(String postal_code) {
        this.postal_code = postal_code;
    }
}
