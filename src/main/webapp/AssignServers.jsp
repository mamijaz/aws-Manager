<%--
  Created by IntelliJ IDEA.
  User: ijaz-wso2telco
  Date: 11/18/2016
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.wso2telco.aws.*"%>
<%@ page import="com.amazonaws.regions.Regions" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Assign Servers</title>
    <link rel="stylesheet" href="styles.css">
    <script type="text/javascript" src="script.js"></script>
    <script src="jquery-3.1.1.js"></script>
    <%
        session.setAttribute("username", request.getParameter("username"));
        session.setAttribute("type", request.getParameter("type"));
        session.setAttribute("forUser", request.getParameter("forUser"));
    %>
</head>
<body>

<input type="button" class="btnlogout" value="Log Out" onclick=logout()>
<p class="ploginas">Loged as : <%=request.getParameter("username")%></p>

<div class="title">
    <h3>Assigned Servers</h3>
</div>

<table class="table-fill">
    <thead>
    <tr>
        <th class="text-left"><center>Region</center></th>
        <th class="text-left"><center>Name</center></th></center>
        <th class="text-left"><center>Instance Id</center></th></center>
        <th class="text-left"><center>Remove</center></th></center>
    </tr>
    </thead>
    <tbody class="table-hover">

    <%
        ResultSet rs1 =H2DB.getAssingedServers(request.getParameter("forUser"));

        int i=0;
        while (rs1.next()){
    %><tr><%

    %><td class="text-left"><%=AWS.getServerLocationName(rs1.getString("REGION"))%></td><%
    %><td class="text-left"><%=rs1.getString("NAME")%></td><%
    %><td class="text-left"><%=rs1.getString("INSTANCEID")%></td><%

    %></tr><%

            i++;
        }
    %>

    </tbody>
</table>


<div class="title">
    <h3>Un-Assigned Servers</h3>
</div>

<table class="table-fill">
    <thead>
    <tr>
        <th class="text-left"><center>Region</center></th>
        <th class="text-left"><center>Name</center></th></center>
        <th class="text-left"><center>Instance Id</center></th></center>
        <th class="text-left"><center>Add</center></th></center>
    </tr>
    </thead>
    <tbody class="table-hover">

    <%
        ResultSet rs2 =H2DB.getUnAssingedServers(request.getParameter("forUser"));

        int j=0;
        while (rs2.next()){
    %><tr><%

    %><td class="text-left"><%=AWS.getServerLocationName(rs2.getString("REGION"))%></td><%
    %><td class="text-left"><%=rs2.getString("NAME")%></td><%
    %><td class="text-left"><%=rs2.getString("INSTANCEID")%></td><%

    %></tr><%

            j++;
        }
    %>

    </tbody>
</table>



</body>
</html>
