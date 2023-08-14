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
                <div class="col">Listado</div>
                <div class="col text-end">

                    <button type="button" data-bs-toggle="modal" data-bs-target="#createVehicle"
                            class="btn btn-outline-primary btn-sm">
                        Agregar Vehículo
                    </button>
                </div>
            </div>
        </div>
        <div class="container ms-3">
            <div class="form-group mb-3">
                <div class="row">
                    <s:choose>
                        <s:when test="${empty vehicles}">
                            <div class="row">
                                <h1 class="text-center">
                                    <p>No se encontraron vehículos para este usuario.</p>
                                </h1>
                            </div>
                            <div class="row justify-content-center">
                                <img src="/assets/img/sin_carros.png" alt="no_car" style="height: 100px; width: 200px">
                            </div>
                        </s:when>
                        <s:otherwise>
                            <input type="hidden" value="${id_usuario}" name="id_user">
                            <s:forEach items="${vehicles}" var="vehicle" varStatus="loop">
                                <div class="col">
                                        <%--CARD--%>
                                    <div class="card mb-5" style="width: 15rem;">
                                        <div class="card-body">
                                            <div class="row">
                                                <h5 class="card-title">
                                                    <div class="col">
                                                        <img src="../../assets/img/carrito.svg" alt="carrito"
                                                             style="height: 45px">
                                                    </div>
                                                    <div class="col"><s:out value="${vehicle.brand}"/> <s:out
                                                            value="${vehicle.model}"/></div>
                                                </h5>
                                            </div>
                                            <p class="card-text">Año: ${fn:substring(vehicle.year, 0, 4)}</p>
                                            <p class="card-text">Placa: <s:out value="${vehicle.license_plate}"/></p>
                                            <p class="card-text">Color: <s:out value="${vehicle.color}"/></p>
                                            <!-- Botón Editar -->
                                            <div class="row">
                                                <div class="col-3">
                                                    <button type="button" class="btn btn-sm" data-bs-toggle="modal"
                                                            data-bs-target="#updateVehicle"
                                                            data-id_vehicle="${vehicle.id_vehicle}"
                                                            data-brand="${vehicle.brand}"
                                                            data-model="${vehicle.model}"
                                                            data-year="${vehicle.year}"
                                                            data-license_plate="${vehicle.license_plate}"
                                                            data-color="${vehicle.color}"
                                                            data-transmission="${vehicle.transmission}"
                                                            data-type_fuel="${vehicle.type_fuel}"
                                                            data-capacity="${vehicle.capacity}"
                                                            data-engine_number="${vehicle.engine_number}">
                                                        <img src="/assets/img/pen-to-square-solid.svg"
                                                             style="height: 30px">
                                                    </button>
                                                </div>
                                                <div class="col-3">
                                                    <form id="deleteVehicleForm_${vehicleId}"
                                                          action="/api/vehicle/delete" method="post"
                                                          onclick="confirmarEliminar(event, ${vehicle.id_vehicle})">
                                                        <input hidden value="${vehicle.id_vehicle}" name="id_vehicle">
                                                        <input hidden value="${id_usuario}" name="id">
                                                        <button type="submit" class="btn btn-sm">
                                                            <img src="/assets/img/trash-solid.svg" style="height: 30px">
                                                        </button>
                                                    </form>
                                                </div>
                                                <div class="col">
                                                    <form action="/order/create-order" method="post"></form>
                                                    <input hidden value="${vehicle.id_vehicle}" name="id_vehicle">
                                                    <button class="btn btn-sm" data-bs-toggle="modal"
                                                            data-bs-target="#orderModal"
                                                            data-id_vehicle="${vehicle.id_vehicle}"
                                                            data-brand="${vehicle.brand}"
                                                            data-model="${vehicle.model}">
                                                        <img src="/assets/img/screwdriver-wrench-solid.svg"
                                                             style="height: 35px">
                                                    </button>
                                                </div>

                                            </div>

                                        </div>
                                            <%--                                        ACORDEÓN, MOSTRAR MÁS INFORMACiÓN--%>
                                        <div class="accordion accordion-flush rounded-5"
                                             id="accordionFlushExample_${loop.index}">
                                            <div class="accordion-item">
                                                <h2 class="accordion-header">
                                                    <button class="accordion-button collapsed" type="button"
                                                            data-bs-toggle="collapse"
                                                            data-bs-target="#collapseOne_${loop.index}"
                                                            aria-expanded="false"
                                                            aria-controls="collapseOne_${loop.index}">
                                                        <p class="text-danger">Más información</p>
                                                    </button>
                                                </h2>
                                                <div id="collapseOne_${loop.index}" class="accordion-collapse collapse "
                                                     data-bs-parent="#accordionFlushExample_${loop.index}">
                                                    <div class="accordion-body">
                                                        <p class="card-text">Transmisión: <s:out
                                                                value="${vehicle.transmission}"/></p>
                                                        <p class="card-text">Combustible: <s:out
                                                                value="${vehicle.type_fuel}"/></p>
                                                        <p class="card-text">Capacidad: <s:out
                                                                value="${vehicle.capacity}"/></p>
                                                        <p class="card-text">Número de motor: <s:out
                                                                value="${vehicle.engine_number}"/></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </s:forEach>
                        </s:otherwise>
                    </s:choose>
                </div>
            </div>
        </div>
    </div>
    <%--Modal de un campo--%>
    <div class="modal fade" id="orderModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel"
         tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Orden para el vehículo</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="order-form" class="needs-validation" novalidate action="/order/save-order"
                          method="post">
                        <div class="container-fuid">
                            <div class="form-group mb-3">
                                <div class="row">
                                    <input type="hidden" value="${id_usuario}" name="id_user">
                                    <input type="hidden" id="oVehicleId" name="id_vehicle"
                                           value="${vehicle.id_vehicle}">
                                    <div class="row">
                                        <strong class="h4">
                                            <p>
                                                <span id="obrand"></span> <span id="omodel"></span>
                                            </p>
                                        </strong>
                                    </div>
                                    <div class="row">
                                        <div class="col-8 mb-3">
                                            <div class="form-floating">
                                                <input class="form-control" placeholder="i" name="mileage" id="mileage"
                                                       type="text" required>
                                                <label for="mileage">Kilometraje</label>
                                                <div class="invalid-feedback is-invalid">
                                                    Campo obligatorio
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%--                                <div class="modal-footer">--%>
                                    <%--                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar--%>
                                    <%--                                    </button>--%>
                                    <%--                                    <button type="submit" class="btn btn-primary" onclick="sendForm(event)">Agregar--%>
                                    <%--                                    </button>--%>
                                    <%--                                </div>--%>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">
                                Agregar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <%----%>
    <%--    MODAL AGREGAR VEHICULOS--%>
    <%--    --%>

    <div class="modal fade" id="createVehicle" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Agregar Vehiculos</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>


                <div class="modal-body">
                    <form id="vehicle-form" class="needs-validation" novalidate action="/api/vehicle/save"
                          method="post">
                        <div class="container-fuid">
                            <input type="hidden" value="${id_usuario}" name="id_user">
                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="brand" id="brand"
                                                   type="text"
                                                   required>
                                            <label for="brand">Marca</label>
                                            <div class="invalid-feedback is-invalid">
                                                Campo obligatorio
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="model" id="model"
                                                   type="text"
                                                   required>
                                            <label for="model">Modelo</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="year" id="year"
                                                   type="text"
                                                   required>
                                            <label for="year">Año</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="license_plate"
                                                   id="license_plate"
                                                   type="text" required>
                                            <label for="license_plate">Placa</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="color" id="color"
                                                   type="text" required>
                                            <label for="color">Color</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="transmission"
                                                   id="transmission" type="text"
                                                   required>
                                            <label for="transmission">Transmisión:</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="type_fuel"
                                                   id="type_fuel"
                                                   type="text" required>
                                            <label for="type_fuel">Tipo de combustible</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="capacity"
                                                   id="capacity"
                                                   type="text"
                                                   required>
                                            <label for="capacity">Capacidad:</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="engine_number"
                                                   id="engine_number"
                                                   type="text"
                                                   required>
                                            <label for="engine_number">Número de motor:</label>
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


    <!-- MODAL UPDATE-->
    <div class="modal fade" id="updateVehicle" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="upStaticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="upStaticBackdropLabel">Editar información de Vehículos</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>


                <div class="modal-body">
                    <form id="vehicle-update" class="needs-validation" novalidate action="/api/vehicle/update"
                          method="post">
                        <div class="container-fuid">
                            <input type="hidden" value="${id_usuario}" name="id_user">
                            <input type="hidden" id="upVehicleId" name="id_vehicle" value="${vehicle.id_vehicle}">
                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="brand" id="upbrand"
                                                   type="text"
                                                   required>
                                            <label for="upbrand">Marca</label>
                                            <div class="invalid-feedback is-invalid">
                                                Campo obligatorio
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="model" id="upmodel"
                                                   type="text"
                                                   required>
                                            <label for="upmodel">Modelo</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="year" id="upyear"
                                                   type="text"
                                                   required>
                                            <label for="upyear">Año</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="license_plate"
                                                   id="uplicense_plate"
                                                   type="text" required>
                                            <label for="uplicense_plate">Placa</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="color" id="upcolor"
                                                   type="text" required>
                                            <label for="upcolor">Color</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="transmission"
                                                   id="uptransmission" type="text"
                                                   required>
                                            <label for="uptransmission">Transmisión:</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="type_fuel"
                                                   id="uptype_fuel"
                                                   type="text" required>
                                            <label for="uptype_fuel">Tipo de combustible</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="capacity"
                                                   id="upcapacity"
                                                   type="text"
                                                   required>
                                            <label for="upcapacity">Capacidad:</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="form-floating">
                                            <input class="form-control" placeholder="i" name="engine_number"
                                                   id="upengine_number"
                                                   type="text"
                                                   required>
                                            <label for="upengine_number">Número de motor:</label>
                                            <div class="invalid-feedback">Campo obligatorio</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar
                                </button>
                                <button type="submit" class="btn btn-primary" id="updateVehicleBtn"
                                        onclick="sendFormUpdate (event)">
                                    Actualizar
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
                        text: 'Vehiculo almacenado correctamente',
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


