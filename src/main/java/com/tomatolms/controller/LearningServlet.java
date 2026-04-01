package com.tomatolms.controller;

import com.tomatolms.dao.CourseDAO;
import com.tomatolms.dao.LessonDAO;
import com.tomatolms.model.Course;
import com.tomatolms.model.Lesson;
import com.tomatolms.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/student/learning")
public class LearningServlet extends HttpServlet {

    private CourseDAO courseDAO;
    private LessonDAO lessonDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        lessonDAO = new LessonDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            Course course = courseDAO.getCourseById(courseId);
            List<Lesson> lessons = lessonDAO.getLessonsByCourseId(courseId);
            
            if (course != null) {
                request.setAttribute("course", course);
                request.setAttribute("lessons", lessons);
                
                String lessonIdStr = request.getParameter("lessonId");
                Lesson activeLesson = null;
                if (lessons != null && !lessons.isEmpty()) {
                    if (lessonIdStr != null) {
                        int currentLessonId = Integer.parseInt(lessonIdStr);
                        for (Lesson l : lessons) {
                            if (l.getId() == currentLessonId) {
                                activeLesson = l;
                                break;
                            }
                        }
                    }
                    if (activeLesson == null) activeLesson = lessons.get(0);
                }
                request.setAttribute("activeLesson", activeLesson);
                
                request.getRequestDispatcher("/views/student/learning.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/student/my-courses");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/student/my-courses");
        }
    }
}
