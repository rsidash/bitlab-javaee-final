<%@ page import="kz.bitlab.project.users.entity.User" %>
<nav class="navbar bg-light">
  <div class="w-100">
    <div class="d-flex flex-row justify-content-between align-items-center">
      <a class="navbar-brand text-uppercase fw-bold ms-2" href="${pageContext.request.contextPath}/">Bitlab News Portal</a>

      <ul class="nav nav-pills text-center">
          <%
              User currentUser = (User) request.getSession().getAttribute("currentUser");
              if (request.getSession().getAttribute("currentUser") == null) {
          %>
          <li class="nav-item">
              <a href="${pageContext.request.contextPath}/login" class="nav-link link-body-emphasis">Login</a>
          </li>
          <li class="nav-item">
              <a href="${pageContext.request.contextPath}/signin" class="nav-link link-body-emphasis">Sign In</a>
          </li>
          <%
              } else {
          %>
          <li class="nav-item">
              <a href="${pageContext.request.contextPath}/" class="nav-link link-body-emphasis">News</a>
          </li>
          <li class="nav-item">
              <a href="${pageContext.request.contextPath}/profile" class="nav-link link-body-emphasis"><%=currentUser.getFullName()%></a>
          </li>
          <li class="nav-item">
              <form class="mb-0" action="${pageContext.request.contextPath}/logout" method="post">
                  <button class="nav-link link-body-emphasis">Logout</button>
              </form>
          </li>
          <%
              }
          %>
      </ul>
    </div>
  </div>
</nav>