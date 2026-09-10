<%--
    Document   : listar
    Author     : johannmoreno
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.johannmoreno.vueloapp.domain.model.Vuelo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Vuelos</title>
</head>
<body>
<h1>Lista de Todos los Vuelos</h1>

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
        <th>Numero</th>
        <th>Aerolinea</th>
        <th>Salida</th>
        <th>Llegada</th>
        <th>Estado</th>
        <th>Valor</th>
        <th>Cliente</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <% List<Vuelo> vuelos = (List<Vuelo>) request.getAttribute("vuelos"); %>
    <% if (vuelos != null && !vuelos.isEmpty()) { %>
    <% for (Vuelo vuelo : vuelos) { %>
    <tr>
        <td><%= vuelo.getId() %></td>
        <td><%= vuelo.getNumero() %></td>
        <td><%= vuelo.getAerolinea() %></td>
        <td><%= vuelo.getFechaSalida() %></td>
        <td><%= vuelo.getFechaLlegada() %></td>
        <td><%= vuelo.getEstado() %></td>
        <td><%= vuelo.getValor() %></td>
        <td><%= vuelo.getCliente() %></td>
        <td>
            <a href="VueloController.jsp?action=search&id=<%= vuelo.getId() %>">Editar</a> |
            <a href="VueloController.jsp?action=deletefl&id=<%= vuelo.getId() %>"
               onclick="return confirm('¿Seguro que deseas eliminar este vuelo?');">Eliminar</a>
        </td>
    </tr>
    <% } %>
    <% } else { %>
    <tr>
        <td colspan="9">No hay vuelos disponibles</td>
    </tr>
    <% } %>
    </tbody>
</table>

<br>
<a href="<%= request.getContextPath() %>/Controllers/VueloController.jsp?action=showCreateForm">Agregar Nuevo Vuelo</a>
</body>
</html>