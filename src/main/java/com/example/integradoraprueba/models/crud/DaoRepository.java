package com.example.integradoraprueba.models.crud;
import com.example.integradoraprueba.models.Address.Address;
import com.example.integradoraprueba.models.Role.Role;
import com.example.integradoraprueba.models.user.User;

import java.sql.SQLException;
import java.util.List;
public interface DaoRepository <T>{

    List<T> findAll();

    List<Role> searchRole();

    T finOne(Long id);
    boolean update(T object) throws SQLException;
    boolean delete(Long id);


}
