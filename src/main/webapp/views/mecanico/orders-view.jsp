<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>


<html>

<head>
    <title>User-add</title>
    <jsp:include page="/layouts/header.jsp"/>
</head>

<body class="bg-primary-subtle">
<!-- navbar -->
<jsp:include page="/layouts/navbar-mecanico.jsp"/>

<!-- body -->

<%--TABLA STATUS 1--%>
<div class="container rounded-5 p-4 bg-white mt-5" style="margin-left: 100px">

    <div class="card">
        <div class="card-header">
            <div class="row">
                <div class="col"><strong><h3>Listado de todas las órdenes recién creadas</h3></strong></div>

            </div>
        </div>
    </div>
    <div>
        <s:choose>
            <s:when test="${empty orders}">
                <div class="row">
                    <h1 class="text-center">
                        <p>No se encontraron órdenes creadas</p>
                    </h1>
                </div>
                <%--        <div class="row justify-content-center">--%>
                <%--          <img src="/assets/img/sin_carros.png" alt="no_car" style="height: 100px; width: 200px">--%>
                <%--        </div>--%>
            </s:when>

            <s:otherwise>
                <table class="table table-stripped">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre:</th>
                        <th>Vehiculo:</th>
                        <th>Status:</th>
                        <th>Mileage:</th>
                        <th>Fecha de entrada:</th>
                        <th>Acción</th>
                    </tr>
                    </thead>
                    <tbody>
                    <s:forEach items="${orders}" var="order" varStatus="s">
                        <s:if test="${order.status == 1}">
                            <tr>
                                <td><s:out value="${s.count}"/></td>
                                <td>${order.vehicle.user.name} ${order.vehicle.user.surname} ${order.vehicle.user.lastname}</td>
                                <td><s:out value="${order.vehicle.brand}"/> <s:out value="${order.vehicle.model}"/></td>
                                <td><s:out value="${order.status}"/></td>
                                <td><s:out value="${order.mileage}"/> - KM</td>
                                <td><s:out value="${order.date_entry}"/></td>
                                <td>
                                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#serviceModal"
                                            data-id_user="${order.vehicle.user.id_user}"
                                            data-id_order="${order.id_order}"
                                            data-name="${order.vehicle.user.name}"
                                            data-surname="${order.vehicle.user.surname}"
                                            data-lastname="${order.vehicle.user.lastname}"
                                            data-brand="${order.vehicle.brand}"
                                            data-model="${order.vehicle.model}"
                                            data-status="${order.status}"
                                            data-mileage="${order.mileage}"
                                            data-date_entry="${order.date_entry}">
                                        Aplicar servicio
                                    </button>
                                </td>
                                <td class="text-bg-primary ">RECIBIDO</td>
                            </tr>
                        </s:if>
                    </s:forEach>
                    </tbody>
                </table>
            </s:otherwise>
        </s:choose>
    </div>
</div>
<%--TABLA STATUS 2--%>
<div class="container rounded-5 p-4 bg-white mt-5" style="margin-left: 100px">

    <div class="card">
        <div class="card-header">
            <div class="row">
                <div class="col"><strong><h3>Listado de todas las órdenes en servicio</h3></strong></div>

            </div>
        </div>
    </div>
    <div>
        <s:choose>
            <s:when test="${empty orders}">
                <div class="row">
                    <h1 class="text-center">
                        <p>No se encontraron órdenes creadas</p>
                    </h1>
                </div>
                <%--        <div class="row justify-content-center">--%>
                <%--          <img src="/assets/img/sin_carros.png" alt="no_car" style="height: 100px; width: 200px">--%>
                <%--        </div>--%>
            </s:when>

            <s:otherwise>
                <table class="table table-stripped">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre</th>
                        <th>Vehículo</th>
                        <th>Status</th>
                        <th>Mileage</th>
                        <th>Fecha de entrada</th>
                        <th>Detalle</th>
                        <th>Paquetes</th>
                        <th>Precio</th>


                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="service" items="${services}" varStatus="s">
                        <c:if test="${service.order.status == 2}">
                            <tr>
                                <td>${s.count}</td>
                                <td>${service.order.user.name} ${service.order.user.surname} ${service.order.user.lastname}</td>
                                <td>${service.order.vehicle.brand} ${service.order.vehicle.model}</td>
                                <td>${service.order.status}</td>
                                <td>${service.order.mileage}</td>
                                <td>${service.order.date_entry}</td>
                                <td>${service.detail}</td>
                                <td>${service.productPackageSummary.package_name}
                                    (${service.productPackageSummary.package_type})
                                </td>
                                <td><strong>$${service.productPackageSummary.total_price}</strong></td>
                                <td>
                                    <form action="/mecanico/update-status" method="post">
                                        <button class="btn btn-success btn-sm">
                                            <input type="hidden" value="${service.order.id_order}" name="id_order">
                                            Finalizar orden
                                        </button>
                                    </form>
                                </td>
                                <td class="text-bg-warning text-center">EN SERVICIO</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </s:otherwise>
        </s:choose>
    </div>
