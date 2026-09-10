<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="jakarta.mail.MessagingException" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.johannmoreno.vueloapp.business.services.UsuarioService" %>
<%@ page import="com.johannmoreno.vueloapp.domain.model.Usuario" %>
<%@ page import="com.johannmoreno.vueloapp.business.exceptions.UsuarioNotFoundException" %>
<%@ page import="com.johannmoreno.vueloapp.business.exceptions.DuplicateUsuarioException" %>
<%
    UsuarioService usuarioService = new UsuarioService();
    String action = request.getParameter("action");
    if (action == null) {
        action = "listAll";
    }

    switch (action) {
        case "login":
            handleLogin(request, response, session);
            break;
        case "authenticate":
            handleAuthenticate(request, response, session, usuarioService);
            break;
        case "showCreateForm":
            response.sendRedirect(request.getContextPath() + "/Views/Forms/Usuarios/crear.jsp");
            break;
        case "create":
            handleCreateUsuario(request, response, usuarioService);
            break;
        case "showFindForm":
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
            break;
        case "search":
            handleSearch(request, response, session, usuarioService);
            break;
        case "update":
            handleUpdateUsuario(request, response, session, usuarioService);
            break;
        case "delete":
            handleDeleteUsuario(request, response, session, usuarioService);
            break;
        case "deletefl":
            handleDeleteUsuarioFromList(request, response, session, usuarioService);
            break;
        case "listAll":
            handleListAllUsuarios(request, response, usuarioService);
            break;
        case "recuperar":
            request.getRequestDispatcher("/Views/Forms/Usuarios/recuperar.jsp").forward(request, response);
            break;
        case "enviarRecuperacion":
            handleRecuperarClave(request, response, usuarioService);
            break;
        case "logout":
            handleLogout(request, response, session);
            break;
        default:
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            break;
    }
%>
<%!
    private void handleLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Usuarios/login.jsp");
    }

    private void handleAuthenticate(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String clave = request.getParameter("clave");
        try {
            Usuario loggedInUsuario = usuarioService.loginUsuario(email, clave);
            session.setAttribute("loggedInUsuario", loggedInUsuario);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/login.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Intentelo de nuevo.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/login.jsp").forward(request, response);
        }
    }

    private void handleCreateUsuario(HttpServletRequest request, HttpServletResponse response, UsuarioService usuarioService)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String rol = request.getParameter("rol");
        String email = request.getParameter("email");
        String clave = request.getParameter("clave");
        try {
            usuarioService.createUsuario(id, clave, nombre, rol, email);
            request.setAttribute("successMessage", "Usuario creado exitosamente.");
            handleListAllUsuarios(request, response, usuarioService);
        } catch (DuplicateUsuarioException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/crear.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Intentelo de nuevo.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/crear.jsp").forward(request, response);
        }
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        String searchId = request.getParameter("id");
        try {
            Usuario usuario = usuarioService.getUsuarioById(searchId);
            session.setAttribute("searchedUsuario", usuario);
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (UsuarioNotFoundException e) {
            session.removeAttribute("searchedUsuario");
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        }
    }

    private void handleUpdateUsuario(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        Usuario searchedUsuario = (Usuario) session.getAttribute("searchedUsuario");
        if (searchedUsuario == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un usuario para editar.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
            return;
        }
        String id = searchedUsuario.getId();
        String nombre = request.getParameter("nombre");
        String rol = request.getParameter("rol");
        String email = request.getParameter("email");
        String clave = request.getParameter("clave");
        try {
            usuarioService.updateUsuario(id, clave, nombre, rol, email);
            request.setAttribute("successMessage", "Usuario actualizado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        }
    }

    private void handleDeleteUsuario(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        Usuario searchedUsuario = (Usuario) session.getAttribute("searchedUsuario");
        if (searchedUsuario == null) {
            request.setAttribute("errorMessage", "Primero debe buscar un usuario para eliminar.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
            return;
        }
        String id = searchedUsuario.getId();
        try {
            usuarioService.deleteUsuario(id);
            session.removeAttribute("searchedUsuario");
            request.setAttribute("successMessage", "Usuario eliminado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/buscar_editar_eliminar.jsp").forward(request, response);
        }
    }

    private void handleDeleteUsuarioFromList(HttpServletRequest request, HttpServletResponse response, HttpSession session, UsuarioService usuarioService)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            request.setAttribute("errorMessage", "El id es requerido.");
            handleListAllUsuarios(request, response, usuarioService);
            return;
        }
        try {
            usuarioService.deleteUsuario(id);
            session.removeAttribute("searchedUsuario");
            request.setAttribute("successMessage", "Usuario eliminado exitosamente.");
            handleListAllUsuarios(request, response, usuarioService);
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            handleListAllUsuarios(request, response, usuarioService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            handleListAllUsuarios(request, response, usuarioService);
        }
    }

    private void handleListAllUsuarios(HttpServletRequest request, HttpServletResponse response, UsuarioService usuarioService)
            throws ServletException, IOException {
        try {
            List<Usuario> usuarios = usuarioService.getAllUsuarios();
            request.setAttribute("usuarios", usuarios);
            request.getRequestDispatcher("/Views/Forms/Usuarios/listar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos al listar usuarios.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/listar.jsp").forward(request, response);
        }
    }

    private void handleRecuperarClave(HttpServletRequest request, HttpServletResponse response, UsuarioService usuarioService)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        try {
            usuarioService.recuperarClave(email);
            request.setAttribute("successMessage", "Se ha enviado una clave temporal a tu correo.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/recuperar.jsp").forward(request, response);
        } catch (UsuarioNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/recuperar.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Usuarios/recuperar.jsp").forward(request, response);
        } catch (MessagingException e) {
            request.setAttribute("errorMessage", "Error al enviar el correo: " + e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Usuarios/recuperar.jsp").forward(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Usuarios/login.jsp");
    }
%>