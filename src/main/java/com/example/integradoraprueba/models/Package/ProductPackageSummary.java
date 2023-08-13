package com.example.integradoraprueba.models.Package;

public class ProductPackageSummary {
    private Long idProductPackage;
    private String product_name;
    private String package_name;
    private String package_type;
    private int quantity;
    private float total_price;

    public ProductPackageSummary() {
    }

    public ProductPackageSummary(Long idProductPackage, String product_name, String package_name, String package_type, int quantity, float total_price) {
        this.idProductPackage = idProductPackage;
        this.product_name = product_name;
        this.package_name = package_name;
        this.package_type = package_type;
        this.quantity = quantity;
        this.total_price = total_price;
    }

    public Long getIdProductPackage() {
        return idProductPackage;
    }

    public void setIdProductPackage(Long idProductPackage) {
        this.idProductPackage = idProductPackage;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getPackage_name() {
        return package_name;
    }

    public void setPackage_name(String package_name) {
        this.package_name = package_name;
    }

    public String getPackage_type() {
        return package_type;
    }

    public void setPackage_type(String package_type) {
        this.package_type = package_type;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getTotal_price() {
        return total_price;
    }

    public void setTotal_price(float total_price) {
        this.total_price = total_price;
    }
}
