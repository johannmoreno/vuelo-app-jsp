package com.johannmoreno.vueloapp.infrastructure.persistence;

import com.johannmoreno.vueloapp.business.exceptions.VueloNotFoundException;
import com.johannmoreno.vueloapp.domain.model.Vuelo;
import com.johannmoreno.vueloapp.infrastructure.database.ConnectionDbMySql;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class VueloCRUD {

    // Metodo auxiliar para construir un Vuelo desde un ResultSet
    private Vuelo mapRow(ResultSet rs) throws SQLException {
        Vuelo vuelo = new Vuelo();
        vuelo.setId(rs.getInt("id"));

        Date fechaCompra = rs.getDate("fechaCompra");
        vuelo.setFechaCompra(fechaCompra != null ? fechaCompra.toLocalDate() : null);

        Timestamp fechaSalida = rs.getTimestamp("fechaSalida");
        vuelo.setFechaSalida(fechaSalida != null ? fechaSalida.toLocalDateTime() : null);

        Timestamp fechaLlegada = rs.getTimestamp("fechaLlegada");
        vuelo.setFechaLlegada(fechaLlegada != null ? fechaLlegada.toLocalDateTime() : null);

        vuelo.setAgenciaViajes(rs.getString("agenciaViajes"));
        vuelo.setAerolinea(rs.getString("aerolinea"));
        vuelo.setNumero(rs.getString("numero"));
        vuelo.setEstado(rs.getString("estado"));
        vuelo.setValor(rs.getBigDecimal("valor"));
        vuelo.setCliente(rs.getString("cliente"));
        vuelo.setPuesto(rs.getString("puesto"));
        vuelo.setAvion(rs.getString("avion"));
        vuelo.setAeropuertoSalida(rs.getString("aeropuertoSalida"));
        vuelo.setAeropuertoLlegada(rs.getString("aeropuertoLlegada"));
        vuelo.setPiloto(rs.getString("piloto"));

        return vuelo;
    }

    // Metodo para obtener todos los vuelos
    public List<Vuelo> getAllVuelos() throws SQLException {
        List<Vuelo> lista = new ArrayList<>();
        String query = "SELECT * FROM vuelos";
        try (Connection con = ConnectionDbMySql.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                lista.add(mapRow(rs));
            }
        }
        return lista;
    }

    // Metodo para agregar un nuevo vuelo
    public void addVuelo(Vuelo vuelo) throws SQLException {
        String query = "INSERT INTO vuelos (fechaCompra, fechaSalida, fechaLlegada, agenciaViajes, aerolinea, " +
                "numero, estado, valor, cliente, puesto, avion, aeropuertoSalida, aeropuertoLlegada, piloto) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setDate(1, vuelo.getFechaCompra() != null ? Date.valueOf(vuelo.getFechaCompra()) : null);
            stmt.setTimestamp(2, vuelo.getFechaSalida() != null ? Timestamp.valueOf(vuelo.getFechaSalida()) : null);
            stmt.setTimestamp(3, vuelo.getFechaLlegada() != null ? Timestamp.valueOf(vuelo.getFechaLlegada()) : null);
            stmt.setString(4, vuelo.getAgenciaViajes());
            stmt.setString(5, vuelo.getAerolinea());
            stmt.setString(6, vuelo.getNumero());
            stmt.setString(7, vuelo.getEstado());
            stmt.setBigDecimal(8, vuelo.getValor());
            stmt.setString(9, vuelo.getCliente());
            stmt.setString(10, vuelo.getPuesto());
            stmt.setString(11, vuelo.getAvion());
            stmt.setString(12, vuelo.getAeropuertoSalida());
            stmt.setString(13, vuelo.getAeropuertoLlegada());
            stmt.setString(14, vuelo.getPiloto());

            stmt.executeUpdate();
        }
    }

    // Metodo para actualizar un vuelo
    public void updateVuelo(Vuelo vuelo) throws SQLException, VueloNotFoundException {
        String query = "UPDATE vuelos SET fechaCompra=?, fechaSalida=?, fechaLlegada=?, agenciaViajes=?, " +
                "aerolinea=?, numero=?, estado=?, valor=?, cliente=?, puesto=?, avion=?, aeropuertoSalida=?, " +
                "aeropuertoLlegada=?, piloto=? WHERE id=?";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setDate(1, vuelo.getFechaCompra() != null ? Date.valueOf(vuelo.getFechaCompra()) : null);
            stmt.setTimestamp(2, vuelo.getFechaSalida() != null ? Timestamp.valueOf(vuelo.getFechaSalida()) : null);
            stmt.setTimestamp(3, vuelo.getFechaLlegada() != null ? Timestamp.valueOf(vuelo.getFechaLlegada()) : null);
            stmt.setString(4, vuelo.getAgenciaViajes());
            stmt.setString(5, vuelo.getAerolinea());
            stmt.setString(6, vuelo.getNumero());
            stmt.setString(7, vuelo.getEstado());
            stmt.setBigDecimal(8, vuelo.getValor());
            stmt.setString(9, vuelo.getCliente());
            stmt.setString(10, vuelo.getPuesto());
            stmt.setString(11, vuelo.getAvion());
            stmt.setString(12, vuelo.getAeropuertoSalida());
            stmt.setString(13, vuelo.getAeropuertoLlegada());
            stmt.setString(14, vuelo.getPiloto());
            stmt.setInt(15, vuelo.getId());

            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas == 0) {
                throw new VueloNotFoundException("El vuelo con el id " + vuelo.getId() + " no existe.");
            }
        }
    }

    // Metodo para eliminar un vuelo
    public void deleteVuelo(Integer id) throws SQLException, VueloNotFoundException {
        String query = "DELETE FROM vuelos WHERE id=?";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, id);

            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas == 0) {
                throw new VueloNotFoundException("El vuelo con el id " + id + " no existe.");
            }
        }
    }

    // Metodo para obtener un vuelo por id
    public Vuelo getVueloById(Integer id) throws SQLException, VueloNotFoundException {
        String query = "SELECT * FROM vuelos WHERE id=?";
        Vuelo vuelo = null;
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    vuelo = mapRow(rs);
                } else {
                    throw new VueloNotFoundException("El vuelo con el id " + id + " no existe.");
                }
            }
        }
        return vuelo;
    }

    // ===== REPORTES PARAMETRIZADOS =====

    // Reporte 1: vuelos filtrados por aerolinea y rango de fechas de salida
    public List<Vuelo> reportePorAerolineaYFechas(String aerolinea, LocalDate desde, LocalDate hasta) throws SQLException {
        List<Vuelo> lista = new ArrayList<>();
        String query = "SELECT * FROM vuelos WHERE aerolinea = ? AND fechaSalida BETWEEN ? AND ?";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, aerolinea);
            stmt.setTimestamp(2, Timestamp.valueOf(desde.atStartOfDay()));
            stmt.setTimestamp(3, Timestamp.valueOf(hasta.atTime(23, 59, 59)));

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapRow(rs));
                }
            }
        }
        return lista;
    }

    // Reporte 2: vuelos filtrados por estado y con valor mayor o igual a un monto minimo
    public List<Vuelo> reportePorEstadoYValorMinimo(String estado, BigDecimal valorMinimo) throws SQLException {
        List<Vuelo> lista = new ArrayList<>();
        String query = "SELECT * FROM vuelos WHERE estado = ? AND valor >= ?";
        try (Connection con = ConnectionDbMySql.getConnection();
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, estado);
            stmt.setBigDecimal(2, valorMinimo);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapRow(rs));
                }
            }
        }
        return lista;
    }
}