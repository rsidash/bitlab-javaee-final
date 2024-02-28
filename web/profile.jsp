<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="bootstrap.jsp" %>
</head>
<body>
<%@include file="header.jsp" %>

<%
    if (request.getParameter("wrongOldPassword") != null) {
%>
<div class="alert alert-danger" role="alert">
    Wrong old password
</div>
<%
    }
%>

<div class="container mt-3">
    <div class="mb-3">
        <label>FULL NAME:</label>
        <input class="form-control" value="<%=currentUser.getFullName()%>" readonly/>
    </div>
    <div class="mb-3">
        <label>EMAIL:</label>
        <input class="form-control" type="email" value="<%=currentUser.getEmail()%>" readonly/>
    </div>
    <div class="mb-3">
        <label>ROLE:</label>
        <%
            if (currentUser.getRoleId() == 1) {
        %>
        <input class="form-control" value="ADMIN" readonly/>
        <%
        } else {
        %>
        <input class="form-control" value="USER" readonly/>
        <%
            }
        %>
    </div>
</div>

<%
    if (request.getSession().getAttribute("currentUser") != null) {
%>
<form class="form-control" action="/logout" method="post">
    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#updateUser">
        Update
    </button>
    <button class="btn btn-danger">Logout</button>
</form>
<%
    }
%>

<form class="modal fade" id="updateUser" tabindex="-1" aria-hidden="true" action="${pageContext.request.contextPath}/profile" method="post">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Modal Update Profile</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label>FULL NAME:</label>
                    <input class="form-control" value="<%=currentUser.getFullName()%>" name="fullName"/>
                </div>
                <div class="mb-3">
                    <label>OLD PASSWORD:</label>
                    <input class="form-control" type="password" placeholder="****" name="oldPassword"/>
                </div>
                <div class="mb-3">
                    <label>NEW PASSWORD:</label>
                    <input class="form-control" type="password" placeholder="****" name="password"/>
                </div>
                <div class="mb-3">
                    <label>REPEAT PASSWORD:</label>
                    <input class="form-control" type="password" placeholder="****" name="rePassword"/>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button class="btn btn-warning">UPDATE</button>
            </div>
        </div>
    </div>
</form>

</body>
</html>