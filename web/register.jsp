<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="bootstrap.jsp"%>
</head>
<body>
<%@include file="header.jsp"%>

<%
    if (request.getParameter("passwordsNotSame") != null) {
%>
<div class="alert alert-danger" role="alert">
    Passwords are not the same!
</div>
<%
    }
%>

<%
    if (request.getParameter("userAlreadyExists") != null) {
%>
<div class="alert alert-danger" role="alert">
    User with this email already exists!
</div>
<%
    }
%>

<div class="container mt-3">
    <form class="form-control" action="/signin" method="post">
        <div class="mb-3">
            <label>FULL NAME:</label>
            <input class="form-control" name="fullName" placeholder="Test User" required/>
        </div>
        <div class="mb-3">
            <label>EMAIL:</label>
            <input class="form-control" type="email" name="email" placeholder="example@test.kz" required/>
        </div>
        <div class="mb-3">
            <label>PASSWORD:</label>
            <input class="form-control" type="password" name="password" placeholder="*****" required/>
        </div>
        <div class="mb-3">
            <label>REPEAT PASSWORD:</label>
            <input class="form-control" type="password" name="rePassword" placeholder="*****" required/>
        </div>

        <button class="btn btn-primary">REGISTER</button>
    </form>
</div>

</body>
</html>