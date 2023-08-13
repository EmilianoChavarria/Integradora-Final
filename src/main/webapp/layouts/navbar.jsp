<%--
  Created by IntelliJ IDEA.
  User: aldri
  Date: 03/07/2023
  Time: 05:34 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg navbar-light bg-light" style="height: 80px">
    <div class="d-inline ms-3 m">
        <img class="img" src="/assets/img/sima-icon.png" alt="">
    </div>
    <div class="d-inline">
        <a class="navbar-brand ms-3 fw-semibold" href="/user/main">Sistema de Gestión de Mantenimiento a Automóviles</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>


    <div class="collapse navbar-collapse " id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link mt-2 ms-4 btn btn-outline-secondary" href="/user/user-view"><h5>Usuarios</h5></a>
            </li>
            <li class="nav-item active">
                <a class="nav-link mt-2 ms-4 btn btn-outline-secondary" href="/vehicle/view"><h5>Vehículos</h5></a>
            </li>
            <li class="nav-item active">
                <a class="nav-link mt-2 ms-4 btn btn-outline-secondary" href="/api/product/all"><h5>Inventario</h5></a>
            </li>
            <li class="nav-item active">
                <a class="nav-link mt-2 ms-4 btn btn-outline-secondary" href="/order/view"><h5>Órdenes</h5></a>
            </li>
            <li class="nav-item active">
                <a class="nav-link mt-2 ms-4 btn btn-outline-secondary" href="/packages/view"><h5>Paquetes</h5></a>
            </li>
        </ul>
    </div>
    <div class="d-inline text-end" style="margin-right: 40px">
        <a href="../../index.jsp" class="btn btn-danger btn-sm">
            Cerrar sesión
        </a>
    </div>
</nav>


<!-- Sidebar

<div class="col-2 sidebar" style="border-top: 1px solid #b8b8b8;">
<ul class="list-style-none">
<li>Usuarios
<ol class="mt-2">
<a class="text-decoration-none text-dark" href="/user/save-view">Agregar usuario</a>
</ol>
<ol class="mt-2">
<a class="text-decoration-none text-dark" href="/user/user-view">Visualizar usuarios</a>
</ol>
</li>
<li>Vehículos
<ol class="mt-2">
<a class="text-decoration-none text-dark" href="admin-vehicle-add.html">Agregar vehículo</a>
</ol>
<ol class="mt-2">
<a class="text-decoration-none text-dark" href="#">Visualizar vehiculos</a>
</ol>
</li>
<li>Inventario
<ol class="mt-2">
<a class="text-decoration-none text-dark" href="#">Agregar producto</a>
</ol>
<ol class="mt-2">
<a class="text-decoration-none text-dark" href="#">Visualizar productos</a>
</ol>
</li>

</ul>
</div>-->
