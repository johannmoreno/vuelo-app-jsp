package com.johannmoreno.vueloapp.infrastructure.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDbMySql {

    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    private static String getEnvOrDefault(String key, String defaultValue) {
        String value = System.getenv(key);
        return (value != null && !value.isEmpty()) ? value : defaultValue;
    }

    public static Connection getConnection() throws SQLException {
        String host = getEnvOrDefault("MYSQLHOST", "localhost");
        String port = getEnvOrDefault("MYSQLPORT", "3306");
        String database = getEnvOrDefault("MYSQLDATABASE", "vuelo_app");
        String user = getEnvOrDefault("MYSQLUSER", "root");
        String password = getEnvOrDefault("MYSQLPASSWORD", "");

        String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?serverTimezone=UTC";

        Connection connection = null;
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(url, user, password);
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