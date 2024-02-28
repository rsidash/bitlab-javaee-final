package kz.bitlab.project.news.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kz.bitlab.project.comments.service.CommentService;
import kz.bitlab.project.news.service.NewsService;
import kz.bitlab.project.newsCategories.service.NewsCategoryService;
import kz.bitlab.project.users.entity.User;

import java.io.IOException;

@WebServlet("/news/edit")
public class DetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        var news = NewsService.findById(id);
        req.setAttribute("news", news);
        req.setAttribute("categories", NewsCategoryService.findAll().stream()
                .filter(category -> !category.getId().equals(news.getCategory().getId())).toList());
        req.setAttribute("commentList", CommentService.findByNewsId(id));
        req.getRequestDispatcher("/news.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser.getRoleId() != 1) {
            throw new RuntimeException("Permissions denied!");
        }

        Long id = Long.parseLong(req.getParameter("id"));
        Long categoryId = Long.parseLong(req.getParameter("categoryId"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        NewsService.update(id, categoryId, title, content);
        resp.sendRedirect("/news/edit?id=" + id);
    }
}
