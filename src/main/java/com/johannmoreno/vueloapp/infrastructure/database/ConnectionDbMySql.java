package com.johannmoreno.vueloapp.infrastructure.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDbMySql {

    private static final String URL = "jdbc:mysql://localhost:3306/vuelo_app?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    // Metodo que devuelve una conexion a la base de datos
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("Error: Driver MySQL no encontrado.");
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error: No se pudo establecer la conexion con la base de datos.");
        }
        return connection;
    }
}