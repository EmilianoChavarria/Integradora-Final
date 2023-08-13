package com.example.integradoraprueba.models.Package;

import com.example.integradoraprueba.models.Products.Product;

public class Product_package {
    private Long id_product_package;
    private Product product;
    private Package packages;
    private String quantity;

    public Product_package() {
    }

    public Product_package(Long id_product_package, Product product, Package packages, String quantity) {
        this.id_product_package = id_product_package;
        this.product = product;
        this.packages = packages;
        this.quantity = quantity;
    }

    public Long getId_product_package() {
        return id_product_package;
    }

    public void setId_product_package(Long id_product_package) {
        this.id_product_package = id_product_package;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Package getPackages() {
        return packages;
    }

    public void setPackages(Package packages) {
        this.packages = packages;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }
}
