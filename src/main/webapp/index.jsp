<%--
    Document   : index
    Author     : johannmoreno
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.johannmoreno.vueloapp.domain.model.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vuelo App - Inicio</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Css/estilos.css">
</head>
<body>
<h1>Bienvenido al Sistema de Gestion de Vuelos</h1>

<%
    Usuario loggedInUsuario = (Usuario) session.getAttribute("loggedInUsuario");
%>

<% if (loggedInUsuario == null) { %>
<h3>No has iniciado sesion</h3>
<a href="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=login">Iniciar Sesion</a>
<% } else { %>
<h3>Hola, <%= loggedInUsuario.getNombre() %> (Rol: <%= loggedInUsuario.getRol() %>)</h3>
<ul>
    <li><a href="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=showCreateForm">Agregar Usuario</a></li>
    <li><a href="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=showFindForm">Buscar Usuario</a></li>
    <li><a href="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=listAll">Listar Usuarios</a></li>
    <li><a href="<%= request.getContextPath() %>/Controllers/VueloController.jsp?action=showCreateForm">Agregar Vuelo</a></li>
    <li><a href="<%= request.getContextPath() %>/Controllers/VueloController.jsp?action=showFindForm">Buscar Vuelo</a></li>
    <li><a href="<%= request.getContextPath() %>/Controllers/VueloController.jsp?action=listAll">Listar Vuelos</a></li>
    <li><a href="<%= request.getContextPath() %>/Controllers/VueloController.jsp?action=showReportForm">Reportes de Vuelos</a></li>
</ul>
<br>
<a href="<%= request.getContextPath() %>/Controllers/UsuarioController.jsp?action=logout">Cerrar Sesion</a>
<% } %>

</body>
</html>