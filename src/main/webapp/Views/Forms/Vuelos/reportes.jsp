<%--
    Document   : reportes
    Author     : johannmoreno
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.johannmoreno.vueloapp.domain.model.Vuelo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reportes de Vuelos</title>
</head>
<body>
<h1>Reportes Parametrizados de Vuelos</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<h2>Reporte 1: por Aerolinea y Rango de Fechas de Salida</h2>
<form action="<%= request.getContextPath() %>/Controllers/VueloController.jsp?action=report1" method="post">
    <label for="aerolinea">Aerolinea:</label>
    <input type="text" id="aerolinea" name="aerolinea" required>

    <label for="desde">Desde:</label>
    <input type="date" id="desde" name="desde" required>

    <label for="hasta">Hasta:</label>
    <input type="date" id="hasta" name="hasta" required>

    <input type="submit" value="Generar Reporte 1">
</form>

<hr>

<h2>Reporte 2: por Estado y Valor Minimo</h2>
<form action="<%= request.getContextPath() %>/Controllers/VueloController.jsp?action=report2" method="post">
    <label for="estado">Estado:</label>
    <select id="estado" name="estado" required>
        <option value="Confirmado">Confirmado</option>
        <option value="Pendiente">Pendiente</option>
        <option value="Cancelado">Cancelado</option>
        <option value="Completado">Completado</option>
    </select>

    <label for="valorMinimo">Valor Minimo:</label>
    <input type="number" step="0.01" id="valorMinimo" name="valorMinimo" required>

    <input type="submit" value="Generar Reporte 2">
</form>

<hr>

<%
    List<Vuelo> vuelos = (List<Vuelo>) request.getAttribute("vuelos");
    String reporteTitulo = (String) request.getAttribute("reporteTitulo");
%>
<% if (vuelos != null) { %>
<h3><%= reporteTitulo %></h3>
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
    </tr>
    </thead>
    <tbody>
    <% if (!vuelos.isEmpty()) { %>
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
    </tr>
    <% } %>
    <% } else { %>
    <tr>
        <td colspan="8">No se encontraron vuelos con esos criterios.</td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } %>

<br>
<a href="<%= request.getContextPath() %>/index.jsp">MENU PRINCIPAL</a>
</body>
</html>