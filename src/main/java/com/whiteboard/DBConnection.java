package com.whiteboard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DBConnection {

    public static Connection getConnection() {

        Connection con = null;

        try {

            Class.forName("org.postgresql.Driver");

            con = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5432/kaveri",
                    "kaveri",
                    "kaveri07");
            if(con!=null) {
            	PreparedStatement ps=con.prepareStatement("INSERT INTO users(name,email,password) VALUES(?,?,?)");
            }

            System.out.println("Database Connected Successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}