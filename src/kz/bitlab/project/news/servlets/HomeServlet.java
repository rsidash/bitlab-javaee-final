package kz.bitlab.project.news.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kz.bitlab.project.news.entity.News;
import kz.bitlab.project.news.service.NewsService;
import kz.bitlab.project.newsCategories.service.NewsCategoryService;
import kz.bitlab.project.users.entity.User;

import java.io.IOException;

@WebServlet("/")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("newsList", NewsService.findAll());
        req.setAttribute("categories", NewsCategoryService.findAll());
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser.getRoleId() != 1) {
            throw new RuntimeException("Permissions denied");
        }

        Long categoryId = Long.valueOf(req.getParameter("category_id"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        NewsService.create(new News(categoryId, title, content));
        resp.sendRedirect("/");
    }
}
