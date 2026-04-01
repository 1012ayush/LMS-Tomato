<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tomatolms.dao.CourseDAO" %>
<%@ page import="com.tomatolms.model.Course" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    CourseDAO courseDAO = new CourseDAO();
    List<Course> featuredCourses = courseDAO.getFeaturedCourses(3);
    request.setAttribute("featuredCourses", featuredCourses);
%>
<jsp:include page="/components/navbar.jsp" />

<div class="hero-section">
    <div class="hero-content">
        <h1>Learn Anything,<br>Anytime, Anywhere</h1>
        <p>Unlock your potential with world-class courses taught by industry experts. Flexible learning that fits your schedule and advances your career.</p>
        <a href="${pageContext.request.contextPath}/courses/list" class="btn-primary" style="padding: 1rem 2.5rem; font-size: 1.1rem; border-radius: 12px;">Start Learning</a>
    </div>
    <div class="hero-image">
        <!-- Using a high quality tech education placeholder image since we don't have the exact illustration -->
        <img src="https://images.unsplash.com/photo-1516321497487-e288fb19713f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Learning" style="box-shadow: 0 20px 40px rgba(0,0,0,0.3);">
    </div>
</div>

<div class="content-inner" style="padding-top: 4rem;">
    <h2 class="section-title">Featured Courses</h2>
    <p class="section-subtitle">Jumpstart your journey with our most popular programs.</p>

    <div class="grid">
        <c:forEach var="course" items="${featuredCourses}">
            <div class="card course-card">
                <img src="${empty course.thumbnail ? pageContext.request.contextPath.concat('/images/default-course.jpg') : course.thumbnail}" alt="${course.title}">
                <h3>${course.title}</h3>
                <p style="overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">${course.description}</p>
                <div class="card-actions" style="display: flex; gap: 0.5rem;">
                    <a href="${pageContext.request.contextPath}/courses/details/${course.id}" class="btn-outline" style="flex:1; text-align:center;">View Details</a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <form action="${pageContext.request.contextPath}/student/enroll" method="post" style="flex:1; margin:0;">
                                <input type="hidden" name="courseId" value="${course.id}">
                                <button type="submit" class="btn-primary" style="width: 100%;">Enroll Now</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/auth/login" class="btn-primary" style="flex:1; text-align:center;">Enroll Now</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty featuredCourses}">
            <p style="color: var(--text-light); text-align: center; width: 100%;">No featured courses available.</p>
        </c:if>
    </div>
</div>

<jsp:include page="/components/footer.jsp" />
