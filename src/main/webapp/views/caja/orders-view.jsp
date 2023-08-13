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
<jsp:include page="/layouts/navbar-caja.jsp"/>

<!-- body -->







<%--tabla status 3--%>
<div class="container rounded-5 p-4 bg-white mt-5" style="margin-left: 100px">

    <div class="card">
        <div class="card-header">
            <div class="row">
                <div class="col"><strong><h3>Listado de todas las órdenes liberadas</h3></strong></div>

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
                        <c:if test="${service.order.status == 3}">
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
                                <td><strong>$${service.productPackageSummary.total_price}</strong><input type="hidden" value="${service.order.id_order}" name="id_order"></td>
                                <td>
                                    <button class="btn btn-success btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#paymentModal"
                                            data-id_order="${service.order.id_order}">
                                        Realizar Pago
                                    </button>
                                </td>
                                <td class="text-bg-danger ">LIBERADO</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </s:otherwise>
        </s:choose>
    </div>
</div>

<%--tabla status 4--%>
<div class="container rounded-5 p-4 bg-white mt-5" style="margin-left: 100px">

    <div class="card">
        <div class="card-header">
            <div class="row">
                <div class="col"><strong><h3>Listado de todas las órdenes pagadas</h3></strong></div>

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
                        <c:if test="${service.order.status == 4}">
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
                                <td class="text-bg-success ">PAGADO</td>

                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </s:otherwise>
        </s:choose>
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
                <form id="paymentForm" action="/caja/update-statusend" method="post">
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

                    <input type="hidden" id="id_order_" name="id_order_">
                    <button type="submit" class="btn btn-primary" onclick="sendPay(event)">Realizar Pago</button>

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

    const fillModal = (orderData) => {
        const form = document.getElementById("paymentForm");
        document.getElementById('id_order_').value = orderData.id_order;
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

    const sendPay = (event) => {
        event.preventDefault();

        const form = document.getElementById('paymentForm'); // Obtener referencia al formulario por su id

        Swal.fire({
            title: '¿Seguro de realizar la acción?',
            text: "Favor de esperar a que termine la acción...",
            icon: 'warning',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Aceptar'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: 'Éxito',
                    text: 'Pago realizado correctamente',
                    icon: 'success',
                    timer: 1400,
                    showConfirmButton: false
                }).then(() => {
                    form.submit();
                });
            }
        })
    }

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

    const editButtons1 = document.querySelectorAll(".btn[data-bs-target='#paymentModal']");
    editButtons1.forEach((button) => {
        button.addEventListener("click", () => {
            const orderData = {
                id_order: button.dataset.id_order
            };
            fillModal(orderData);
        });
    });

</script>
</body>
</html>