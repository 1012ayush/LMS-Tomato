package com.tomatolms.controller;

import com.tomatolms.dao.AssignmentDAO;
import com.tomatolms.dao.SubmissionDAO;
import com.tomatolms.model.Assignment;
import com.tomatolms.model.Submission;
import com.tomatolms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/assignments")
public class AssignmentServlet extends HttpServlet {

    private AssignmentDAO assignmentDAO;
    private SubmissionDAO submissionDAO;

    @Override
    public void init() throws ServletException {
        assignmentDAO = new AssignmentDAO();
        submissionDAO = new SubmissionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            String courseIdParam = request.getParameter("courseId");
            List<Assignment> assignments;
            if (courseIdParam != null && !courseIdParam.isEmpty()) {
                int courseId = Integer.parseInt(courseIdParam);
                assignments = assignmentDAO.getAssignmentsByCourseId(courseId);
            } else {
                User user = (User) session.getAttribute("user");
                assignments = assignmentDAO.getPendingAssignmentsForUser(user.getId());
            }
            request.setAttribute("assignments", assignments);
            request.getRequestDispatcher("/views/student/assignments.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/student/my-courses");
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
        int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
        String fileUrl = request.getParameter("fileUrl"); // In a real app, handle file upload multipart
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        Submission submission = new Submission(0, assignmentId, user.getId(), fileUrl, null, null);
        submissionDAO.addOrUpdateSubmission(submission);

        response.sendRedirect(request.getContextPath() + "/student/assignments?courseId=" + courseId + "&msg=submitted");
    }
}
