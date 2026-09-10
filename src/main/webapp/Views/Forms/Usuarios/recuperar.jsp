<%--
    Document   : recuperar
    Author     : johannmoreno
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recuperar Clave</title>
</head>
<body>
<h1>Recuperar Clave</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<% if (request.getAttribute("successMessage") != null) { %>
<p style="color:green;"><%= request.getAttribute("successMessage") %></p>
<% } %>

<p>Ingresa tu email registrado. Te enviaremos una clave temporal.</p>

<form action="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=enviarRecuperacion" method="post">
    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" required><br><br>

    <input type="submit" value="Enviar Clave Temporal">
</form>

<br>
<a href="<%= request.getContextPath() %>/Views/Forms/Usuarios/login.jsp">Volver al Login</a>
</body>
</html>