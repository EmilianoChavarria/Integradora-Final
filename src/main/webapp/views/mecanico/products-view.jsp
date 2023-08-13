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
<jsp:include page="/layouts/navbar-mecanico.jsp"/>
<!-- body -->
<div class="col-9">
  <div class="container rounded-5 p-4 bg-white mt-5" style="margin-left: 190px">
    <div class="card">
      <div class="card-header">
        <div class="row">
          <%--          <div class="col">--%>
          <%--            <form class="form-inline">--%>
          <%--              <input class="form-control mr-sm-2 d-inline" type="search"--%>
          <%--                     placeholder="Nombre de usuario" aria-label="Search" style="width: 180px">--%>
          <%--              <button class="btn btn-outline-success btn-m ms-4 d-inline " type="submit">Buscar</button>--%>
          <%--            </form>--%>
          <%--          </div>--%>
<h3>Listado de productos</h3>
        </div>
      </div>
    </div>
    <div>
      <s:choose>
      <s:when test="${empty products}">
      <table class="table table-stripped">
        <thead>
        <tr>
          <th>#</th>
          <th>Nombre del Producto:</th>
          <th>Descripción:</th>
          <th>Precio:</th>
          <th>Piezas:</th>
          <th>Acciones:</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <div class="row">
            <h1 class="text-center">
              <p>No se encontraron productos. Pide a un Gerente que registe un producto❗</p>
            </h1>
          </div>
        </tr>
        </tbody>
        </s:when>
        <s:otherwise>
        <table class="table table-stripped">
          <thead>
          <tr>
            <th>#</th>
            <th>Nombre del Producto:</th>
            <th>Descripción:</th>
            <th>Precio:</th>
            <th>Piezas:</th>

          </tr>
          </thead>
          <tbody>
          <s:forEach items="${products}" var="product" varStatus="s">
            <tr>
              <td>
                <s:out value="${s.count}"/>
              </td>
              <td>
                <s:out value="${product.name}"/>
              </td>
              <td>
                <s:out value="${product.concept}"/>
              </td>
              <td>
                <s:out value="${product.price}"/>
              </td>
              <td>
                <s:out value="${product.piece}"/>
              </td>


            </tr>
          </s:forEach>
          </s:otherwise>
          </s:choose>
          </tbody>
        </table>
    </div>
  </div>
</div>

<div class="modal fade" id="createProduct" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Agregar Productos</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>


      <div class="modal-body">
        <form id="product-form" class="needs-validation" novalidate action="/api/product/save"
              method="post">
          <div class="container-fuid">
            <div class="form-group mb-3">
              <div class="row">
                <div class="col">
                  <div class="form-floating">
                    <input class="form-control" placeholder="i" name="name" id="name"
                           type="text" required>
                    <label for="name">Nombre del producto</label>
                    <div class="invalid-feedback">Campo obligatorio</div>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating">
                    <input class="form-control" placeholder="i" name="concept" id="concept"
                           type="text"
                           required>
                    <label for="concept">Descripción:</label>
                    <div class="invalid-feedback is-invalid">
                      Campo obligatorio
                    </div>
                  </div>
                </div>

              </div>
            </div>

            <div class="form-group mb-3">
              <div class="row">
                <div class="col">
                  <div class="form-floating">
                    <input class="form-control" placeholder="i" name="piece"
                           id="piece"
                           type="text" required>
                    <label for="piece">Numero de piezas:</label>
                    <div class="invalid-feedback">Campo obligatorio</div>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating">
                    <input class="form-control" placeholder="i" name="price" id="price"
                           type="text"
                           required>
                    <label for="price">Precio:</label>
                    <div class="invalid-feedback">Campo obligatorio</div>
                  </div>
                </div>

              </div>
            </div>

            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
              <button type="submit" class="btn btn-primary" onclick="sendForm(event)">Agregar</button>
            </div>


        </form>
      </div>

    </div>
  </div>

</div>
</div>

