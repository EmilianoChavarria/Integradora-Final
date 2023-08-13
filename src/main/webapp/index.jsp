<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <title>Login</title>
    <jsp:include page="/layouts/header.jsp"/>
</head>

<body class="bg-primary-subtle" >
<div class="bg-white p-3 fw-semibold" style="height: 65px;">
    <div class="d-inline ms-3">
        <img class="img" src="./assets/img/sima-icon.png" alt="">
    </div>
    <div class="d-inline ms-3 h5 ">SIGMA - Sistema de Gestión de Mantenimiento a Automóviles</div>

</div>
<div class="container rounded-5 p-5" style="width: 400px; text-align: center; margin-top: 100px; height: 430px; background-color: rgb(255, 255, 255);">
    <img src="/assets/img/icono.png" alt="" style="width: 80px;">
    <div class="text-center fs-2 fw-bold mb-3">Iniciar sesión</div>
    <form id="user-form" method="post" action="/user/main" novalidate class="needs-validation">
        <div class="input-group">
            <div class="input-group-text bg-primary-subtle">
                <img src="/assets/img/usuario.png" alt="">
            </div>
            <input class="form-control " type="text" placeholder="Nombre de usuario" name="username" id="username" required/>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
        <div class="input-group mt-3">
            <div class="input-group-text bg-primary-subtle">
                <img src="/assets/img/candado.png" alt="">
            </div>
            <input class="form-control" type="password" name="password" id="password" placeholder="Contraseña" required/>
            <div class="invalid-feedback">Campo obligatorio</div>
        </div>
        <div>
            <button id="login" type="submit" class="btn bg-primary text-white w-100 mt-4 fw-semibold">Iniciar sesión</button>
        </div>

    </form>







</div>

<jsp:include page="./layouts/footer.jsp"/>
<script>
    window.addEventListener("DOMContentLoaded", () => {
        const form = document.getElementById("user-form");
        const btn = document.getElementById("login");
        form.addEventListener("submit", function (event){
            btn.innerHTML = `<div class="d-flex justify-content-center">
                                <div class="spinner-border" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>`;
            btn.classList.add("disabled");
            if (!form.checkValidity()){
                event.preventDefault();
                event.stopPropagation();
                btn.classList.remove("disabled");
            }
            form.classList.add("was-validated");

        }, false);
        if (!${param['result']}) {
            Swal.fire({
                title: 'Acceso denegado',
                text: '${param['message']}',
                icon: 'error',
                confirmButtonText: 'Aceptar'
            });
        }
    }, false);
</script>
</body>

</html>