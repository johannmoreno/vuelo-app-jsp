<%--
    Document   : crear
    Author     : johannmoreno
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Agregar Usuario</title>
</head>
<body>
<h1>Agregar Usuario</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<% if (request.getAttribute("successMessage") != null) { %>
<p style="color:green;"><%= request.getAttribute("successMessage") %></p>
<% } %>

<form action="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=create" method="post">
    <label for="id">Id:</label><br>
    <input type="text" id="id" name="id" required><br><br>

    <label for="nombre">Nombre:</label><br>
    <input type="text" id="nombre" name="nombre" required><br><br>

    <label for="rol">Rol:</label><br>
    <select id="rol" name="rol" required>
        <option value="ADMIN">ADMIN</option>
        <option value="CLIENTE">CLIENTE</option>
        <option value="EMPLEADO">EMPLEADO</option>
    </select><br><br>

    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" required><br><br>

    <label for="clave">Contrasena:</label><br>
    <input type="password" id="clave" name="clave" required><br><br>

    <input type="submit" value="Agregar Usuario">
</form>

<br>
<a href="<%= request.getContextPath() %>/index.jsp">Menu Principal</a>
</body>
</html>