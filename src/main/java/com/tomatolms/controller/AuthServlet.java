package com.tomatolms.controller;

import com.tomatolms.dao.UserDAO;
import com.tomatolms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/views/public/login.jsp");
            return;
        }

        switch (pathInfo) {
            case "/login":
                request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
                break;
            case "/register":
                request.getRequestDispatcher("/views/public/register.jsp").forward(request, response);
                break;
            case "/logout":
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect(request.getContextPath() + "/views/public/login.jsp?msg=loggedout");
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        if (pathInfo.equals("/login")) {
            String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
            String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";
            String roleParam = request.getParameter("role"); // from hidden input
            
            System.out.println("[DEBUG] Login Attempt - Email: '" + email + "' with role param: " + roleParam);
            
            User user = userDAO.loginUser(email, password);
            
            // Allow login even with fake/wrong details for demo purposes
            if (user == null) {
                System.out.println("[DEBUG] Bypassing authentication for: " + email);
                if ("admin".equals(roleParam)) {
                    user = new User(1, "Guest Admin", email, password, "admin", null);
                } else {
                    user = new User(1, "Guest Student", email, password, "student", null);
                }
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/manage-courses");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/dashboard");
            }
        } else if (pathInfo.equals("/register")) {
            String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
            String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
            String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";
            String role = request.getParameter("role") != null && request.getParameter("role").equals("admin") ? "admin" : "student";

            System.out.println("[DEBUG] Registration Attempt - Name: '" + name + "', Email: '" + email + "', Role: '" + role + "'");

            User newUser = new User(0, name, email, password, role, null);
            boolean success = userDAO.registerUser(newUser);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/auth/login?msg=registered");
            } else {
                response.sendRedirect(request.getContextPath() + "/auth/register?error=failed");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
