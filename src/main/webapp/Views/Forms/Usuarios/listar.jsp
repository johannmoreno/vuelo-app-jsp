<%--
    Document   : listar
    Author     : johannmoreno
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.johannmoreno.vueloapp.domain.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Usuarios</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Css/estilos.css">
</head>
<body>
<h1>Lista de Todos los Usuarios</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<% if (request.getAttribute("successMessage") != null) { %>
<p style="color:green;"><%= request.getAttribute("successMessage") %></p>
<% } %>

<table border="1">
    <thead>
    <tr>
        <th>Id</th>
        <th>Nombre</th>
        <th>Rol</th>
        <th>Email</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <% List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios"); %>
    <% if (usuarios != null && !usuarios.isEmpty()) { %>
    <% for (Usuario usuario : usuarios) { %>
    <tr>
        <td><%= usuario.getId() %></td>
        <td><%= usuario.getNombre() %></td>
        <td><%= usuario.getRol() %></td>
        <td><%= usuario.getEmail() %></td>
        <td>
            <a href="UsuarioController.jsp?action=search&id=<%= usuario.getId() %>">Editar</a> |
            <a href="UsuarioController.jsp?action=deletefl&id=<%= usuario.getId() %>"
               onclick="return confirm('¿Seguro que deseas eliminar este usuario?');">Eliminar</a>
        </td>
    </tr>
    <% } %>
    <% } else { %>
    <tr>
        <td colspan="5">No hay usuarios disponibles</td>
    </tr>
    <% } %>
    </tbody>
</table>

<br>
<a href="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=showCreateForm">Agregar Nuevo Usuario</a>
</body>
</html>