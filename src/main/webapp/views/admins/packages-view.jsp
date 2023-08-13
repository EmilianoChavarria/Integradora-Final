<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>User-add</title>
    <jsp:include page="/layouts/header.jsp"/>
</head>

<body class="bg-primary-subtle row">
<!-- navbar -->
<jsp:include page="/layouts/navbar.jsp"/>
<!-- body -->
<div class="container-fluid">
    <div class="card bg-transparent border-0">
        <div class="card-header bg-white mb-5">
            <div class="row">
                <div class="col">Listado de Paquetes</div>
                <div class="col text-end">

                    <button type="button" data-bs-toggle="modal" data-bs-target="#createVehicle"
                            class="btn btn-primary btn-sm">
                        Agregar Paquetes
                    </button>


                </div>
            </div>
        </div>
        <div class="container ms-3">

            <div class="form-group mb-3">
                <div class="row">
                    <s:choose>
                        <s:when test="${empty packageView}">
                            <div class="row">
                                <h1 class="text-center">
                                    <p>No se encontraron paquetes.</p>
                                </h1>
                            </div>
                            <div class="row justify-content-center">
                                <img src="/assets/img/waasd-removebg-preview.png" alt="no_car"
                                     style="height: 150px; width: 230px">
                            </div>


                        </s:when>
                        <s:otherwise>
                            <div class="row">
                                <s:forEach items="${packageView}" var="packageCard" varStatus="loop">
                                    <div class="col-md-4 mb-4">
                                            <%--CARD--%>
                                        <div class="card mb-5" style="width: 15rem;">
                                            <div class="card-body">
                                                <div class="row">
                                                    <h5 class="card-title">
                                                        <div class="col">
                                                            <img src="../../assets/img/wrench-solid.svg" alt="wrench"
                                                                 style="height: 35px">

                                                            <input type="hidden"
                                                                   value="${packageCard.idProductPackage}">
                                                            <s:out value="${packageCard.package_name}"/>
                                                            Paquete: <s:out value="${packageCard.package_type}"/>
                                                        </div>
                                                    </h5>
                                                </div>
                                                <p class="card-text">Producto: <s:out
                                                        value="${packageCard.product_name}"/></p>
                                                <p class="card-text">Cantidad: <s:out
                                                        value="${packageCard.quantity}"/></p>
                                                <p class="card-text">Precio: $<s:out
                                                        value="${packageCard.total_price}"/></p>
                                                <!-- Botón Editar -->

                                            </div>
                                        </div>
                                    </div>
                                </s:forEach>
                            </div>
                        </s:otherwise>
                    </s:choose>
                </div>
            </div>
        </div>
    </div>


    <%----%>
    <%--    MODAL AGREGAR Paquetes--%>
    <%--    --%>

    <div class="modal fade" id="createVehicle" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Crear Paquetes</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>


                <div class="modal-body">
                    <form id="vehicle-form" class="needs-validation" novalidate action="/packages/save"
                          method="post">
                        <div class="container-fuid">
                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <select id="id_package" name="id_package" class="form-select"
                                                aria-label="Default select example" required style="height: 60px">
                                            <option selected>Paquetes disponibles:</option>
                                            <s:forEach items="${packages}" var="packageT">
                                                <option value="${packageT.id_package}">
                                                    <s:out value="${packageT.name}"/>
                                                    Tipo de paquete: <s:out value="${packageT.type_package}"/>
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
                                        <select id="id_product" name="id_product" class="form-select"
                                                aria-label="Default select example" required style="height: 60px">
                                            <option selected>Elegir producto:</option>
                                            <s:forEach items="${products}" var="product">
                                                <option value="${product.id_product}">
                                                    <s:out value="${product.name}"/>
                                                    <strong>$<s:out value="${product.price}"/></strong>
                                                </option>
                                            </s:forEach>
                                        </select>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>

                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="quantity"
                                                   id="quantity"
                                                   type="text" required>
                                            <label for="quantity">Cantidad:</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar
                                </button>
                                <button type="submit" class="btn btn-primary" onclick="sendForm(event)">Agregar
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


