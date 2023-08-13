<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>User-add</title>
    <jsp:include page="/layouts/header.jsp"/>
</head>

<body class="bg-primary-subtle row">
<!-- navbar -->
<jsp:include page="/layouts/navbar-client.jsp"/>
<!-- body -->
<div class="container-fluid">
    <div class="card bg-transparent border-0">
        <div class="card-header bg-white mb-5">
            <div class="row">
                <div class="col">Listado de Vehículos</div>
            </div>
        </div>
        <div class="container ms-3">
            <div class="form-group mb-3">
                <div class="row">
                    <s:choose>
                        <s:when test="${empty vehicles}">
                            <div class="row">
                                <h1><strong>>No se han encontrado vehículos. Pide a un Gerente o recepcionista que lo de de alta</strong></h1>
                            </div>


                        </s:when>
                        <s:otherwise>
                            <c:forEach items="${vehicles}" var="vehicle">
                                <div class="col-md-4" style="width: 15rem;">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title">${vehicle.brand} ${vehicle.model}</h5>
                                            <p class="card-text">Año: ${fn:substring(vehicle.year, 0, 4)}</p>
                                            <p class="card-text">Placa: ${vehicle.license_plate}</p>
                                            <p class="card-text">Color: ${vehicle.color}</p>
                                            <p class="card-text">Transmisión: <s:out value="${vehicle.transmission}"/></p>
                                            <p class="card-text">Combustible: <s:out value="${vehicle.type_fuel}"/></p>
                                            <p class="card-text">Capacidad: <s:out value="${vehicle.capacity}"/></p>
                                            <p class="card-text">Número de motor: <s:out value="${vehicle.engine_number}"/></p>
                                            <form action="/client/services" method="get"></form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </s:otherwise>
                    </s:choose>

                </div>
            </div>
        </div>

    </div>
</div>


<jsp:include page="/layouts/footer.jsp"/>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Comprueba si la lista de vehículos está vacía
        var vehiclesEmpty = ${empty vehicles};

        if (vehiclesEmpty) {
            // Muestra la alerta con SweetAlert
            Swal.fire({
                icon: 'warning',
                title: 'Oops!',
                text: 'No se encontraron vehículos registrados. Pide a algún gerente o recepcionista que lo dé de alta.',
                confirmButtonColor: '#3085d6',
                confirmButtonText: 'Aceptar'
            });
        }
    });
</script>
</body>
</html>


