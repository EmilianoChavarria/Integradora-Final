<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>


<html>

<head>
    <title>User-add</title>
    <jsp:include page="/layouts/header.jsp"/>
    <style>
        .hidden {
            display: none;
        }
    </style>
</head>
<!-- body -->
<body class="bg-primary-subtle">
<!-- navbar -->
<jsp:include page="/layouts/navbar.jsp"/>
<div class="col-9">
    <div class="container rounded-5 p-4 bg-white mt-5" style="margin-left: 190px">

        <div class="card">
            <div class="card-header">
                <div class="row">
                    <div class="col"><strong><h3>Listado de todos los usuarios</h3></strong></div>
                    <div class="col text-end">
                        <button type="button" data-bs-toggle="modal" data-bs-target="#createUser"
                                class="btn btn-outline-primary btn-sm">
                            Registrar Usuario
                        </button>
                    </div>
                </div>
            </div>
        </div>
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
                            <s:out value="${user.name}"/> <s:out value="${user.surname}"/> <s:out value="${user.lastname}"/>
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

                                <div class="row">
                                    <div class="col-2">
                                        <button class="btn btn-sm d-inline edit-button" data-bs-toggle="modal" data-bs-target="#editUser"
                                                data-id_user="${user.id_user}"
                                                data-name="${user.name}"
                                                data-surname="${user.surname}"
                                                data-lastname="${user.lastname}"
                                                data-mail="${user.mail}"
                                                data-username="${user.username}"
                                                data-role="${user.role.id_role}"
                                                data-curp="${user.curp}"
                                                data-rfc="${user.rfc}"
                                                data-sex="${user.sex}"
                                                data-phone_number="${user.phone_number}"
                                                data-password="${user.password}"
                                                data-street="${user.address.street}"
                                                data-neighborhood="${user.address.neighborhood}"
                                                data-apartment_number="${user.address.apartment_number}"
                                                data-street_apartment="${user.address.street_apartment}"
                                                data-postal_code="${user.address.postal_code}"
                                                data-id_address="${user.address.id}">
                                            <img src="/assets/img/pen-to-square-solid.svg" style="height: 25px">
                                        </button>
                                    </div>
                                    <s:if test="${user.id_user != 1}">
                                    <div class="col-2 w-25">
                                        <form id="deleteUserForm_${user.id_user}"  action="/user/delete" method="post"
                                              onclick="confirmarEliminar(event, ${user.id_user})">
                                            <input type="hidden" name="id_user" value="${user.id_user}"/>
                                            <input type="hidden" name="id_user" value="${user.address.id}"/>
                                            <button class="btn btn-sm d-inline" type="submit">
                                                <img src="/assets/img/trash-solid.svg" style="height: 25px">
                                            </button>
                                        </form>
                                    </div>
                                    </s:if>
                                </div>

                        </td>

                    </tr>
                    <%--                    <tr class="hidden" id="details-${user.id_user}">--%>
                    <%--                        <td colspan="6">--%>
                    <%--                            <input type="hidden" value="${user.password}" id="password-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.curp}" id="curp-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.rfc}" id="rfc-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.sex}" id="sex-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.phone_number}" id="phone_number-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.address.street}" id="street-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.address.neighborhood}" id="neighborhood-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.address.apartment_number}" id="apartment_number-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.address.street_apartment}" id="street_apartment-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.address.postal_code}" id="postal_code-${user.id_user}">--%>
                    <%--                            <input type="hidden" value="${user.address.id}" id="address_id-${user.id_user}">--%>
                    <%--                        </td>--%>
                    <%--                    </tr>--%>
                </s:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>




<div class="modal fade" id="createUser" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Agregar Usuario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>


            <div class="modal-body">
                <form id="user-form" class="needs-validation" novalidate action="/user/save"
                      method="post">
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
                                <div class="col">
                                    <select id="role" name="role" class="form-select"
                                            aria-label="Default select example" required style="height: 60px">
                                        <option selected>Rol:</option>
                                        <s:forEach items="${roles}" var="roles">
                                            <option value="${roles.id_role}"><s:out
                                                    value="${roles.role}"/></option>
                                        </s:forEach>
                                    </select>
                                    <div class="invalid-feedback">Campo obligatorio</div>
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