</div>


<jsp:include page="/layouts/footer.jsp"/>

<script>


    const fillEditForm = (vehicleData) => {
        const form = document.getElementById("vehicle-update");
        document.getElementById("upbrand").value = vehicleData.brand;
        document.getElementById("upmodel").value = vehicleData.model;
        const originalYear = vehicleData.year.substring(0, 4);
        document.getElementById("upyear").value = originalYear;
        document.getElementById("uplicense_plate").value = vehicleData.license_plate;
        document.getElementById("upcolor").value = vehicleData.color;
        document.getElementById("uptransmission").value = vehicleData.transmission;
        document.getElementById("uptype_fuel").value = vehicleData.type_fuel;
        document.getElementById("upcapacity").value = vehicleData.capacity;
        document.getElementById("upengine_number").value = vehicleData.engine_number;
        document.getElementById("upVehicleId").value = vehicleData.id_vehicle;

    };
    const fillUpForm = (formData) => {
        const form = document.getElementById("order-form");
        document.getElementById("obrand").textContent = formData.brand;
        document.getElementById("omodel").textContent = formData.model;
        document.getElementById("oVehicleId").value = formData.id_vehicle;
    };

    const confirmarEliminar = (event, vehicleId) => {
        event.preventDefault();

        Swal.fire({
            title: '¿Seguro de eliminar este vehículo?',
            text: "Esta acción no se puede deshacer",
            icon: 'warning',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Eliminar',
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
        }).then((result) => {
            if (result.isConfirmed) {
                const form = document.getElementById(`deleteVehicleForm_${vehicleId}`);
                form.submit();
            }
        });
    };

    const form = document.getElementById("vehicle-form");


    const sendForm = (event) => {
        event.preventDefault();

        Swal.fire({
            title: '¿Seguro de realizar la acción?',
            text: "Favor de esperar a que termine la acción...",
            icon: 'warning',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Aceptar'
        }).then((result) => {
            if (result.isConfirmed) {
                const form = document.getElementById('vehicle-form');
                form.classList.add("was-validated");
                if (!form.checkValidity()) {
                    Swal.fire('Error', 'Por favor, completa todos los campos requeridos', 'error');
                } else {
                    Swal.fire({
                        title: 'Éxito',
                        text: 'Paquete almacenado correctamente',
                        icon: 'success',
                        timer: 1000,
                        showConfirmButton: false
                    }).then(() => {
                        form.submit();
                    });
                }
            }
        });
    };

    //Aviso de actualizar
    const sendFormUpdate = (event) => {
        event.preventDefault();

        const form = document.getElementById('vehicle-update');

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
                        text: 'Vehiculo actualizado correctamente',
                        icon: 'success',
                        timer: 1000,
                        showConfirmButton: false
                    }).then(() => {
                        form.submit();
                    });
                }
            }
        });
    };

    const editButtons = document.querySelectorAll(".btn[data-bs-target='#updateVehicle']");
    editButtons.forEach((button) => {
        button.addEventListener("click", () => {
            const vehicleData = {
                brand: button.dataset.brand,
                model: button.dataset.model,
                year: button.dataset.year,
                license_plate: button.dataset.license_plate,
                color: button.dataset.color,
                transmission: button.dataset.transmission,
                type_fuel: button.dataset.type_fuel,
                capacity: button.dataset.capacity,
                engine_number: button.dataset.engine_number,
                id_vehicle: button.dataset.id_vehicle
            };
            fillEditForm(vehicleData);
        });
    });
    const editButtons1 = document.querySelectorAll(".btn[data-bs-target='#orderModal']");
    editButtons1.forEach((button) => {
        button.addEventListener("click", () => {
            const formData = {
                brand: button.dataset.brand,
                model: button.dataset.model,
                id_vehicle: button.dataset.id_vehicle
            };
            fillUpForm(formData);
        });
    });


</script>
</body>
</html>


