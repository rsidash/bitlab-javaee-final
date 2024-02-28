<%@ page import="kz.bitlab.project.news.entity.News" %>
<%@ page import="kz.bitlab.project.newsCategories.entity.NewsCategory" %>
<%@ page import="java.util.List" %>
<%@ page import="kz.bitlab.project.comments.entity.Comment" %><%--
  Created by IntelliJ IDEA.
  User: Roma
  Date: 25.02.2024
  Time: 21:45
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
    <div class="d-flex flex-column justify-content-center align-items-center mt-3">
        <%
            News news = (News) request.getAttribute("news");
        %>
        <div class="card w-50">
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
                <p class="card-text"><%=news.getContent()%>
                </p>
                <%
                    if (currentUser != null && currentUser.getRoleId() == 1) {
                %>
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#updateNews">
                    Update
                </button>
                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteNews">
                    Delete
                </button>
                <%
                    }
                %>
            </div>
            <div class="card-footer text-body-secondary">
                <form class="d-flex flex-column mb-3" action="${pageContext.request.contextPath}/comment/add" method="post">
                    <input type="hidden" name="newsId" value="<%=news.getId()%>">
                    <div class="form-floating mb-1">
                        <textarea class="form-control" placeholder="Leave a comment here" name="comment" id="comment" style="height: 100px"></textarea>
                        <label for="comment">Comments</label>
                    </div>
                    <button class="btn btn-outline-primary" type="submit" id="button-addon2">Add</button>
                </form>
                <%
                    List<Comment> commentList = (List<Comment>) request.getAttribute("commentList");
                    for (Comment comment : commentList) {
                %>
                <div class="input-group mb-3">
                    <input type="text" value="<%=comment.getComment()%>" class="form-control" placeholder="Comment" aria-label="Comment" aria-describedby="basic-addon2" disabled readonly>
                    <div class="input-group-text d-flex flex-column align-items-end text-secondary">
                        <span class="" id="user"><%=comment.getUser().getFullName()%></span>
                        <span class="" id="date"><%=comment.getFormattedPostDate()%></span>
                    </div>
                </div>
                <%
                    };
                %>
            </div>
        </div>
    </div>


    <div class="modal fade" id="updateNews" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form class="modal-content" action="${pageContext.request.contextPath}/news/edit" method="post">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="id" value="<%=news.getId()%>">
                    <div class="form-floating">
                        <input class="form-control" id="floatingInput" placeholder="Test title" name="title"
                               value="<%=news.getTitle()%>">
                        <label for="floatingInput">TITLE:</label>
                    </div>
                    <div class="form-floating">
                        <textarea class="form-control" placeholder="Test content..."
                                  name="content"><%=news.getContent()%></textarea>
                    </div>
                    <div class="form-floating">
                        <select class="form-select" name="categoryId">
                            <option selected value="<%=news.getCategory().getId()%>"><%=news.getCategory().getName()%>
                            </option>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button class="btn btn-warning">Update</button>
                </div>
            </form>
        </div>
    </div>


    <div class="modal fade" id="deleteNews" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form class="modal-content" action="${pageContext.request.contextPath}/news/delete" method="post">
                <div class="modal-header">
                    <h1 class="modal-title fs-5">Modal title</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="id" value="<%=news.getId()%>">
                    Are you sure?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button class="btn btn-danger">Delete</button>
                </div>
            </form>
        </div>
    </div>

</div>
</body>
</html>
