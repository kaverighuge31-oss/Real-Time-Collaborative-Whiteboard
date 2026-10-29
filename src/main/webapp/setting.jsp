<%@ page import="java.sql.*, com.whiteboard.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Settings - Whiteboard Pro</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { margin:0; font-family:'Segoe UI', sans-serif; background:#f8fafc; display: flex; flex-direction: column; height: 100vh; }
        .topbar { height:60px; background: linear-gradient(90deg,#4a90e2,#2d6cdf); color:white; display:flex; align-items:center; padding:0 20px; box-shadow:0 2px 5px rgba(0,0,0,0.1); }
        .main-layout { display: flex; flex: 1; }
        .sidebar { width:220px; background:#fff; border-right:1px solid #ddd; padding:20px; }
        .sidebar ul { list-style:none; padding:0; }
        .sidebar li { padding:12px; cursor:pointer; border-radius:8px; transition: 0.2s; color: #64748b; }
        .sidebar li:hover { background:#f1f5f9; color:#2d6cdf; }
        
        .settings-container { flex: 1; padding: 40px; display: flex; justify-content: center; }
        .settings-card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); width: 100%; max-width: 500px; height: fit-content; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 8px; color: #334155; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box; }
        
        .save-btn { width: 100%; padding: 12px; background: #2d6cdf; color: white; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; transition: 0.3s; }
        .save-btn:hover { background: #1e4ea1; }
        .msg { padding: 10px; border-radius: 6px; margin-bottom: 15px; text-align: center; font-size: 14px; }
        .success { background: #dcfce7; color: #166534; }
        .error { background: #fee2e2; color: #991b1b; }
    </style>
</head>
<body>

<%
    String email = (String) session.getAttribute("email");
    if(email == null) { response.sendRedirect("login.html"); return; }
    
    String currentName = "";
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT name FROM users WHERE email=?");
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) currentName = rs.getString("name");
        con.close();
    } catch(Exception e) { e.printStackTrace(); }
%>

<div class="topbar">
    <div style="font-size:20px; font-weight:bold;">🧠 Whiteboard Pro</div>
</div>

<div class="main-layout">
    <div class="sidebar">
    <ul>
        <li onclick="location.href='dashboard'">
            <i class="bi bi-house-door"></i> Dashboard
        </li>
        <li style="background:#eef2ff; color:#2d6cdf;">
            <i class="bi bi-gear"></i> Settings
        </li>
        <li onclick="location.href='logout.jsp'">
            <i class="bi bi-box-arrow-right"></i> Logout
        </li>
    </ul>
</div>

    <div class="settings-container">
        <div class="settings-card">
            <h2 style="margin-top:0;">Profile Settings</h2>
            
            <% if(request.getParameter("status") != null && request.getParameter("status").equals("success")) { %>
                <div class="msg success">Profile updated successfully!</div>
            <% } %>

            <form action="updateSettings" method="POST">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" value="<%= currentName %>" required>
                </div>
                <div class="form-group">
                    <label>Email Address (Cannot change)</label>
                    <input type="email" value="<%= email %>" disabled style="background: #f1f5f9; cursor: not-allowed;">
                </div>
                <div class="form-group">
                    <label>New Password</label>
                    <input type="password" name="password" placeholder="Leave blank to keep current password">
                </div>
                
                <button type="submit" class="save-btn">Save Changes</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>