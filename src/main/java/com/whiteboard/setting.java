package com.whiteboard;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateSettings")
public class setting extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String newName = request.getParameter("name");
        String newPassword = request.getParameter("password");

        if (email == null) {
            response.sendRedirect("login.html");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();
            String sql;
            PreparedStatement ps;

            // If user provided a new password, update it too
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                sql = "UPDATE users SET name=?, password=? WHERE email=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, newName);
                ps.setString(2, newPassword);
                ps.setString(3, email);
            } else {
                // Only update name
                sql = "UPDATE users SET name=? WHERE email=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, newName);
                ps.setString(2, email);
            }

            int rows = ps.executeUpdate();
            con.close();

            if (rows > 0) {
                response.sendRedirect("settings.jsp?status=success");
            } else {
                response.sendRedirect("settings.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("settings.jsp?status=error");
        }
    }
}