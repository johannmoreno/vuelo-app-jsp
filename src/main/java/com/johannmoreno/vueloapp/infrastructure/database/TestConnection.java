package com.johannmoreno.vueloapp.infrastructure.database;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        try {
            Connection con = ConnectionDbMySql.getConnection();
            System.out.println("Conexion exitosa: " + con);
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}