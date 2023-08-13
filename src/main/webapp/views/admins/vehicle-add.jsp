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

<body class="bg-primary-subtle">
<!-- navbar -->
<jsp:include page="/layouts/navbar.jsp"/>
<!-- body -->
<html>

<body class="row">
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
                        <form method="get" action="/vehicle/view2">
                            <input hidden value="${user.id_user}" name="id_user">
                            <button class="btn btn-outline-primary btn-sm d-inline">Visualizar vehiculos</button>
                        </form>
                    </td>
                </tr>
            </s:forEach>
            </tbody>
        </table>
    </div>
</div>
<jsp:include page="/layouts/footer.jsp"/>
</body>
</html>