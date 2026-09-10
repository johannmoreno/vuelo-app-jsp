<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.johannmoreno.vueloapp.business.services.VueloService" %>
<%@ page import="com.johannmoreno.vueloapp.domain.model.Vuelo" %>
<%@ page import="com.johannmoreno.vueloapp.business.exceptions.VueloNotFoundException" %>
<%
    VueloService vueloService = new VueloService();
    String action = request.getParameter("action");
    if (action == null) {
        action = "listAll";
    }

    switch (action) {
        case "showCreateForm":
            response.sendRedirect(request.getContextPath() + "/Views/Forms/Vuelos/crear.jsp");
            break;
        case "create":
            handleCreateVuelo(request, response, vueloService);
            break;
        case "showFindForm":
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
            break;
        case "search":
            handleSearch(request, response, session, vueloService);
            break;
        case "update":
            handleUpdateVuelo(request, response, session, vueloService);
            break;
        case "delete":
            handleDeleteVuelo(request, response, session, vueloService);
            break;
        case "deletefl":
            handleDeleteVueloFromList(request, response, session, vueloService);
            break;
        case "listAll":
            handleListAllVuelos(request, response, vueloService);
            break;
        case "showReportForm":
            request.getRequestDispatcher("/Views/Forms/Vuelos/reportes.jsp").forward(request, response);
            break;
        case "report1":
            handleReporte1(request, response, vueloService);
            break;
        case "report2":
            handleReporte2(request, response, vueloService);
            break;
        default:
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            break;
    }
