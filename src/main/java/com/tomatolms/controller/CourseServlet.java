package com.tomatolms.controller;

import com.tomatolms.dao.CourseDAO;
import com.tomatolms.dao.LessonDAO;
import com.tomatolms.model.Course;
import com.tomatolms.model.Lesson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/courses/*")
public class CourseServlet extends HttpServlet {

    private CourseDAO courseDAO;
    private LessonDAO lessonDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAO();
        lessonDAO = new LessonDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/list")) {
            // Public or Student Course Listing
            List<Course> courses = courseDAO.getAllCourses();
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("/views/student/courses.jsp").forward(request, response);
            return;
        }

        if (pathInfo.startsWith("/details/")) {
            try {
                int id = Integer.parseInt(pathInfo.substring(9));
                Course course = courseDAO.getCourseById(id);
                if (course != null) {
                    List<Lesson> lessons = lessonDAO.getLessonsByCourseId(id);
                    request.setAttribute("course", course);
                    request.setAttribute("lessons", lessons);
                    request.getRequestDispatcher("/views/student/course-details.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }
}
