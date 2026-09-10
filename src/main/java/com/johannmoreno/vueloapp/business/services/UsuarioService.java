package com.johannmoreno.vueloapp.business.services;

import com.johannmoreno.vueloapp.business.exceptions.DuplicateUsuarioException;
import com.johannmoreno.vueloapp.business.exceptions.UsuarioNotFoundException;
import com.johannmoreno.vueloapp.domain.model.Usuario;
import com.johannmoreno.vueloapp.infrastructure.email.EmailService;
import com.johannmoreno.vueloapp.infrastructure.persistence.UsuarioCRUD;
import jakarta.mail.MessagingException;

import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.List;

public class UsuarioService {

    private final UsuarioCRUD usuarioCrud;
    private final EmailService emailService;

    public UsuarioService() {
        this.usuarioCrud = new UsuarioCRUD();
        this.emailService = new EmailService();
    }

    // Metodo para obtener todos los usuarios
    public List<Usuario> getAllUsuarios() throws SQLException {
        return usuarioCrud.getAllUsuarios();
    }

    // Metodo para crear un nuevo usuario
    public void createUsuario(String id, String clave, String nombre, String rol, String email)
            throws DuplicateUsuarioException, SQLException {
        Usuario usuario = new Usuario(id, clave, nombre, rol, email);
        usuarioCrud.addUsuario(usuario);
    }

    // Metodo para actualizar un usuario
    public void updateUsuario(String id, String clave, String nombre, String rol, String email)
            throws UsuarioNotFoundException, SQLException {
        Usuario usuario = new Usuario(id, clave, nombre, rol, email);
        usuarioCrud.updateUsuario(usuario);
    }

    // Metodo para eliminar un usuario
    public void deleteUsuario(String id) throws UsuarioNotFoundException, SQLException {
        usuarioCrud.deleteUsuario(id);
    }

    // Metodo para obtener un usuario por id
    public Usuario getUsuarioById(String id) throws UsuarioNotFoundException, SQLException {
        return usuarioCrud.getUsuarioById(id);
    }

    // Metodo para autenticar un usuario (login)
    public Usuario loginUsuario(String email, String clave) throws UsuarioNotFoundException, SQLException {
        Usuario usuario = usuarioCrud.getUsuarioByEmail(email);

        if (usuario != null && usuario.getClave().equals(clave)) {
            return usuario;
        } else {
            throw new UsuarioNotFoundException("Credenciales incorrectas. No se encontro el usuario o la clave es incorrecta.");
        }
    }

    // Metodo para buscar usuarios por nombre o email
    public List<Usuario> searchUsuarios(String searchTerm) throws SQLException {
        return usuarioCrud.searchUsuarios(searchTerm);
    }

    // Metodo para obtener un usuario por email (usado en recuperacion de clave)
    public Usuario getUsuarioByEmail(String email) throws UsuarioNotFoundException, SQLException {
        return usuarioCrud.getUsuarioByEmail(email);
    }

    // Metodo para recuperar clave: genera una clave temporal, la guarda y la envia por correo
    public void recuperarClave(String email) throws UsuarioNotFoundException, SQLException, MessagingException {
        Usuario usuario = usuarioCrud.getUsuarioByEmail(email);

        String claveTemporal = generarClaveTemporal();
        usuario.setClave(claveTemporal);
        usuarioCrud.updateUsuario(usuario);

        String asunto = "Recuperacion de clave - VueloApp";
        String cuerpo = "Hola " + usuario.getNombre() + ",\n\n"
                + "Tu nueva clave temporal es: " + claveTemporal + "\n\n"
                + "Te recomendamos iniciar sesion y cambiarla lo antes posible.\n\n"
                + "Equipo VueloApp";

        emailService.enviarCorreo(usuario.getEmail(), asunto, cuerpo);
    }

    // Metodo auxiliar para generar una clave temporal aleatoria de 8 caracteres
    private String generarClaveTemporal() {
        String caracteres = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789";
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            sb.append(caracteres.charAt(random.nextInt(caracteres.length())));
        }
        return sb.toString();
    }
}