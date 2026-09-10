<%--
    Document   : login
    Author     : johannmoreno
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Iniciar Sesion</title>
</head>
<body>
<h1>Iniciar Sesion</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<form action="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=authenticate" method="post">
    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" required><br><br>

    <label for="clave">Contrasena:</label><br>
    <input type="password" id="clave" name="clave" required><br><br>

    <input type="submit" value="Iniciar Sesion">
</form>

<br>
<a href="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=recuperar">¿Olvidaste tu clave?</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.jsp">Volver a la pagina de inicio</a>
</body>
</html>