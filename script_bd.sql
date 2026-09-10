-- ============================================
-- Script de creacion de base de datos: VueloApp
-- Ejercicio 18: Vuelo
-- Autor: Johann Moreno
-- ============================================

CREATE DATABASE IF NOT EXISTS vuelo_app;
USE vuelo_app;

-- Tabla Usuario (id, clave, nombre, rol)
CREATE TABLE IF NOT EXISTS usuarios (
                                        id VARCHAR(50) PRIMARY KEY,
    clave VARCHAR(255) NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
    );

-- Tabla Vuelo
CREATE TABLE IF NOT EXISTS vuelos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fechaCompra DATE,
    fechaSalida DATETIME,
    fechaLlegada DATETIME,
    agenciaViajes VARCHAR(150),
    aerolinea VARCHAR(100),
    numero VARCHAR(20),
    estado VARCHAR(50),
    valor DECIMAL(12,2),
    cliente VARCHAR(150),
    puesto VARCHAR(10),
    avion VARCHAR(100),
    aeropuertoSalida VARCHAR(150),
    aeropuertoLlegada VARCHAR(150),
    piloto VARCHAR(150)
    );

-- ============================================
-- Datos iniciales
-- ============================================

INSERT INTO usuarios (id, clave, nombre, rol, email) VALUES
    ('U001', '1234', 'Admin Principal', 'ADMIN', 'admin@vueloapp.com');

INSERT INTO vuelos (fechaCompra, fechaSalida, fechaLlegada, agenciaViajes, aerolinea, numero, estado, valor, cliente, puesto, avion, aeropuertoSalida, aeropuertoLlegada, piloto) VALUES
                                                                                                                                                                                      ('2026-08-01', '2026-09-15 08:30:00', '2026-09-15 11:00:00', 'Despegar Travel', 'Avianca', 'AV205', 'Confirmado', 850000.00, 'Carlos Perez', '12A', 'Airbus A320', 'Bogota (BOG)', 'Cartagena (CTG)', 'Juan Torres'),
                                                                                                                                                                                      ('2026-08-03', '2026-09-20 14:00:00', '2026-09-20 16:30:00', 'Viajes Express', 'LATAM', 'LA452', 'Pendiente', 620000.00, 'Maria Gomez', '8C', 'Boeing 737', 'Medellin (MDE)', 'Cali (CLO)', 'Ana Ramirez'),
                                                                                                                                                                                      ('2026-08-05', '2026-09-22 06:00:00', '2026-09-22 07:45:00', 'Despegar Travel', 'Avianca', 'AV310', 'Cancelado', 450000.00, 'Pedro Diaz', '20B', 'Airbus A320', 'Cartagena (CTG)', 'Bogota (BOG)', 'Juan Torres'),
                                                                                                                                                                                      ('2026-08-10', '2026-09-25 19:15:00', '2026-09-25 21:00:00', 'Viajes Express', 'Wingo', 'WG117', 'Completado', 380000.00, 'Laura Castro', '5A', 'Boeing 737', 'Bogota (BOG)', 'Barranquilla (BAQ)', 'Sofia Leon');