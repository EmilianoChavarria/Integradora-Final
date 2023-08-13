package com.example.integradoraprueba.models.user;

import com.example.integradoraprueba.models.Address.Address;

import com.example.integradoraprueba.models.Role.Role;

public class User {
    private Long id_user;
    private String name;
    private String mail;
    private String surname;
    private String lastname;
    private String curp;
    private String rfc;
    private String sex;

    private String username;
    private String password;

    private Role role;
    private String phone_number;
    private Address address;


    public User() {
    }

    public User(Long id_user, String name, String mail, String surname, String lastname, String curp, String rfc, String sex, String username, String password, Role role, String phone_number, Address address) {
        this.id_user = id_user;
        this.name = name;
        this.mail = mail;
        this.surname = surname;
        this.lastname = lastname;
        this.curp = curp;
        this.rfc = rfc;
        this.sex = sex;
        this.username = username;
        this.password = password;
        this.role = role;
        this.phone_number = phone_number;
        this.address = address;
    }

    public Long getId_user() {
        return id_user;
    }

    public void setId_user(Long id_user) {
        this.id_user = id_user;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getCurp() {
        return curp;
    }

    public void setCurp(String curp) {
        this.curp = curp;
    }

    public String getRfc() {
        return rfc;
    }

    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }
}




