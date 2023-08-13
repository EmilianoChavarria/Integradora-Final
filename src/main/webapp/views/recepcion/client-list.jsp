<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>User-add</title>
    <jsp:include page="/layouts/header.jsp"/>
</head>

<body class="bg-primary-subtle" style="margin: 0;">
<!-- navbar -->
<jsp:include page="/layouts/navbar-reception.jsp"/>
<!-- body -->

<div class="container-fluid">
    <div class="card bg-transparent border-0">
        <div class="card-header bg-white mb-5 container-fluid">
            <div class="row">
                <div class="col">
                    <h3>Listado de clientes</h3>
                </div>
                <div class="col text-end">

                    <button type="button" data-bs-toggle="modal" data-bs-target="#createUser"
                            class="btn btn-outline-primary btn-sm">
                        Agregar Cliente
                    </button>


                </div>
            </div>
        </div>
        <div class="container ms-3">
            <div class="container rounded-5 p-4 bg-white mt-5" style="margin-left: 100px">
                <div>
                    <table class="table table-stripped">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Nombre Completo:</th>
                            <th>Email:</th>
                            <th>Usuario:</th>
                            <th>Rol:</th>
                            <th>Acciones:</th>
                        </tr>
                        </thead>
                        <tbody>
                        <s:forEach items="${users}" var="user" varStatus="s">
                            <tr>
                                <td>
                                    <s:out value="${s.count}"/>
                                </td>
                                <td>
                                    <s:out value="${user.name}"/> <s:out value="${user.surname}"/> <s:out
                                        value="${user.lastname}"/>
                                </td>
                                <td>
                                    <s:out value="${user.mail}"/>
                                </td>
                                <td>
                                    <s:out value="${user.username}"/>
                                </td>
                                <td>
                                    <s:out value="${user.role.role}"/>
                                </td>
                                <td>
                                    <form method="get" action="/recepcion/vehicle-view">
                                        <input hidden value="${user.id_user}" name="id_user">
                                        <button class="btn btn-outline-primary btn-sm d-inline">Visualizar vehiculos
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </s:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="createUser" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Agregar Cliente</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>


            <div class="modal-body">
                <form id="client-form" class="needs-validation" novalidate action="/recepcion/save" method="post">
                    <div class="container-fuid">
                        <div class="form-group mb-3">
                            <p class="h5 mt-3 text-secondary">Datos personales</p>
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="name" id="name"
                                               type="text"
                                               required>
                                        <label for="name">Nombre:</label>
                                        <div class="invalid-feedback is-invalid">
                                            Campo obligatorio
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="surname" id="surname"
                                               type="text"
                                               required>
                                        <label for="surname">Apellido paterno:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="lastname" id="lastname"
                                               type="text"
                                               required>
                                        <label for="lastname">Apellido materno:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="mail"
                                               id="mail"
                                               type="email" required>
                                        <label for="mail">Correo Electrónico:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="curp" id="curp"
                                               type="text" required>
                                        <label for="curp">CURP:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>

                            </div>
                        </div>


                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="rfc"
                                               id="rfc"
                                               type="text" required>
                                        <label for="rfc">RFC:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="sex" id="sex"
                                               type="text" required>
                                        <label for="sex">Sexo:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="phone_number"
                                               id="phone_number"
                                               type="text" required>
                                        <label for="phone_number">Número de telefono:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="username"
                                               id="username"
                                               type="text" required>
                                        <label for="username">Nombre de usuario:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="password" id="password"
                                               type="text" required>
                                        <label for="password">Contraseña:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>

                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="password" id="role"
                                               type="hidden" value="${role.role}" readonly required>
                                        <input type="hidden" name="id_role" value="${role.id_role}">
                                    </div>

                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <p class="h5 mt-3 text-secondary">Dirección</p>
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="street"
                                               id="street"
                                               type="text" required>
                                        <label for="street">Calle:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="neighborhood"
                                               id="neighborhood"
                                               type="text" required>
                                        <label for="neighborhood">Colonia:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="apartment_number"
                                               id="apartment_number"
                                               type="text" required>
                                        <label for="apartment_number">Número interior:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="street_apartment"
                                               id="street_apartment"
                                               type="text" required>
                                        <label for="street_apartment">Número exterior:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="postal_code" id="postal_code"
                                               type="text" required>
                                        <label for="postal_code">Código Postal:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="submit" class="btn btn-primary" onclick="sendForm(event)">Agregar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>


<jsp:include page="/layouts/footer.jsp"/>
<script>
    const sendForm = (event) => {
        event.preventDefault();

        const form = document.getElementById('client-form'); // Obtener referencia al formulario por su id

        Swal.fire({
            title: '¿Seguro de realizar la acción?',
            text: "Favor de esperar a que termine la acción...",
            icon: 'warning',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Aceptar'
        }).then((result) => {
            if (result.isConfirmed) {
                form.classList.add("was-validated");
                if (!form.checkValidity()) {
                    Swal.fire('Error', 'Por favor, completa todos los campos requeridos', 'error');
                } else {
                    Swal.fire({
                        title: 'Éxito',
                        text: 'Cliente almacenado correctamente',
                        icon: 'success',
                        timer: 1100,
                        showConfirmButton: false
                    }).then(() => {
                        form.submit();
                    });
                }
            }
        })
    }
</script>
</body>
</html>