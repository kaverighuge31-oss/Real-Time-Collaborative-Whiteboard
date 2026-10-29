<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .content {
            padding: 20px;
            background: #f4f6f9;
            min-height: 100vh;
        }
    </style>
</head>

<body>

<div class="content">

<%
String pageName = request.getParameter("page");

if (pageName == null) {
    pageName = "dashboard";
}

if (pageName.equals("dashboard")) {
%>
    <jsp:include page="dashboard.jsp" />
<%
}
else if (pageName.equals("template")) {
%>
    <jsp:include page="template.jsp" />
<%
}
else if (pageName.equals("whiteboard")) {
%>
    <jsp:include page="whiteboard.jsp" />
<%
}
else {
%>
    <h2>Page Not Found</h2>
<%
}
%>

</div>

</body>
</html>