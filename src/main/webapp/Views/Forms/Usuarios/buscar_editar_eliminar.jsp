<%--
    Document   : buscar_editar_eliminar
    Author     : johannmoreno
--%>
<%@ page import="com.johannmoreno.vueloapp.domain.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Buscar, Editar o Eliminar Usuario</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Css/estilos.css">
    <script>
        function enableButtons() {
            document.getElementById("editBtn").disabled = false;
            document.getElementById("deleteBtn").disabled = false;
        }
        function disableButtons() {
            document.getElementById("editBtn").disabled = true;
            document.getElementById("deleteBtn").disabled = true;
        }
        function setActionAndSubmit(action, confirmMessage) {
            if (confirmMessage) {
                if (!confirm(confirmMessage)) {
                    return;
                }
            }
            document.getElementById("actionInput").value = action;
            document.getElementById("usuarioForm").submit();
        }
    </script>
</head>
<body onload="<%= (session.getAttribute("searchedUsuario") != null) ? "enableButtons()" : "disableButtons()" %>">
<h1>Buscar, Editar o Eliminar Usuario</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<% if (request.getAttribute("successMessage") != null) { %>
<p style="color:green;"><%= request.getAttribute("successMessage") %></p>
<% } %>

<form id="usuarioForm" action="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp" method="post">
    <input type="hidden" id="actionInput" name="action" value="search">

    <label for="id">Id del usuario:</label><br>
    <input type="text" id="id" name="id" required
           value="<%= session.getAttribute("searchedUsuario") != null
                   ? ((Usuario) session.getAttribute("searchedUsuario")).getId()
                   : "" %>">
    <br><br>

    <%
        Usuario sessionUsuario = (Usuario) session.getAttribute("searchedUsuario");
    %>

    <% if (sessionUsuario != null) { %>
    <h3>Detalles del Usuario</h3>
    <p><strong>Id:</strong> <%= sessionUsuario.getId() %></p>
    <p><strong>Nombre actual:</strong> <%= sessionUsuario.getNombre() %></p>
    <p><strong>Rol actual:</strong> <%= sessionUsuario.getRol() %></p>
    <p><strong>Email actual:</strong> <%= sessionUsuario.getEmail() %></p>

    <label for="nombre">Nuevo Nombre:</label><br>
    <input type="text" id="nombre" name="nombre" value="<%= sessionUsuario.getNombre() %>" required><br><br>

    <label for="rol">Nuevo Rol:</label><br>
    <select id="rol" name="rol" required>
        <option value="ADMIN" <%= "ADMIN".equals(sessionUsuario.getRol()) ? "selected" : "" %>>ADMIN</option>
        <option value="CLIENTE" <%= "CLIENTE".equals(sessionUsuario.getRol()) ? "selected" : "" %>>CLIENTE</option>
        <option value="EMPLEADO" <%= "EMPLEADO".equals(sessionUsuario.getRol()) ? "selected" : "" %>>EMPLEADO</option>
    </select><br><br>

    <label for="email">Nuevo Email:</label><br>
    <input type="email" id="email" name="email" value="<%= sessionUsuario.getEmail() %>" required><br><br>

    <label for="clave">Nueva Contrasena:</label><br>
    <input type="password" id="clave" name="clave" required><br><br>
    <% } else { %>
    <p>No se ha buscado ningun usuario aun o el usuario no fue encontrado.</p>
    <% } %>

    <br>
    <button type="submit" onclick="setActionAndSubmit('search')" id="searchBtn">Buscar Usuario</button>
    <button type="button" id="editBtn" disabled
            onclick="setActionAndSubmit('update', '¿Seguro que deseas editar este usuario?')">
        Editar Usuario
    </button>
    <button type="button" id="deleteBtn" disabled
            onclick="setActionAndSubmit('delete', '¿Seguro que deseas eliminar este usuario?')">
        Eliminar Usuario
    </button>
</form>

<br>
<a href="<%= request.getContextPath() %>/index.jsp">MENU PRINCIPAL</a>
</body>
</html>