<!-- MODAL UPDATE-->
<div class="modal fade" id="updateProduct" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="upStaticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="upStaticBackdropLabel">Editar información de Vehículos</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>


      <div class="modal-body">
        <form id="product-update" class="needs-validation" novalidate action="/api/product/update"
              method="post">
          <div class="container-fuid">
            <%--            <input type="hidden" value="${id_product}" name="id_product">--%>
            <input type="hidden" id="upProductId" name="id_product" value="${product.id_product}">

            <div class="form-group mb-3">
              <div class="row">
                <div class="col">
                  <div class="form-floating">
                    <input class="form-control" placeholder="i" name="name" id="upname"
                           type="text" required>
                    <label for="name">Nombre del producto</label>
                    <div class="invalid-feedback">Campo obligatorio</div>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating">
                    <input class="form-control" placeholder="i" name="concept" id="upconcept"
                           type="text"
                           required>
                    <label for="concept">Descripción:</label>
                    <div class="invalid-feedback is-invalid">
                      Campo obligatorio
                    </div>
                  </div>
                </div>

              </div>
            </div>

            <div class="form-group mb-3">
              <div class="row">
                <div class="col">
                  <div class="form-floating">
                    <input class="form-control" placeholder="i" name="piece"
                           id="uppiece"
                           type="text" required>
                    <label for="piece">Numero de piezas:</label>
                    <div class="invalid-feedback">Campo obligatorio</div>
                  </div>
                </div>
                <div class="col">
                  <div class="form-floating">
                    <input class="form-control" placeholder="i" name="price" id="upprice"
                           type="text"
                           required>
                    <label for="price">Precio:</label>
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

<jsp:include page="/layouts/footer.jsp"/>
<script>
  const fillEditForm = (productData) => {
    const form = document.getElementById("product-update");
    document.getElementById("upname").value = productData.name;
    document.getElementById("upprice").value = productData.price;
    document.getElementById("uppiece").value = productData.piece;
    document.getElementById("upconcept").value = productData.concept;
    document.getElementById("upProductId").value = productData.id_product;


  };

  const confirmarEliminar = (event, id_product) => {
    event.preventDefault();

    Swal.fire({
      title: '¿Seguro de eliminar este producto?',
      text: "Esta acción no se puede deshacer",
      icon: 'warning',
      showCancelButton: true,
      cancelButtonText: 'Cancelar',
      confirmButtonText: 'Eliminar',
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
    }).then((result) => {
      if (result.isConfirmed) {
        const form = document.getElementById(`deleteProductForm_${id_product}`);
        form.submit();
      }
    });
  };

  // Aviso de guardar
  const form = document.getElementById("product-form");

  const sendForm = (event) => {
    event.preventDefault();

    const form = document.getElementById('product-form'); // Obtener referencia al formulario por su id

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
            text: 'Producto almacenado correctamente',
            icon: 'success',
            timer: 1000, // Tiempo de espera en milisegundos (1.5 segundos)
            // timerProgressBar: true, // Muestra una barra de progreso del temporizador
            showConfirmButton: false // Oculta el botón de "Aceptar"
          }).then(() => {
            form.submit();
          });
        }
      }
    })
  }

  //Aviso de actualizar

  const sendFormUpdate = (event) => {
    event.preventDefault();

    const form = document.getElementById('product-update'); // Obtener referencia al formulario por su id

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
            text: 'Producto actualizado correctamente',
            icon: 'success',
            timer: 1000, // Tiempo de espera en milisegundos (1.5 segundos)
            // timerProgressBar: true, // Muestra una barra de progreso del temporizador
            showConfirmButton: false // Oculta el botón de "Aceptar"
          }).then(() => {
            form.submit();
          });
        }
      }
    })
  }

  const editButtons = document.querySelectorAll(".btn[data-bs-target='#updateProduct']");
  editButtons.forEach((button) => {
    button.addEventListener("click", () => {
      const productData = {
        name: button.dataset.name,
        concept: button.dataset.concept,
        price: button.dataset.price,
        piece: button.dataset.piece,
        id_product: button.dataset.id_product
      };
      fillEditForm(productData);
    });
  });


</script>

</body>
</html>