<%--
  Created by IntelliJ IDEA.
  User: ijaz-wso2telco
  Date: 11/18/2016
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.wso2telco.aws.H2DB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add/Remove Users</title>
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
    <h3>Add / Remove Users</h3>
</div>

<table class="table-fill" id="UserList">
    <thead>
    <tr>
        <th class="text-left"><center>Name</center></th></center>
        <th class="text-left"><center>Type</center></th></center>
        <th class="text-left"><center>Remove</center></th></center>
        <th class="text-left"><center>Assign Servers</center></th></center>
    </tr>
    </thead>
    <tbody class="table-hover">
    <%
        ResultSet rs= H2DB.getUsers();
        int i=0;
        while (rs.next()){
    %><tr id="row_<%=i%>"><%
    %><td class="text-left"><%=rs.getString("USERNAME")%></td><%
    %><td class="text-left"><%=rs.getString("TYPE")%></td><%
    %><td><center><input type="button" value="Remove" onclick=removeUser("<%=rs.getString("USERNAME")%>")></center></td><%
    %><td><center><input type="button" value="Assign" onclick="location.href='AssignServers.jsp?username='+'<%=request.getParameter("username")%>'+'&type='+'<%=request.getParameter("type")%>'+'&forUser='+'<%=rs.getString("USERNAME")%>'"></center></td><%
    %></tr><%
            i++;
        }
    %>
    </tbody>
</table>

<fieldset class="fieldset">
    <legend>Add New User</legend>
    <input type="text" class="inputBox" id="userName"  placeholder="User Name" required="required" /><br>
    <input type="text" class="inputBox" id="password"  placeholder="Password" required="required" /><br>
    <select id="userType" class="inputBox">
        <option value="user">User</option>
        <option value="admin">Admin</option>
    </select><br>
    <input type="button" class="btnAddUser" value="Add User" onclick=addUser()>
</fieldset>

</body>
</html>
