<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>News portal</title>
    <%@include file="bootstrap.jsp"%>
</head>
<body>
<%@include file="header.jsp"%>

<%
    if (request.getParameter("incorrectCredentials") != null) {
%>
<div class="alert alert-danger" role="alert">
    Incorrect email or password!
</div>
<%
    }
%>

<div class="container mt-3">
    <form class="form-control w-30" action="/login" method="post">
        <h1 class="h3 mb-3 fw-normal">Type your credentials</h1>

        <div class="form-floating">
            <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="email">
            <label for="floatingInput">Email address</label>
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password">
            <label for="floatingPassword">Password</label>
        </div>

        <button class="btn btn-primary w-100 py-2" type="submit">Sign in</button>
    </form>
</div>

</body>
</html>