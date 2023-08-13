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
        <div class="col">Listado de Paquetes</div>
      </div>
    </div>
    <div class="container ms-3">

      <div class="form-group mb-3">
        <div class="row">
          <s:forEach items="${packages}" var="packageItem">
            <div class="col-md-4" style="width: 15rem;">
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">${packageItem.name}  </h5>
                  <h5 class="card-text">(${packageItem.type_package})</h5>
                  <p class="card-text">Precio: ${packageItem.price}</p>
                </div>
              </div>
            </div>
          </s:forEach>
        </div>
      </div>
    </div>

  </div>
</div>


<jsp:include page="/layouts/footer.jsp"/>
<script>

</script>
</body>
</html>


