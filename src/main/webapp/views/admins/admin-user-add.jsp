<%--
  Created by IntelliJ IDEA.
  User: aldri
  Date: 16/06/2023
  Time: 09:48 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User-add</title>
    <link rel="stylesheet" href="../assets/css/style.css" type="text/css">
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css" type="text/css">
    <script src="../assets/js/bootstrap.bundle.min.js"></script>
</head>

<body class="bg-primary-subtle">
<!-- header -->
<jsp:include page="/layouts/navbar.jsp"/>


</div>
<!-- body -->
<div class="container-fluid">
    <div class="row">
        <!-- Todo lo que va en la página, EDITAR DESDE AQUÍ -->
        <div class="col-9">
            <div class="container rounded-5 p-4 bg-white" style="width: 600px; margin-left: 400px; margin-top: 30px;  height: 600px; background-color: rgb(255, 255, 255);">

                <form id="add-user" class="needs-validation" action="/user/save" novalidate>
                    <p class="h3" style="text-align: center;">Registro de datos del usuario</p>
                    <p class="h5 mt-3 text-secondary">Datos personales</p>
                    <div class="row mt-2">
                        <div class="col d-inline">
                            <label for="name" class="fw-bold">Nombre:</label>
                            <input type="text" name="name" id="name" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                        <div class="col d-inline">
                            <label for="surname" class="fw-bold">Apellido Paterno:</label>
                            <input type="text" name="surname" id="surname" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                        <div class="col d-inline">
                            <label for="lastname" class="fw-bold">Apellido Materno:</label>
                            <input type="text" name="lastname" id="lastname" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col">
                            <label for="email" class="fw-bold">Correo Electrónico:</label>
                            <input type="email" name="email" id="email" class="form-control" style="width: 250px;"
                                   required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                        <div class="col d-inline">
                            <label for="curp" class="fw-bold">CURP:</label>
                            <input type="text" name="curp" id="curp" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col d-inline">
                            <label for="rfc" class="fw-bold">RFC:</label>
                            <input type="text" name="rfc" id="rfc" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                        <div class="col d-inline">
                            <label for="phone" class="fw-bold">Telefono:</label>
                            <input type="text" name="phone" id="phone" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                        <div class="col d-inline">
                            <label for="role" class="fw-bold">Rol en el sistema:</label>
                            <select id="role" name="role" class="form-select" aria-label="Default select example">
                                <option selected>Rol en el sistema</option>
                                <option value="1">Gerente</option>
                            </select>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                    </div>
                    <p class="h5 mt-3 text-secondary">Dirección:</p>
                    <div class="row mt-2">
                        <div class="col">
                            <label for="street" class="fw-bold">Calle:</label>
                            <input type="text" name="street" id="street" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                        <div class="col">
                            <label for="neighborhood" class="fw-bold">Colonia:</label>
                            <input type="text" name="neighborhood" id="neighborhood" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col">
                            <label for="postal_code" class="fw-bold">Código Postal:</label>
                            <input type="text" name="postal_code" id="postal_code" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                        <div class="col">
                            <label for="apartment_number" class="fw-bold">N. Exterior:</label>
                            <input type="text" name="apartment_number" id="apartment_number" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                        <div class="col">
                            <label for="street_apartment" class="fw-bold">N. Interior:</label>
                            <input type="text" name="street_apartment" id="street_apartment" class="form-control" required>
                            <div class="invalid-feedback">Campo obligatorio</div>
                        </div>
                    </div>
                    <div class="form-group mt-5">
                        <div class="row">
                            <div class="col text-center">
                                <button type="submit" class="btn btn-primary btn-m">Registrar usuario</button>
                                <a href="/user/user-view" class="btn btn-outline-danger btn-m">
                                    Cancelar
                                </a>

                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../layouts/footer.jsp"/>
<script>
    (function (){
        const form = document.getElementById("add-user");
        form.addEventListener("submit", function (event){
            if (!form.checkValidity()){
                event.preventDefault();
                event.stopPropagation();

            }
            form.classList.add("was-validated");
        }, false);
    })();
</script>
</body>

</html>
