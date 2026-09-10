package com.johannmoreno.vueloapp.domain.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Vuelo {
    private Integer id;
    private LocalDate fechaCompra;
    private LocalDateTime fechaSalida;
    private LocalDateTime fechaLlegada;
    private String agenciaViajes;
    private String aerolinea;
    private String numero;
    private String estado;
    private BigDecimal valor;
    private String cliente;
    private String puesto;
    private String avion;
    private String aeropuertoSalida;
    private String aeropuertoLlegada;
    private String piloto;

    public Vuelo() {
    }

    public Vuelo(Integer id, LocalDate fechaCompra, LocalDateTime fechaSalida, LocalDateTime fechaLlegada,
                 String agenciaViajes, String aerolinea, String numero, String estado, BigDecimal valor,
                 String cliente, String puesto, String avion, String aeropuertoSalida,
                 String aeropuertoLlegada, String piloto) {
        this.id = id;
        this.fechaCompra = fechaCompra;
        this.fechaSalida = fechaSalida;
        this.fechaLlegada = fechaLlegada;
        this.agenciaViajes = agenciaViajes;
        this.aerolinea = aerolinea;
        this.numero = numero;
        this.estado = estado;
        this.valor = valor;
        this.cliente = cliente;
        this.puesto = puesto;
        this.avion = avion;
        this.aeropuertoSalida = aeropuertoSalida;
        this.aeropuertoLlegada = aeropuertoLlegada;
        this.piloto = piloto;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDate getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(LocalDate fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public LocalDateTime getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(LocalDateTime fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public LocalDateTime getFechaLlegada() {
        return fechaLlegada;
    }

    public void setFechaLlegada(LocalDateTime fechaLlegada) {
        this.fechaLlegada = fechaLlegada;
    }

    public String getAgenciaViajes() {
        return agenciaViajes;
    }

    public void setAgenciaViajes(String agenciaViajes) {
        this.agenciaViajes = agenciaViajes;
    }

    public String getAerolinea() {
        return aerolinea;
    }

    public void setAerolinea(String aerolinea) {
        this.aerolinea = aerolinea;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    public String getAvion() {
        return avion;
    }

    public void setAvion(String avion) {
        this.avion = avion;
    }

    public String getAeropuertoSalida() {
        return aeropuertoSalida;
    }

    public void setAeropuertoSalida(String aeropuertoSalida) {
        this.aeropuertoSalida = aeropuertoSalida;
    }

    public String getAeropuertoLlegada() {
        return aeropuertoLlegada;
    }

    public void setAeropuertoLlegada(String aeropuertoLlegada) {
        this.aeropuertoLlegada = aeropuertoLlegada;
    }

    public String getPiloto() {
        return piloto;
    }

    public void setPiloto(String piloto) {
        this.piloto = piloto;
    }
}