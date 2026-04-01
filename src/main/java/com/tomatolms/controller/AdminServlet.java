package com.tomatolms.controller;

import com.tomatolms.dao.CourseDAO;
import com.tomatolms.dao.EnrollmentDAO;
import com.tomatolms.dao.UserDAO;
import com.tomatolms.model.Course;
import com.tomatolms.model.Enrollment;
import com.tomatolms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private CourseDAO courseDAO;
    private UserDAO userDAO;
    private EnrollmentDAO enrollmentDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        userDAO = new UserDAO();
        enrollmentDAO = new EnrollmentDAO();
    }

    private boolean checkAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return false;
        }
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied. Admins Only.");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!checkAdmin(request, response)) return;

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/dashboard")) {
            // Dashboard
            List<User> users = userDAO.getAllUsers();
            List<Course> courses = courseDAO.getAllCourses();
            request.setAttribute("userCount", users.size());
            request.setAttribute("courseCount", courses.size());
            request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
        } else if (pathInfo.equals("/manage-courses")) {
            List<Course> courses = courseDAO.getAllCourses();
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("/views/admin/manage-courses.jsp").forward(request, response);
        } else if (pathInfo.equals("/manage-users")) {
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/views/admin/manage-users.jsp").forward(request, response);
        } else if (pathInfo.equals("/manage-enrollments")) {
            List<Enrollment> enrollments = enrollmentDAO.getPendingEnrollmentsForAdmin();
            request.setAttribute("enrollments", enrollments);
            request.getRequestDispatcher("/views/admin/manage-enrollments.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!checkAdmin(request, response)) return;

        String pathInfo = request.getPathInfo();
        if (pathInfo.equals("/add-course")) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String fullDescription = request.getParameter("fullDescription");
            String thumbnail = request.getParameter("thumbnail");
            User admin = (User) request.getSession().getAttribute("user");

            Course course = new Course(0, title, description, fullDescription, admin.getId(), thumbnail, null);
            courseDAO.addCourse(course);
            response.sendRedirect(request.getContextPath() + "/admin/manage-courses?msg=added");
        } else if (pathInfo.equals("/delete-course")) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            courseDAO.deleteCourse(courseId);
            response.sendRedirect(request.getContextPath() + "/admin/manage-courses?msg=deleted");
        } else if (pathInfo.equals("/delete-user")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/admin/manage-users?msg=deleted");
        } else if (pathInfo.equals("/approve-enrollment")) {
            int id = Integer.parseInt(request.getParameter("id"));
            enrollmentDAO.updateEnrollmentStatus(id, "approved");
            response.sendRedirect(request.getContextPath() + "/admin/manage-enrollments?msg=approved");
        } else if (pathInfo.equals("/reject-enrollment")) {
            int id = Integer.parseInt(request.getParameter("id"));
            enrollmentDAO.updateEnrollmentStatus(id, "rejected");
            response.sendRedirect(request.getContextPath() + "/admin/manage-enrollments?msg=rejected");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
