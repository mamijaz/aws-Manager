<%--
  Created by IntelliJ IDEA.
  User: ijaz-wso2telco
  Date: 11/18/2016
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Home</title>
    <link rel="stylesheet" href="styles.css">
    <script type="text/javascript" src="script.js"></script>
    <script src="jquery-3.1.1.js"></script>
    <%
        session.setAttribute("username", request.getParameter("username"));
        session.setAttribute("type", request.getParameter("type"));
    %>
</head>
<body>

<input type="button" class="btnlogout" value="Log Out" onclick=logout()>
<p class="ploginas">Loged as : <%=request.getParameter("username")%></p>

<div class="title">
    <h3>User Home</h3>
</div>
    <center><input type="button" id="StartOrStopServers" class="btnhome" value="Start / Stop Servers" style="margin-top: 100px" onclick="location.href='StartOrStopServers.jsp?username='+'<%=request.getParameter("username")%>'+'&type='+'<%=request.getParameter("type")%>'"></center>
<%
    if(request.getParameter("type").equals("admin")){
        %><center><input type="button" id="AddOrRemoveServers"class="btnhome" value="Add / Remove Servers" onclick="location.href='AddOrRemoveServers.jsp?username='+'<%=request.getParameter("username")%>'+'&type='+'<%=request.getParameter("type")%>'"></center><%
        %><center><input type="button" id="ManageUsers"class="btnhome" value="Manage Users" onclick="location.href='Manage Users.jsp?username='+'<%=request.getParameter("username")%>'+'&type='+'<%=request.getParameter("type")%>'"></center><%
    }
%>

</body>
</html>
