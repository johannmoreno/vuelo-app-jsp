package com.johannmoreno.vueloapp.business.services;

import com.johannmoreno.vueloapp.business.exceptions.DuplicateUsuarioException;
import com.johannmoreno.vueloapp.business.exceptions.UsuarioNotFoundException;
import com.johannmoreno.vueloapp.domain.model.Usuario;
import com.johannmoreno.vueloapp.infrastructure.persistence.UsuarioCRUD;

import java.sql.SQLException;
import java.util.List;

public class UsuarioService {

    private final UsuarioCRUD usuarioCrud;

    public UsuarioService() {
        this.usuarioCrud = new UsuarioCRUD();
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
}