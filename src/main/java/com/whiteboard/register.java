package com.whiteboard;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/register")
public class register extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO users(name,email,password) VALUES(?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            int i = ps.executeUpdate();

            if (i > 0) {

            	response.sendRedirect("login.html");
            	return;

            } else {

                out.println("Registration Failed");

            }

        } catch (Exception e) {

            e.printStackTrace();
            out.println("Database Error: " + e.getMessage());

        }

    }
}