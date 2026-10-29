package com.whiteboard;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.whiteboard.Activity; 

@WebServlet("/dashboard")
public class dashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Activity> activityList = new ArrayList<>();
        
        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DBConnection.getConnection();
            String sql = "SELECT username, action_text FROM team_activity ORDER BY action_time DESC LIMIT 4";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            
            while(rs.next()) {
                activityList.add(new Activity(
                    rs.getString("username"), 
                    rs.getString("action_text")
                ));
            }
            
            rs.close();
            stmt.close();
            con.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("activities", activityList);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}