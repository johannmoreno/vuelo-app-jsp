package com.johannmoreno.vueloapp.business.services;

import com.johannmoreno.vueloapp.business.exceptions.VueloNotFoundException;
import com.johannmoreno.vueloapp.domain.model.Vuelo;
import com.johannmoreno.vueloapp.infrastructure.persistence.VueloCRUD;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class VueloService {

    private final VueloCRUD vueloCrud;

    public VueloService() {
        this.vueloCrud = new VueloCRUD();
    }

    // Metodo para obtener todos los vuelos
    public List<Vuelo> getAllVuelos() throws SQLException {
        return vueloCrud.getAllVuelos();
    }

    // Metodo para crear un nuevo vuelo
    public void createVuelo(LocalDate fechaCompra, LocalDateTime fechaSalida, LocalDateTime fechaLlegada,
                            String agenciaViajes, String aerolinea, String numero, String estado,
                            BigDecimal valor, String cliente, String puesto, String avion,
                            String aeropuertoSalida, String aeropuertoLlegada, String piloto) throws SQLException {
        Vuelo vuelo = new Vuelo(null, fechaCompra, fechaSalida, fechaLlegada, agenciaViajes, aerolinea,
                numero, estado, valor, cliente, puesto, avion, aeropuertoSalida, aeropuertoLlegada, piloto);
        vueloCrud.addVuelo(vuelo);
    }

    // Metodo para actualizar un vuelo
    public void updateVuelo(Integer id, LocalDate fechaCompra, LocalDateTime fechaSalida, LocalDateTime fechaLlegada,
                            String agenciaViajes, String aerolinea, String numero, String estado,
                            BigDecimal valor, String cliente, String puesto, String avion,
                            String aeropuertoSalida, String aeropuertoLlegada, String piloto)
            throws VueloNotFoundException, SQLException {
        Vuelo vuelo = new Vuelo(id, fechaCompra, fechaSalida, fechaLlegada, agenciaViajes, aerolinea,
                numero, estado, valor, cliente, puesto, avion, aeropuertoSalida, aeropuertoLlegada, piloto);
        vueloCrud.updateVuelo(vuelo);
    }

    // Metodo para eliminar un vuelo
    public void deleteVuelo(Integer id) throws VueloNotFoundException, SQLException {
        vueloCrud.deleteVuelo(id);
    }

    // Metodo para obtener un vuelo por id
    public Vuelo getVueloById(Integer id) throws VueloNotFoundException, SQLException {
        return vueloCrud.getVueloById(id);
    }

    // Reporte 1: por aerolinea y rango de fechas
    public List<Vuelo> reportePorAerolineaYFechas(String aerolinea, LocalDate desde, LocalDate hasta) throws SQLException {
        return vueloCrud.reportePorAerolineaYFechas(aerolinea, desde, hasta);
    }

    // Reporte 2: por estado y valor minimo
    public List<Vuelo> reportePorEstadoYValorMinimo(String estado, BigDecimal valorMinimo) throws SQLException {
        return vueloCrud.reportePorEstadoYValorMinimo(estado, valorMinimo);
    }
}