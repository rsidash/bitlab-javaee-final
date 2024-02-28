package kz.bitlab.project.comments.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kz.bitlab.project.comments.entity.Comment;
import kz.bitlab.project.comments.service.CommentService;
import kz.bitlab.project.news.service.NewsService;
import kz.bitlab.project.users.entity.User;

import java.io.IOException;

@WebServlet("/comment/add")
public class CommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            throw new RuntimeException("Permissions denied!");
        }

        Long newsId = Long.parseLong(req.getParameter("newsId"));
        String comment = req.getParameter("comment");

        CommentService.create(new Comment(comment, newsId, currentUser.getId()));
        resp.sendRedirect("/news/edit?id=" + newsId);
    }
}