</div>




<%--MODAL--%>
<div class="modal fade" id="serviceModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
     tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Datos de la Orden</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="service-form" class="needs-validation" novalidate action="/mecanico/save-service"
                      method="post">
                    <div class="container-fuid">
                        <input type="hidden" id="id_user" name="id_user">
                        <input type="hidden" id="id_order" name="id_order">
                        <div class="row">
                            <div class="col">
                                <strong class="h5">
                                    <p>
                                        Nombre:
                                        <span id="oname"></span> <span id="osurname"></span> <span
                                            id="olastname"></span>
                                    </p>
                                </strong>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">

                                <strong class="h5">
                                    <p>Vehículo:

                                        <span id="obrand"></span> <span id="omodel"></span>
                                    </p>
                                </strong>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-4">
                                <strong class="h5">
                                    <p>
                                        Status: <span id="ostatus">  </span>
                                    </p>
                                </strong>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <strong class="h5">
                                    <p>
                                        Kilometraje: <span id="omileage"> </span> Km
                                    </p>
                                </strong>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <strong class="h5">
                                    <p>
                                        Fecha de entrada: <span
                                            id="odate_entry"></span>
                                    </p>

                                </strong>
                            </div>
                        </div>

                        <hr>
                        <h4>Servicio</h4>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <select id="id_product" name="id_product" class="form-select"
                                            aria-label="Default select example" required style="height: 60px">
                                        <option selected>Elegir producto:</option>
                                        <s:forEach items="${packageView}" var="packageList">
                                            <option value="${packageList.idProductPackage}">
                                                    ${packageList.package_name} (${packageList.package_type}) -
                                                $${packageList.total_price}
                                            </option>
                                        </s:forEach>
                                    </select>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>

                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <div class="form-floating">
                                        <textarea class="form-control" placeholder="i" name="detail"
                                                  id="detail"
                                                  type="text" required style="height: 100px">
                                        </textarea>
                                        <label for="detail">Cosas Realizadas al Vehículo:</label>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar
                            </button>
                            <button type="submit" class="btn btn-primary" id="updateProductBtn"
                                    onclick="sendFormUpdate(event)">
                                Agregar
                            </button>
                        </div>


                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%--MODAL DE PAGAR--%>
<div class="modal fade" id="paymentModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
     tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="ModalToggleLabel">Ventana de Pago</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="paymentForm">
                    <div class="form-group">
                        <label for="cardNumber">Número de Tarjeta</label>
                        <input type="text" class="form-control" id="cardNumber" placeholder="1234 5678 9012 3456" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="expirationDate">Fecha de Expiración</label>
                            <input type="text" class="form-control" id="expirationDate" placeholder="MM/AA" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="cvv">CVV</label>
                            <input type="text" class="form-control" id="cvv" placeholder="123" required>
                        </div>
                    </div>
                    <div class="form-group mb-3">
                        <label for="cardHolder">Titular de la Tarjeta</label>
                        <input type="text" class="form-control" id="cardHolder" placeholder="Nombre del Titular" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Realizar Pago</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/layouts/footer.jsp"/>
<script>


    const fillOrderForm = (orderData) => {
        const form = document.getElementById("service-form");
        document.getElementById('id_user').value = orderData.id_user;
        document.getElementById('id_order').value = orderData.id_order;
        document.getElementById("oname").textContent = orderData.name;
        document.getElementById("osurname").textContent = orderData.surname;
        document.getElementById("olastname").textContent = orderData.lastname;
        document.getElementById("obrand").textContent = orderData.brand;
        document.getElementById("omodel").textContent = orderData.model;
        document.getElementById("ostatus").textContent = orderData.status;
        document.getElementById("omileage").textContent = orderData.mileage;
        document.getElementById("odate_entry").textContent = orderData.date_entry;
    };
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
    const editButtons = document.querySelectorAll(".btn[data-bs-target='#serviceModal']");
    editButtons.forEach((button) => {
        button.addEventListener("click", () => {
            const orderData = {
                id_user: button.dataset.id_user,
                id_order: button.dataset.id_order,
                name: button.dataset.name,
                surname: button.dataset.surname,
                lastname: button.dataset.lastname,
                brand: button.dataset.brand,
                model: button.dataset.model,
                status: button.dataset.status,
                mileage: button.dataset.mileage,
                date_entry: button.dataset.date_entry
            };
            fillOrderForm(orderData);
        });
    });
</script>
</body>
</html>