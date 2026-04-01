package com.tomatolms.controller;

import com.tomatolms.dao.AssignmentDAO;
import com.tomatolms.dao.CourseDAO;
import com.tomatolms.dao.EnrollmentDAO;
import com.tomatolms.model.Course;
import com.tomatolms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet({"/student/dashboard", "/student/enroll", "/student/my-courses"})
public class EnrollmentServlet extends HttpServlet {

    private EnrollmentDAO enrollmentDAO;
    private CourseDAO courseDAO;
    private AssignmentDAO assignmentDAO;

    @Override
    public void init() throws ServletException {
        enrollmentDAO = new EnrollmentDAO();
        courseDAO = new CourseDAO();
        assignmentDAO = new AssignmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String servletPath = request.getServletPath();

        if (servletPath.equals("/student/dashboard")) {
            List<Course> myCourses = enrollmentDAO.getEnrolledCourses(user.getId());
            int pendingAssignments = assignmentDAO.getPendingAssignmentsCount(user.getId());
            
            request.setAttribute("enrolledCount", myCourses.size());
            request.setAttribute("completedCount", 0); // Optional metric
            request.setAttribute("pendingAssignments", pendingAssignments);
            request.setAttribute("recentCourses", myCourses.size() > 3 ? myCourses.subList(0, 3) : myCourses);
            request.getRequestDispatcher("/views/student/dashboard.jsp").forward(request, response);
            
        } else if (servletPath.equals("/student/my-courses")) {
            List<Course> enrolledCourses = enrollmentDAO.getEnrolledCourses(user.getId());
            List<Course> pendingCourses = enrollmentDAO.getPendingCourses(user.getId());
            request.setAttribute("enrolledCourses", enrolledCourses);
            request.setAttribute("pendingCourses", pendingCourses);
            request.getRequestDispatcher("/views/student/my-courses.jsp").forward(request, response);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String servletPath = request.getServletPath();

        if (servletPath.equals("/student/enroll")) {
            try {
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                boolean success = enrollmentDAO.enroll(user.getId(), courseId);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/student/my-courses?msg=enrolled");
                } else {
                    response.sendRedirect(request.getContextPath() + "/courses/details/" + courseId + "?error=already_enrolled");
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }
}
