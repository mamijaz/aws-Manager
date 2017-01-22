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
    <title>Manager</title>
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
    <h3>Available Servers</h3>
</div>

<table class="table-fill">
    <thead>
    <tr>
        <th class="text-left"><center>Region</center></th>
        <th class="text-left"><center>Name</center></th></center>
        <th class="text-left"><center>Instance Id</center></th></center>
        <th class="text-left"><center>Status</center></th></center>
        <th class="text-left"><center>Start / Stop</center></th></center>
        <th class="text-left"><center>Update Status</center></th></center>
    </tr>
    </thead>
    <tbody class="table-hover">

    <%
        ResultSet rs=H2DB.getServers();

        int i=0;
        while (rs.next()){
            %><tr><%

            %><td class="text-left"><%=AWS.getServerLocationName(rs.getString("REGION"))%></td><%
            %><td class="text-left"><%=rs.getString("NAME")%></td><%
            %><td class="text-left"><%=rs.getString("INSTANCEID")%></td><%

            String status=new AWS(Regions.valueOf(rs.getString("REGION"))).getStatus(rs.getString("INSTANCEID"));
            %><td class="text-left" id="Status_<%=i%>"> <%=status%></td><%

            if(status.equals("running")){
                %><td><center><input type="button" style="display: block" id="Stop_<%=i%>" value="Stop" onclick=stopServer("<%=rs.getString("REGION")%>","<%=rs.getString("INSTANCEID")%>","<%=rs.getString("NAME").replace(" ","_")%>",this)><input type="button" style="display: none" id="Start_<%=i%>" value="Start" onclick=startServer("<%=rs.getString("REGION")%>","<%=rs.getString("INSTANCEID")%>","<%=rs.getString("NAME").replace(" ","_")%>",this)></center></td><%
            }
            else if(status.equals("stopped")){
                %><td><center><input type="button" style="display: none" id="Stop_<%=i%>" value="Stop" onclick=stopServer("<%=rs.getString("REGION")%>","<%=rs.getString("INSTANCEID")%>","<%=rs.getString("NAME").replace(" ","_")%>",this)><input type="button" style="display: block" id="Start_<%=i%>" value="Start" onclick=startServer("<%=rs.getString("REGION")%>","<%=rs.getString("INSTANCEID")%>","<%=rs.getString("NAME").replace(" ","_")%>",this)></center></td><%
            }
            else{
                %><td><center><input type="button" style="display: none" id="Stop_<%=i%>" value="Stop" onclick=stopServer("<%=rs.getString("REGION")%>","<%=rs.getString("INSTANCEID")%>","<%=rs.getString("NAME").replace(" ","_")%>",this)><input type="button" style="display: none" id="Start_<%=i%>" value="Start" onclick=startServer("<%=rs.getString("REGION")%>","<%=rs.getString("INSTANCEID")%>","<%=rs.getString("NAME").replace(" ","_")%>",this)></center></td><%
            }
            %><td><center><input type="button" id="<%=i%>" value="Update" onclick=updateServerStatus("<%=rs.getString("REGION")%>","<%=rs.getString("INSTANCEID")%>","<%=rs.getString("NAME").replace(" ","_")%>",this)></center></td><%
            %></tr><%

            i++;
        }
    %>

    </tbody>
</table>

</body>
</html>
