<%@ page import="java.sql.*" %>
<%@ page import="com.whiteboard.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Whiteboard Pro Dashboard</title>
<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#f0f2f7;
}
/* TOPBAR */
.topbar{
    height:60px;
    background: linear-gradient(90deg,#4a90e2,#2d6cdf);
    color:white;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 20px;
    box-shadow:0 3px 6px rgba(0,0,0,0.2);
}
.topbar .logo{
    font-size:22px;font-weight:600;
}
.topbar input.search{
    border:none;
    padding:8px 12px;
    border-radius:6px;
    width:300px;
    transition:0.2s;
}
.topbar input.search:focus{
    outline:none;
    box-shadow:0 0 8px rgba(0,0,0,0.2);
}
/* TOPBAR ICONS */
.topbar .top-right i, .topbar .top-right button{
    margin-left:12px;
    cursor:pointer;
    transition:0.2s;
}
.topbar .top-right i:hover, .topbar .top-right button:hover{opacity:0.85;}
.topbar .top-right button{padding:6px 12px;border-radius:6px;background:#fff;color:#2d6cdf;border:none;font-weight:600;}

/* SIDEBAR */
.sidebar{
    width:200px;
    background:#fff;
    position:fixed;
    top:60px;
    bottom:0;
    border-right:1px solid #ddd;
    padding-top:20px;
}
.sidebar ul{
    list-style:none;
    padding:0;
}
.sidebar ul li{
    padding:12px 20px;
    cursor:pointer;
    transition:0.2s;
    border-radius:6px;
}
.sidebar ul li:hover{
    background:#eef2ff;
}

/* MAIN CONTENT */
.main{
    margin-left:220px;
    padding:20px;
}
h3{
    margin-bottom:10px;
}
.actions{
    display:flex;
    gap:20px;
    flex-wrap:wrap;
}
.action-card{
    width:200px;
    height:100px;
    background:#fff;
    display:flex;
    flex-direction:column;
    align-items:center;
    justify-content:center;
    font-size:18px;
    font-weight:600;
    border-radius:12px;
    cursor:pointer;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    text-decoration:none;
    transition:0.3s;
}
.action-card i{
    font-size:24px;
    margin-bottom:6px;
    transition:0.3s;
}
.action-card:hover{
    transform:translateY(-5px) scale(1.05);
    background: linear-gradient(135deg,#2d6cdf,#4a90e2);
    color:white;
}
.action-card:hover i{
    color:white;
}

/* BOARDS */
.boards{
    display:flex;
    gap:60px;   /* more space between cards */
    flex-wrap:wrap;
    margin-top:15px;
}
.board-card{
    width:240px;
    background:#fff;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    overflow:hidden;
    text-align:center;
    transition:0.3s;
}
.board-card:hover{transform:scale(1.05);}
.board-card img{width:100%;height:120px;object-fit:cover;}
.board-card h5{margin:10px 0;}
.board-card button.open{
    background:#2d6cdf;color:white;border:none;padding:6px 12px;border-radius:6px;cursor:pointer;transition:0.2s;
}
.board-card button.open:hover{opacity:0.85;}

/* TEMPLATES */
.templates{
    display:flex;
    gap:20px;
    flex-wrap:wrap;
    margin-top:10px;
}
.template{
    padding:12px 20px;
    background:#fff;
    border-radius:12px;
    cursor:pointer;
    font-size:16px;
    font-weight:600;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    transition:0.3s;
    text-align:center;
    user-select:none;
}
.template:hover{
    transform:scale(1.05);
    background: linear-gradient(135deg,#2d6cdf,#4a90e2);
    color:white;
    text-decoration:none;
}

/* RIGHT PANEL */
.right{
    position:fixed;
    right:0;
    top:60px;
    bottom:0;
    width:150px;
    background:#fff;
    border-left:1px solid #ddd;
    padding:20px;
    overflow-y:auto;
}
.right h4{margin-top:0;margin-bottom:10px;}
.right ul{list-style:none;padding:0;}
.right ul li{padding:6px 0;border-bottom:1px solid #eee;font-size:14px;}
.right button.call{
    width:100%;padding:8px 12px;background:#2d6cdf;color:white;border:none;border-radius:6px;cursor:pointer;transition:0.2s;
}
.right button.call:hover{opacity:0.85;}
.right textarea{
    width:100%;border-radius:6px;padding:8px;border:1px solid #ccc;font-family:'Segoe UI';resize:none;margin-top:5px;
}

/* COMMENT BAR */
.comment{
    position:fixed;
    bottom:0; left:220px; right:250px;
    background:#fff;
    padding:10px;
    border-top:1px solid #ddd;
    display:flex;
}
.comment input{
    flex:1;
    padding:8px 12px;
    border-radius:6px;
    border:1px solid #ccc;
}

/* SEARCH FUNCTIONALITY HIGHLIGHT */
.search-active{
    border:1px solid #2d6cdf;
    box-shadow:0 0 8px rgba(45,108,207,0.5);
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body>

<!-- TOPBAR -->
<div class="topbar">
    <div class="logo">Whiteboard Pro</div>
    <input type="text" class="search" placeholder="Search boards..." id="searchInput">
    <div class="top-right">
        
        <a href="logout.jsp">
<button style="background:red;color:white;border:none;padding:6px 12px;border-radius:6px;margin-left:10px;">
Logout
</button>
</a>
    </div>
</div>

<!-- SIDEBAR -->
<div class="sidebar">
    <ul>
        <li onclick="location.href='dashboard'">
            <i class="bi bi-house-door"></i> Dashboard
        </li>
        <li onclick="location.href='template.jsp'">
            <i class="bi bi-gear"></i> Templates
        </li>
        <li onclick="location.href='setting.jsp'">
            <i class="bi bi-gear"></i> Settings
        </li>
        <li onclick="location.href='logout.jsp'">
            <i class="bi bi-box-arrow-right"></i> Logout
        </li>
    </ul>
</div>

<!-- MAIN CONTENT -->
<div class="main">
<h3>Quick Actions</h3>
<div class="actions">
   <a href="whiteboard.jsp" class="action-card">
<i class="bi bi-plus-lg"></i>
Create New Board
</a>

<div class="action-card" onclick="document.getElementById('importBoardFile').click()">
<i class="bi bi-upload"></i>
Import Board
<input type="file"
       id="importBoardFile"
       accept="image/*"
       style="display:none"
       onchange="importBoardFromDashboard(event)">
</div>

<a href="<%= request.getContextPath() %>/layout.jsp?page=template" class="action-card">
<i class="bi bi-folder"></i>
Use Template
</a>

<a href="whiteboard.jsp?room=team" class="action-card">
<i class="bi bi-people"></i>
Start Team Session
</a>
</div>

<h3>Recent Boards</h3>
<div class="boards" id="boardsContainer">
    <div class="board-card">
        <img src="${pageContext.request.contextPath}/images/pp.jpeg">
        <h5>Project Planning</h5>
        <a href="whiteboard.jsp"><button class="open">Open Board</button></a>
    </div>
    <div class="board-card">
        <img src="${pageContext.request.contextPath}/images/qq.jpeg">
        <h5>Marketing Strategy</h5>
        <a href="whiteboard.jsp"><button class="open">Open Board</button></a>
    </div>
    <div class="board-card">
        <img src="${pageContext.request.contextPath}/images/rr.avif">
        <h5>Design Map</h5>
        <a href="whiteboard.jsp"><button class="open">Open Board</button></a>
    </div>
</div>

<h3>Templates</h3>
<div class="templates" id="templateContainer">
    <div class="template" onclick="openTemplate('brainstorm')">💡 Brainstorm</div>
    <div class="template" onclick="openTemplate('mindmap')">🧠 Mind Map</div>
    <div class="template" onclick="openTemplate('kanban')">📋 Kanban</div>
    <div class="template" onclick="openTemplate('sprint')">📅 Sprint Planning</div>
</div>
</div>

<!-- RIGHT PANEL -->
<div class="right">
<h4>Team Active</h4>

<ul>

<%
Connection con = DBConnection.getConnection();

PreparedStatement ps1 = con.prepareStatement(
"SELECT distinct(name) FROM users "
);

ResultSet rs1 = ps1.executeQuery();

while(rs1.next()){
%>

<li>🟢 <%= rs1.getString("name") %></li>

<%
}
%>

</ul>
<h4>Active Now</h4>

<ul>

<%
//Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
"SELECT name FROM users WHERE status='online'"
);

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<li>🟢 <%= rs.getString("name") %></li>

<%
}
%>

</ul>

<button class="call">Start Call</button>
<h4>Your Notes</h4>
<textarea placeholder="Add a note..."></textarea>
</div>

<!-- COMMENT BAR -->
<div class="comment">
    <input type="text" placeholder="Add a comment...">
</div>

<script>
function importBoardFromDashboard(event){
    const file = event.target.files[0];
    if(!file) return;
    const reader = new FileReader();
    reader.onload = function(e){
        localStorage.setItem("importBoardImage", e.target.result);
        window.location.href="whiteboard.jsp";
    };
    reader.readAsDataURL(file);
}

// Search functionality
const searchInput = document.getElementById("searchInput");
searchInput.addEventListener("input", function(){
    const query = this.value.toLowerCase();
    const boards = document.querySelectorAll("#boardsContainer .board-card");
    boards.forEach(board=>{
        const title = board.querySelector("h5").innerText.toLowerCase();
        if(title.includes(query)){
            board.style.display="block";
        } else {
            board.style.display="none";
        }
    });
});

function openTemplate(type){

	localStorage.setItem("boardTemplate", type);

	window.location.href="whiteboard.jsp";

	}
</script>
</body>
</html>