<%--
    Document   : crear
    Author     : johannmoreno
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Agregar Vuelo</title>
</head>
<body>
<h1>Agregar Vuelo</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<% if (request.getAttribute("successMessage") != null) { %>
<p style="color:green;"><%= request.getAttribute("successMessage") %></p>
<% } %>

<form action="<%= request.getContextPath() %>/Controllers/VueloController.jsp?action=create" method="post">
    <label for="fechaCompra">Fecha de Compra:</label><br>
    <input type="date" id="fechaCompra" name="fechaCompra" required><br><br>

    <label for="fechaSalida">Fecha y Hora de Salida:</label><br>
    <input type="datetime-local" id="fechaSalida" name="fechaSalida" required><br><br>

    <label for="fechaLlegada">Fecha y Hora de Llegada:</label><br>
    <input type="datetime-local" id="fechaLlegada" name="fechaLlegada" required><br><br>

    <label for="agenciaViajes">Agencia de Viajes:</label><br>
    <input type="text" id="agenciaViajes" name="agenciaViajes" required><br><br>

    <label for="aerolinea">Aerolinea:</label><br>
    <input type="text" id="aerolinea" name="aerolinea" required><br><br>

    <label for="numero">Numero de Vuelo:</label><br>
    <input type="text" id="numero" name="numero" required><br><br>

    <label for="estado">Estado:</label><br>
    <select id="estado" name="estado" required>
        <option value="Confirmado">Confirmado</option>
        <option value="Pendiente">Pendiente</option>
        <option value="Cancelado">Cancelado</option>
        <option value="Completado">Completado</option>
    </select><br><br>

    <label for="valor">Valor:</label><br>
    <input type="number" step="0.01" id="valor" name="valor" required><br><br>

    <label for="cliente">Cliente:</label><br>
    <input type="text" id="cliente" name="cliente" required><br><br>

    <label for="puesto">Puesto:</label><br>
    <input type="text" id="puesto" name="puesto" required><br><br>

    <label for="avion">Avion:</label><br>
    <input type="text" id="avion" name="avion" required><br><br>

    <label for="aeropuertoSalida">Aeropuerto de Salida:</label><br>
    <input type="text" id="aeropuertoSalida" name="aeropuertoSalida" required><br><br>

    <label for="aeropuertoLlegada">Aeropuerto de Llegada:</label><br>
    <input type="text" id="aeropuertoLlegada" name="aeropuertoLlegada" required><br><br>

    <label for="piloto">Piloto:</label><br>
    <input type="text" id="piloto" name="piloto" required><br><br>

    <input type="submit" value="Agregar Vuelo">
</form>

<br>
<a href="<%= request.getContextPath() %>/index.jsp">Menu Principal</a>
</body>
</html>