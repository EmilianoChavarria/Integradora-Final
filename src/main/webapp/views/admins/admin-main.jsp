<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>User-add</title>
    <jsp:include page="/layouts/header.jsp"/>
</head>

<body class="bg-primary-subtle">
<!-- navbar -->
<jsp:include page="/layouts/navbar.jsp"/>
<!-- body -->
<div class="container-fluid">
    <div class="row">
        <div class="col ms-5" style="margin-top: 180px;">
            <div class=" h1 ">
                Bienvenido Gerente
                <br>
                ¡Mantén tu vehículo en su mejor estado con nuestro servicio de excelencia!
            </div>
        </div>
        <div class="col">
            <img src="/assets/img/bujias.jpg" class="d-block w-100" alt="...">

        </div>

    </div>
</div>


<jsp:include page="/layouts/footer.jsp"/>
</body>
</html>