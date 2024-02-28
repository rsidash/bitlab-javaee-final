package kz.bitlab.project.news.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kz.bitlab.project.news.service.NewsService;
import kz.bitlab.project.users.entity.User;

import java.io.IOException;

@WebServlet("/news/delete")
public class DeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null || currentUser.getRoleId() != 1) {
            throw new RuntimeException("Permissions denied!");
        }

        Long id = Long.parseLong(req.getParameter("id"));
        NewsService.delete(id);
        resp.sendRedirect("/");
    }
}
