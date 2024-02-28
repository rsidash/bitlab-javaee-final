package kz.bitlab.project.users.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kz.bitlab.project.users.service.UserService;

import java.io.IOException;

@WebServlet("/signin")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String rePassword = req.getParameter("rePassword");
        String fullName = req.getParameter("fullName");

        String redirect = UserService.register(email, password, rePassword, fullName);

        if (redirect.isBlank()) {
            resp.sendRedirect("/login");
            return;
        }

        resp.sendRedirect("/register?" + redirect);
    }

}
