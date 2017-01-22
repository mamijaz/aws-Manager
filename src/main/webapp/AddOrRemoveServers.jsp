<%--
  Created by IntelliJ IDEA.
  User: ijaz-wso2telco
  Date: 11/18/2016
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.wso2telco.aws.*"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add/Remove Servers</title>
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
    <h3>Add / Remove Servers</h3>
</div>

<table class="table-fill" id="ServerList">
    <%
        session.setAttribute("username", request.getParameter("username"));
        session.setAttribute("type", request.getParameter("type"));
    %>
    <thead>
    <tr>
        <th class="text-left"><center>Region</center></th>
        <th class="text-left"><center>Name</center></th></center>
        <th class="text-left"><center>Instance Id</center></th></center>
        <th class="text-left"><center>Add / Remove</center></th></center>
    </tr>
    </thead>
    <tbody class="table-hover">

    <%
        ResultSet rs=H2DB.getServers();
        int i=0;
        while (rs.next()){
            %><tr id="row_<%=i%>"><%
            %><td class="text-left"><%=AWS.getServerLocationName(rs.getString("REGION"))%></td><%
            %><td class="text-left"><%=rs.getString("NAME")%></td><%
            %><td class="text-left"><%=rs.getString("INSTANCEID")%></td><%
            %><td><center><input type="button" value="Remove" onclick=removeServer("<%=rs.getString("INSTANCEID")%>")></center></td><%
            %></tr><%
            i++;
        }

        %><td>
        <select id="region">
            <option value="US_EAST_1">N. Virginia</option>
            <option value="US_EAST_2">Ohio</option>
            <option value="US_WEST_1">N. California</option>
            <option value="US_WEST_2">Oregon</option>
            <option value="EU_WEST_1">Ireland</option>
            <option value="EU_CENTRAL_1">Frankfurt</option>
            <option value="AP_NORTHEAST_1">Tokyo</option>
            <option value="AP_NORTHEAST_2">Seoul</option>
            <option value="AP_SOUTHEAST_1">Singapore</option>
            <option value="AP_SOUTHEAST_2">Sydney</option>
            <option value="AP_SOUTH_1">Mumbai</option>
            <option value="SA_EAST_1">São Paulo</option>
        </select>
        </td>
        <td>
            <input type="text"  id="Name"  placeholder="Name"/>
        </td>
        <td>
            <input type="text"  id="InstanceID"  placeholder="InstanceID" required="required" />
        </td>
        <td>
            <center><input type="button" value="Add" onclick=addServer()></center>
        </td>
        <%

    %>
    </tbody>
</table>

</body>
</html>
