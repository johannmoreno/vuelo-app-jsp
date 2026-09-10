<%--
    Document   : buscar_editar_eliminar
    Author     : johannmoreno
--%>
<%@ page import="com.johannmoreno.vueloapp.domain.model.Vuelo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Buscar, Editar o Eliminar Vuelo</title>
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
            document.getElementById("vueloForm").submit();
        }
    </script>
</head>
<body onload="<%= (session.getAttribute("searchedVuelo") != null) ? "enableButtons()" : "disableButtons()" %>">
<h1>Buscar, Editar o Eliminar Vuelo</h1>

<% if (request.getAttribute("errorMessage") != null) { %>
<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
<% } %>

<% if (request.getAttribute("successMessage") != null) { %>
<p style="color:green;"><%= request.getAttribute("successMessage") %></p>
<% } %>

<form id="vueloForm" action="<%= request.getContextPath() %>/Controllers/VueloController.jsp" method="post">
    <input type="hidden" id="actionInput" name="action" value="search">

    <label for="id">Id del vuelo:</label><br>
    <input type="text" id="id" name="id" required
           value="<%= session.getAttribute("searchedVuelo") != null
                   ? ((Vuelo) session.getAttribute("searchedVuelo")).getId()
                   : "" %>">
    <br><br>

    <%
        Vuelo sessionVuelo = (Vuelo) session.getAttribute("searchedVuelo");
    %>

    <% if (sessionVuelo != null) { %>
    <h3>Detalles del Vuelo</h3>
    <p><strong>Id:</strong> <%= sessionVuelo.getId() %></p>

    <label for="fechaCompra">Fecha de Compra:</label><br>
    <input type="date" id="fechaCompra" name="fechaCompra"
           value="<%= sessionVuelo.getFechaCompra() %>" required><br><br>

    <label for="fechaSalida">Fecha y Hora de Salida:</label><br>
    <input type="datetime-local" id="fechaSalida" name="fechaSalida"
           value="<%= sessionVuelo.getFechaSalida() %>" required><br><br>

    <label for="fechaLlegada">Fecha y Hora de Llegada:</label><br>
    <input type="datetime-local" id="fechaLlegada" name="fechaLlegada"
           value="<%= sessionVuelo.getFechaLlegada() %>" required><br><br>

    <label for="agenciaViajes">Agencia de Viajes:</label><br>
    <input type="text" id="agenciaViajes" name="agenciaViajes"
           value="<%= sessionVuelo.getAgenciaViajes() %>" required><br><br>

    <label for="aerolinea">Aerolinea:</label><br>
    <input type="text" id="aerolinea" name="aerolinea"
           value="<%= sessionVuelo.getAerolinea() %>" required><br><br>

    <label for="numero">Numero de Vuelo:</label><br>
    <input type="text" id="numero" name="numero"
           value="<%= sessionVuelo.getNumero() %>" required><br><br>

    <label for="estado">Estado:</label><br>
    <select id="estado" name="estado" required>
        <option value="Confirmado" <%= "Confirmado".equals(sessionVuelo.getEstado()) ? "selected" : "" %>>Confirmado</option>
        <option value="Pendiente" <%= "Pendiente".equals(sessionVuelo.getEstado()) ? "selected" : "" %>>Pendiente</option>
        <option value="Cancelado" <%= "Cancelado".equals(sessionVuelo.getEstado()) ? "selected" : "" %>>Cancelado</option>
        <option value="Completado" <%= "Completado".equals(sessionVuelo.getEstado()) ? "selected" : "" %>>Completado</option>
    </select><br><br>

    <label for="valor">Valor:</label><br>
    <input type="number" step="0.01" id="valor" name="valor"
           value="<%= sessionVuelo.getValor() %>" required><br><br>

    <label for="cliente">Cliente:</label><br>
    <input type="text" id="cliente" name="cliente"
           value="<%= sessionVuelo.getCliente() %>" required><br><br>

    <label for="puesto">Puesto:</label><br>
    <input type="text" id="puesto" name="puesto"
           value="<%= sessionVuelo.getPuesto() %>" required><br><br>

    <label for="avion">Avion:</label><br>
    <input type="text" id="avion" name="avion"
           value="<%= sessionVuelo.getAvion() %>" required><br><br>

    <label for="aeropuertoSalida">Aeropuerto de Salida:</label><br>
    <input type="text" id="aeropuertoSalida" name="aeropuertoSalida"
           value="<%= sessionVuelo.getAeropuertoSalida() %>" required><br><br>

    <label for="aeropuertoLlegada">Aeropuerto de Llegada:</label><br>
    <input type="text" id="aeropuertoLlegada" name="aeropuertoLlegada"
           value="<%= sessionVuelo.getAeropuertoLlegada() %>" required><br><br>

    <label for="piloto">Piloto:</label><br>
    <input type="text" id="piloto" name="piloto"
           value="<%= sessionVuelo.getPiloto() %>" required><br><br>
    <% } else { %>
    <p>No se ha buscado ningun vuelo aun o el vuelo no fue encontrado.</p>
    <% } %>

    <br>
    <button type="submit" onclick="setActionAndSubmit('search')" id="searchBtn">Buscar Vuelo</button>
    <button type="button" id="editBtn" disabled
            onclick="setActionAndSubmit('update', '¿Seguro que deseas editar este vuelo?')">
        Editar Vuelo
    </button>
    <button type="button" id="deleteBtn" disabled
            onclick="setActionAndSubmit('delete', '¿Seguro que deseas eliminar este vuelo?')">
        Eliminar Vuelo
    </button>
</form>

<br>
<a href="<%= request.getContextPath() %>/index.jsp">MENU PRINCIPAL</a>
</body>
</html>