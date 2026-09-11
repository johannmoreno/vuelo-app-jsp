package com.johannmoreno.vueloapp.infrastructure.persistence;

import com.johannmoreno.vueloapp.business.exceptions.DuplicateUsuarioException;
import com.johannmoreno.vueloapp.business.exceptions.UsuarioNotFoundException;
import com.johannmoreno.vueloapp.domain.model.Usuario;
import com.johannmoreno.vueloapp.infrastructure.database.ConnectionDbMySql;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioCRUD {

    // Metodo para obtener todos los usuarios
    public List<Usuario> getAllUsuarios() throws SQLException {
        List<Usuario> lista = new ArrayList<>();
        String query = "SELECT * FROM usuarios";
        try (Connection con = ConnectionDbMySql.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                lista.add(new Usuario(
                        rs.getString("id"),
                        rs.getString("clave"),
                        rs.getString("nombre"),
                        rs.getString("rol"),
                        rs.getString("email")
                ));
            }
        }
        return lista;
    }

    // Metodo para agregar un nuevo usuario
    public void addUsuario(Usuario usuario) throws SQLException, DuplicateUsuarioException {
        String query = "INSERT INTO usuarios (id, clave, nombre, rol, email) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, usuario.getId());
            stmt.setString(2, usuario.getClave());
            stmt.setString(3, usuario.getNombre());
            stmt.setString(4, usuario.getRol());
            stmt.setString(5, usuario.getEmail());

            stmt.executeUpdate();
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                throw new DuplicateUsuarioException("El usuario con el id o email ya existe.");
            } else {
                throw e;
            }
        }
    }

    // Metodo para actualizar un usuario
    public void updateUsuario(Usuario usuario) throws SQLException, UsuarioNotFoundException {
        String query = "UPDATE usuarios SET clave=?, nombre=?, rol=?, email=? WHERE id=?";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, usuario.getClave());
            stmt.setString(2, usuario.getNombre());
            stmt.setString(3, usuario.getRol());
            stmt.setString(4, usuario.getEmail());
            stmt.setString(5, usuario.getId());

            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas == 0) {
                throw new UsuarioNotFoundException("El usuario con el id " + usuario.getId() + " no existe.");
            }
        }
    }

    // Metodo para eliminar un usuario
    public void deleteUsuario(String id) throws SQLException, UsuarioNotFoundException {
        String query = "DELETE FROM usuarios WHERE id=?";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, id);

            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas == 0) {
                throw new UsuarioNotFoundException("El usuario con el id " + id + " no existe.");
            }
        }
    }

    // Metodo para obtener un usuario por id
    public Usuario getUsuarioById(String id) throws SQLException, UsuarioNotFoundException {
        String query = "SELECT * FROM usuarios WHERE id=?";
        Usuario usuario = null;
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario(
                            rs.getString("id"),
                            rs.getString("clave"),
                            rs.getString("nombre"),
                            rs.getString("rol"),
                            rs.getString("email")
                    );
                } else {
                    throw new UsuarioNotFoundException("El usuario con el id " + id + " no existe.");
                }
            }
        }
        return usuario;
    }

    // Metodo para obtener un usuario por email
    public Usuario getUsuarioByEmail(String email) throws SQLException, UsuarioNotFoundException {
        String query = "SELECT * FROM usuarios WHERE email=?";
        Usuario usuario = null;
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario(
                            rs.getString("id"),
                            rs.getString("clave"),
                            rs.getString("nombre"),
                            rs.getString("rol"),
                            rs.getString("email")
                    );
                } else {
                    throw new UsuarioNotFoundException("El usuario con el email " + email + " no existe.");
                }
            }
        }
        return usuario;
    }

    // Metodo para buscar usuarios por nombre o email
    public List<Usuario> searchUsuarios(String searchTerm) throws SQLException {
        List<Usuario> lista = new ArrayList<>();
        String query = "SELECT * FROM usuarios WHERE nombre LIKE ? OR email LIKE ?";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, "%" + searchTerm + "%");
            stmt.setString(2, "%" + searchTerm + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(new Usuario(
                            rs.getString("id"),
                            rs.getString("clave"),
                            rs.getString("nombre"),
                            rs.getString("rol"),
                            rs.getString("email")
                    ));
                }
            }
        }
        return lista;
    }

    // ===== REPORTES PARAMETRIZADOS =====

    // Reporte 1: usuarios filtrados por rol
    public List<Usuario> reportePorRol(String rol) throws SQLException {
        List<Usuario> lista = new ArrayList<>();
        String query = "SELECT * FROM usuarios WHERE rol = ?";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, rol);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(new Usuario(
                            rs.getString("id"),
                            rs.getString("clave"),
                            rs.getString("nombre"),
                            rs.getString("rol"),
                            rs.getString("email")
                    ));
                }
            }
        }
        return lista;
    }

    // Reporte 2: usuarios filtrados por dominio de correo (ej: gmail.com)
    public List<Usuario> reportePorDominioEmail(String dominio) throws SQLException {
        List<Usuario> lista = new ArrayList<>();
        String query = "SELECT * FROM usuarios WHERE email LIKE ?";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, "%@" + dominio);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(new Usuario(
                            rs.getString("id"),
                            rs.getString("clave"),
                            rs.getString("nombre"),
                            rs.getString("rol"),
                            rs.getString("email")
                    ));
                }
            }
        }
        return lista;
    }
}