package com.whiteboard;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class Login extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            String sql =
              "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
            	PreparedStatement ps2 = con.prepareStatement(
            			"UPDATE users SET status='online' WHERE email=?"
            			);

            			ps2.setString(1,email);
            			ps2.executeUpdate();

            			HttpSession session = request.getSession();
            			session.setAttribute("email", email);

                response.sendRedirect("dashboard.jsp");

            } else {

            	response.sendRedirect("register.html?msg=GET REGISTER FIRST");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}