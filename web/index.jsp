<%@ page import="kz.bitlab.project.news.entity.News" %>
<%@ page import="java.util.List" %>
<%@ page import="kz.bitlab.project.users.entity.User" %>
<%@ page import="kz.bitlab.project.newsCategories.entity.NewsCategory" %><%--
  Created by IntelliJ IDEA.
  User: Roma
  Date: 11.02.2024
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bitlab News Portal</title>
    <%@include file="bootstrap.jsp" %>
</head>
<body>
<%@include file="header.jsp" %>

<div class="container-fluid">
    <div class="d-flex flex-column text-center my-3">
        <%
            if (currentUser != null) {
        %>
        <h1>Welcome, <%=currentUser.getFullName()%>
        </h1>
        <%
        } else {
        %>
        <h1>Welcome, guest</h1>
        <%
            }
        %>
        <small class="text-body-secondary">Bitlab News portal</small>
    </div>

    <%
        if (currentUser != null && currentUser.getRoleId() == 1) {
    %>
    <div class="d-flex mb-3">
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
            Add news
        </button>
    </div>
    <%
        }
    %>

    <%
        if (currentUser != null) {
    %>
    <div class="d-flex flex-column justify-content-center align-items-center">
        <%
            List<News> newsList = (List<News>) request.getAttribute("newsList");
            for (News news : newsList) {
        %>
        <div class="card w-50 mb-3">
            <div class="card-header d-flex flex-row">
                <div class="me-auto">
                    <%=news.getCategory().getName()%>
                </div>
                <div>
                    <%=news.getFormattedPostDate()%>
                </div>
            </div>
            <div class="card-body">
                <h5 class="card-title"><%=news.getTitle()%>
                </h5>
                <p class="card-text text-truncate"><%=news.getContent()%>
                </p>
                <a href="${pageContext.request.contextPath}/news/edit?id=<%=news.getId()%>"
                   class="btn btn-primary">More</a>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <%
        }
    %>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form class="modal-content" method="post">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Add news</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="category_id" class="form-label">News category</label>
                        <select class="form-select" aria-label="Default select example" id="category_id"
                                name="category_id">
                            <%
                                List<NewsCategory> categories = (List<NewsCategory>) request.getAttribute("categories");
                                if (!categories.isEmpty()) {
                                    for (NewsCategory category : categories) {
                            %>
                            <option value="<%=category.getId()%>"><%=category.getName()%>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="exampleFormControlInput1" class="form-label">News title</label>
                        <input type="text" name="title" class="form-control" id="exampleFormControlInput1"
                               placeholder="News title">
                    </div>
                    <div class="mb-3">
                        <label for="exampleFormControlTextarea1" class="form-label">News content</label>
                        <textarea class="form-control" name="content" id="exampleFormControlTextarea1"
                                  rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form>
        </div>
    </div>

</div>
</body>
</html>
