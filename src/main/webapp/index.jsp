<%--
  Created by IntelliJ IDEA.
  User: ijaz-wso2telco
  Date: 11/18/2016
  Time: 3:24 PM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="styles.css">
    <script type="text/javascript" src="script.js"></script>
    <script src="jquery-3.1.1.js"></script>
</head>
<body>

<div class="login">
    <h1>Login</h1>
    <form>
        <input type="text" class="inputBox" id="username"  placeholder="Username" required="required" />
        <input type="password" class="inputBox" id="password" placeholder="Password" required="required" />
        <input type="button" class="btnlogin" value="Log In" onclick="login()">
    </form>
</div>

</body>
</html>