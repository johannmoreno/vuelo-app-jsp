<%--
    Document   : reportes
    Author     : johannmoreno
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.johannmoreno.vueloapp.domain.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Reportes de Usuarios</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Css/estilos.css">
</head>
<body>
<h1>Reportes Parametrizados de Usuarios</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<h2>Reporte 1: por Rol</h2>
<form action="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=report1" method="post">
  <label for="rol">Rol:</label>
  <select id="rol" name="rol" required>
    <option value="ADMIN">ADMIN</option>
    <option value="CLIENTE">CLIENTE</option>
    <option value="EMPLEADO">EMPLEADO</option>
  </select>

  <input type="submit" value="Generar Reporte 1">
</form>

<hr>

<h2>Reporte 2: por Dominio de Correo</h2>
<form action="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=report2" method="post">
  <label for="dominio">Dominio (ej: gmail.com):</label>
  <input type="text" id="dominio" name="dominio" required placeholder="gmail.com">

  <input type="submit" value="Generar Reporte 2">
</form>

<hr>

<%
  List<Usuario> usuariosReporte = (List<Usuario>) request.getAttribute("usuariosReporte");
  String reporteTitulo = (String) request.getAttribute("reporteTitulo");
%>
<% if (usuariosReporte != null) { %>
<h3><%= reporteTitulo %></h3>
<table border="1">
  <thead>
  <tr>
    <th>Id</th>
    <th>Nombre</th>
    <th>Rol</th>
    <th>Email</th>
  </tr>
  </thead>
  <tbody>
  <% if (!usuariosReporte.isEmpty()) { %>
  <% for (Usuario usuario : usuariosReporte) { %>
  <tr>
    <td><%= usuario.getId() %></td>
    <td><%= usuario.getNombre() %></td>
    <td><%= usuario.getRol() %></td>
    <td><%= usuario.getEmail() %></td>
  </tr>
  <% } %>
  <% } else { %>
  <tr>
    <td colspan="4">No se encontraron usuarios con esos criterios.</td>
  </tr>
  <% } %>
  </tbody>
</table>
<% } %>

<br>
<a href="<%= request.getContextPath() %>/index.jsp">MENU PRINCIPAL</a>
</body>
</html>