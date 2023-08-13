package com.example.integradoraprueba.models.Products;

public class Product {
    private Long id_product;
    private String concept;
    private String price;
    private String piece;
    private String name;

    public Product() {
    }

    public Product(Long id_product, String concept, String price, String piece, String name) {
        this.id_product = id_product;
        this.concept = concept;
        this.price = price;
        this.piece = piece;
        this.name = name;
    }

    public Long getId_product() {
        return id_product;
    }

    public void setId_product(Long id_product) {
        this.id_product = id_product;
    }

    public String getConcept() {
        return concept;
    }

    public void setConcept(String concept) {
        this.concept = concept;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getPiece() {
        return piece;
    }

    public void setPiece(String piece) {
        this.piece = piece;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