<div class="modal fade" id="editUser" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="upstaticBackdropLabel">Editar Usuario</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="user-update" class="needs-validation" novalidate action="/user/update"
                      method="post">
                    <div class="container-fuid">

                        <div class="form-group mb-3">
                            <p class="h5 mt-3 text-secondary">Datos personales</p>
                            <div class="row">
                                <input hidden name="upid_user" id="upid_user">
                                <input hidden name="upid_address" id="upid_address">

                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upname" id="upname"
                                               type="text"
                                               required>
                                        <label for="upname">Nombre:</label>
                                        <div class="invalid-feedback is-invalid">
                                            Campo obligatorio
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upsurname" id="upsurname"
                                               type="text"
                                               required>
                                        <label for="upsurname">Apellido paterno:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="uplastname" id="uplastname"
                                               type="text"
                                               required>
                                        <label for="uplastname">Apellido materno:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upmail"
                                               id="upmail"
                                               type="email" required>
                                        <label for="upmail">Correo Electrónico:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upcurp" id="upcurp"
                                               type="text" required>
                                        <label for="upcurp">CURP:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>

                            </div>
                        </div>


                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="uprfc"
                                               id="uprfc"
                                               type="text" required>
                                        <label for="uprfc">RFC:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upsex" id="upsex"
                                               type="text" required>
                                        <label for="upsex">Sexo:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upphone_number"
                                               id="upphone_number"
                                               type="text" required>
                                        <label for="upphone_number">Número de telefono:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upusername"
                                               id="upusername"
                                               type="text" required>
                                        <label for="upusername">Nombre de usuario:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="uppassword" id="uppassword"
                                               type="text" required>
                                        <label for="uppassword">Contraseña:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <select id="uprole" name="uprole" class="form-select"
                                            aria-label="Default select example" required style="height: 60px">
                                        <option value="">Role</option>
                                        <s:forEach items="${roles}" var="role">
                                            <option value="${role.id_role}"><s:out
                                                    value="${role.role}"/></option>
                                        </s:forEach>
                                    </select>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>


                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <p class="h5 mt-3 text-secondary">Dirección</p>
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upstreet"
                                               id="upstreet"
                                               type="text" required>
                                        <label for="upstreet">Calle:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upneighborhood"
                                               id="upneighborhood"
                                               type="text" required>
                                        <label for="upneighborhood">Colonia:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upapartment_number"
                                               id="upapartment_number"
                                               type="text" required>
                                        <label for="upapartment_number">Número interior:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="upstreet_apartment"
                                               id="upstreet_apartment"
                                               type="text" required>
                                        <label for="upstreet_apartment">Número exterior:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating">
                                        <input class="form-control" placeholder="i" name="uppostal_code" id="uppostal_code"
                                               type="text" required>
                                        <label for="uppostal_code">Código Postal:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="button" class="btn btn-primary" id="updateUserBtn" onclick="sendFormUpdate(event)">Actualizar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>



<jsp:include page="/layouts/footer.jsp"/>
<script>


    const fillEditForm = (user) => {
        const form = document.getElementById("upuser-form");
        document.getElementById('upname').value = user.name;
        document.getElementById('upsurname').value = user.surname;
        document.getElementById('uplastname').value = user.lastname;
        document.getElementById('upmail').value = user.mail;
        document.getElementById('upcurp').value = user.curp;
        document.getElementById('uprfc').value = user.rfc;
        document.getElementById('upsex').value = user.sex;
        document.getElementById('upphone_number').value = user.phone_number;
        document.getElementById('upusername').value = user.username;
        document.getElementById('uppassword').value = user.password;
        document.getElementById('uprole').value = user.role;
        document.getElementById('upstreet').value = user.street;
        document.getElementById('upneighborhood').value = user.neighborhood;
        document.getElementById('upapartment_number').value = user.apartment_number;
        document.getElementById('upstreet_apartment').value = user.street_apartment;
        document.getElementById('uppostal_code').value = user.postal_code;
        document.getElementById('upid_user').value = user.id_user;
        document.getElementById('upid_address').value = user.id_address;
        document.getElementById('editUser').style.display = 'block';
    }



    const confirmarEliminar = (event, userId) => {
        event.preventDefault();

        Swal.fire({
            title: '¿Seguro de eliminar este usuario?',
            text: "Esta acción no se puede deshacer",
            icon: 'warning',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Eliminar',
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
        }).then((result) => {
            if (result.isConfirmed) {
                deleteUser(userId);
            }
        });
    };

    const editButtons = document.querySelectorAll(".btn[data-bs-target='#editUser']");
    editButtons.forEach((button) => {
        button.addEventListener("click", () => {
            const userData = {
                id_user: button.dataset.id_user,
                name: button.dataset.name,
                surname: button.dataset.surname,
                lastname: button.dataset.lastname,
                mail: button.dataset.mail,
                curp: button.dataset.curp,
                rfc: button.dataset.rfc,
                sex: button.dataset.sex,
                phone_number: button.dataset.phone_number,
                username: button.dataset.username,
                password: button.dataset.password,
                role: button.dataset.role,
                street: button.dataset.street,
                neighborhood: button.dataset.neighborhood,
                apartment_number: button.dataset.apartment_number,
                street_apartment: button.dataset.street_apartment,
                postal_code: button.dataset.postal_code,
                id_address: button.dataset.id_address
            };
            fillEditForm(userData);
        });
    });

    const deleteUser = (userId) => {
        const form = document.createElement("form");
        form.action = "/user/delete";
        form.method = "post";

        const hiddenInput = document.createElement("input");
        hiddenInput.type = "hidden";
        hiddenInput.name = "id_user";
        hiddenInput.value = userId;

        form.appendChild(hiddenInput);
        document.body.appendChild(form);

        form.submit();
    };

    const sendForm = (event) => {
        event.preventDefault();

        const form = document.getElementById('user-form'); // Obtener referencia al formulario por su id

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
                        text: 'Usuario almacenado correctamente',
                        icon: 'success',
                        timer: 1200,
                        showConfirmButton: false
                    }).then(() => {
                        form.submit();
                    });
                }
            }
        })
    }
    const sendFormUpdate = (event) => {
        event.preventDefault();

        const form = document.getElementById('user-update'); // Obtener referencia al formulario por su id

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
                        text: 'Usuario actualizado correctamente',
                        icon: 'success',
                        timer: 1300, // Tiempo de espera en milisegundos (1.5 segundos)
                        // timerProgressBar: true, // Muestra una barra de progreso del temporizador
                        showConfirmButton: false // Oculta el botón de "Aceptar"
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