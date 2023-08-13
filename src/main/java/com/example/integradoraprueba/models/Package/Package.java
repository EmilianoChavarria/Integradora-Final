package com.example.integradoraprueba.models.Package;

public class Package {
    private Long id_package;
    private String name, type_package;

    public Package() {
    }

    public Package(Long id_package, String name, String type_package) {
        this.id_package = id_package;
        this.name = name;
        this.type_package = type_package;
    }

    public Long getId_package() {
        return id_package;
    }

    public void setId_package(Long id_package) {
        this.id_package = id_package;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType_package() {
        return type_package;
    }

    public void setType_package(String type_package) {
        this.type_package = type_package;
    }
}