%>
<%!
    private void handleCreateVuelo(HttpServletRequest request, HttpServletResponse response, VueloService vueloService)
            throws ServletException, IOException {
        try {
            LocalDate fechaCompra = LocalDate.parse(request.getParameter("fechaCompra"));
            LocalDateTime fechaSalida = LocalDateTime.parse(request.getParameter("fechaSalida"));
            LocalDateTime fechaLlegada = LocalDateTime.parse(request.getParameter("fechaLlegada"));
            String agenciaViajes = request.getParameter("agenciaViajes");
            String aerolinea = request.getParameter("aerolinea");
            String numero = request.getParameter("numero");
            String estado = request.getParameter("estado");
            BigDecimal valor = new BigDecimal(request.getParameter("valor"));
            String cliente = request.getParameter("cliente");
            String puesto = request.getParameter("puesto");
            String avion = request.getParameter("avion");
            String aeropuertoSalida = request.getParameter("aeropuertoSalida");
            String aeropuertoLlegada = request.getParameter("aeropuertoLlegada");
            String piloto = request.getParameter("piloto");

            vueloService.createVuelo(fechaCompra, fechaSalida, fechaLlegada, agenciaViajes, aerolinea,
                    numero, estado, valor, cliente, puesto, avion, aeropuertoSalida, aeropuertoLlegada, piloto);

            request.setAttribute("successMessage", "Vuelo creado exitosamente.");
            handleListAllVuelos(request, response, vueloService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Intentelo de nuevo.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/crear.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Datos invalidos: " + e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Vuelos/crear.jsp").forward(request, response);
        }
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, VueloService vueloService)
            throws ServletException, IOException {
        String searchIdStr = request.getParameter("id");
        try {
            Integer searchId = Integer.parseInt(searchIdStr);
            Vuelo vuelo = vueloService.getVueloById(searchId);
            session.setAttribute("searchedVuelo", vuelo);
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (VueloNotFoundException e) {
            session.removeAttribute("searchedVuelo");
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "El id debe ser un numero valido.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        }
    }

    private void handleUpdateVuelo(HttpServletRequest request, HttpServletResponse response, HttpSession session, VueloService vueloService)
            throws ServletException, IOException {
        Vuelo searchedVuelo = (Vuelo) session.getAttribute("searchedVuelo");
        if (searchedVuelo == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un vuelo para editar.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
            return;
        }
        try {
            Integer id = searchedVuelo.getId();
            LocalDate fechaCompra = LocalDate.parse(request.getParameter("fechaCompra"));
            LocalDateTime fechaSalida = LocalDateTime.parse(request.getParameter("fechaSalida"));
            LocalDateTime fechaLlegada = LocalDateTime.parse(request.getParameter("fechaLlegada"));
            String agenciaViajes = request.getParameter("agenciaViajes");
            String aerolinea = request.getParameter("aerolinea");
            String numero = request.getParameter("numero");
            String estado = request.getParameter("estado");
            BigDecimal valor = new BigDecimal(request.getParameter("valor"));
            String cliente = request.getParameter("cliente");
            String puesto = request.getParameter("puesto");
            String avion = request.getParameter("avion");
            String aeropuertoSalida = request.getParameter("aeropuertoSalida");
            String aeropuertoLlegada = request.getParameter("aeropuertoLlegada");
            String piloto = request.getParameter("piloto");

            vueloService.updateVuelo(id, fechaCompra, fechaSalida, fechaLlegada, agenciaViajes, aerolinea,
                    numero, estado, valor, cliente, puesto, avion, aeropuertoSalida, aeropuertoLlegada, piloto);

            request.setAttribute("successMessage", "Vuelo actualizado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (VueloNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Datos invalidos: " + e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        }
    }

    private void handleDeleteVuelo(HttpServletRequest request, HttpServletResponse response, HttpSession session, VueloService vueloService)
            throws ServletException, IOException {
        Vuelo searchedVuelo = (Vuelo) session.getAttribute("searchedVuelo");
        if (searchedVuelo == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un vuelo para eliminar.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
            return;
        }
        try {
            vueloService.deleteVuelo(searchedVuelo.getId());
            session.removeAttribute("searchedVuelo");
            request.setAttribute("successMessage", "Vuelo eliminado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (VueloNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/buscar_editar_eliminar.jsp").forward(request, response);
        }
    }

    private void handleDeleteVueloFromList(HttpServletRequest request, HttpServletResponse response, HttpSession session, VueloService vueloService)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        try {
            Integer id = Integer.parseInt(idStr);
            vueloService.deleteVuelo(id);
            session.removeAttribute("searchedVuelo");
            request.setAttribute("successMessage", "Vuelo eliminado exitosamente.");
            handleListAllVuelos(request, response, vueloService);
        } catch (VueloNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            handleListAllVuelos(request, response, vueloService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            handleListAllVuelos(request, response, vueloService);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Id invalido.");
            handleListAllVuelos(request, response, vueloService);
        }
    }

    private void handleListAllVuelos(HttpServletRequest request, HttpServletResponse response, VueloService vueloService)
            throws ServletException, IOException {
        try {
            List<Vuelo> vuelos = vueloService.getAllVuelos();
            request.setAttribute("vuelos", vuelos);
            request.getRequestDispatcher("/Views/Forms/Vuelos/listar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos al listar vuelos.");
            request.getRequestDispatcher("/Views/Forms/Vuelos/listar.jsp").forward(request, response);
        }
    }

    private void handleReporte1(HttpServletRequest request, HttpServletResponse response, VueloService vueloService)
            throws ServletException, IOException {
        try {
            String aerolinea = request.getParameter("aerolinea");
            LocalDate desde = LocalDate.parse(request.getParameter("desde"));
            LocalDate hasta = LocalDate.parse(request.getParameter("hasta"));
            List<Vuelo> resultado = vueloService.reportePorAerolineaYFechas(aerolinea, desde, hasta);
            request.setAttribute("vuelos", resultado);
            request.setAttribute("reporteTitulo", "Vuelos de " + aerolinea + " entre " + desde + " y " + hasta);
            request.getRequestDispatcher("/Views/Forms/Vuelos/reportes.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error al generar el reporte: " + e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Vuelos/reportes.jsp").forward(request, response);
        }
    }

    private void handleReporte2(HttpServletRequest request, HttpServletResponse response, VueloService vueloService)
            throws ServletException, IOException {
        try {
            String estado = request.getParameter("estado");
            BigDecimal valorMinimo = new BigDecimal(request.getParameter("valorMinimo"));
            List<Vuelo> resultado = vueloService.reportePorEstadoYValorMinimo(estado, valorMinimo);
            request.setAttribute("vuelos", resultado);
            request.setAttribute("reporteTitulo", "Vuelos en estado " + estado + " con valor mayor o igual a " + valorMinimo);
            request.getRequestDispatcher("/Views/Forms/Vuelos/reportes.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error al generar el reporte: " + e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Vuelos/reportes.jsp").forward(request, response);
        }
    }
%>