<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="main-content" style="max-width: 1200px; margin: 0 auto; padding: 3rem 2rem;">
    
    <a href="${pageContext.request.contextPath}/courses/list" style="color: var(--text-light); text-decoration: none; margin-bottom: 1.5rem; display: inline-block;">
        <i class="fa-solid fa-arrow-left"></i> Back to Courses
    </a>

    <% if(request.getParameter("error") != null && request.getParameter("error").equals("already_enrolled")) { %>
        <div style="background-color: var(--tomato-light); color: var(--tomato-dark); padding: 1rem; border-radius: 4px; margin-bottom: 2rem;">
            You are already enrolled in this course! Check <a href="${pageContext.request.contextPath}/student/my-courses">My Courses</a>.
        </div>
    <% } %>

    <div style="display: flex; gap: 3rem; flex-wrap: wrap;">
        <!-- Left: Course Info -->
        <div style="flex: 2; min-width: 300px;">
            <img src="${empty course.thumbnail ? pageContext.request.contextPath.concat('/images/default-course.jpg') : course.thumbnail}" 
                 style="width:100%; height:400px; object-fit:cover; border-radius:8px; margin-bottom:2rem; background-color:#eee;">
            
            <h1 style="color: var(--tomato-dark); margin-bottom: 1rem;">${course.title}</h1>
            
            <div style="margin-bottom: 2rem;">
                <h3>About This Course</h3>
                <p style="color: var(--text-light); line-height: 1.8; margin-top: 0.5rem; white-space: pre-wrap;">${not empty course.fullDescription ? course.fullDescription : course.description}</p>
            </div>

            <div style="margin-bottom: 2rem;">
                <h3>Course Content</h3>
                <ul style="list-style: none; margin-top: 1rem;">
                    <c:choose>
                        <c:when test="${not empty lessons}">
                            <c:forEach var="lesson" items="${lessons}" varStatus="status">
                                <li style="padding: 1rem; border: 1px solid var(--border-color); border-radius: 4px; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 1rem;">
                                    <i class="fa-regular fa-circle-play" style="color: var(--tomato-red);"></i>
                                    <span>Lesson ${status.index + 1}: ${lesson.title}</span>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p style="color: var(--text-light);">No lessons uploaded yet.</p>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>

        <!-- Right: Enroll Button Card -->
        <div style="flex: 1; min-width: 300px;">
            <div class="card" style="position: sticky; top: 100px;">
                <h3 style="margin-bottom: 1.5rem; text-align: center;">Ready to start learning?</h3>
                
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <form action="${pageContext.request.contextPath}/student/enroll" method="post">
                            <input type="hidden" name="courseId" value="${course.id}">
                            <button class="btn-primary" style="width: 100%; font-size: 1.2rem; padding: 1rem;">Enroll Now</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/auth/login" class="btn-primary" style="display: block; text-align: center; padding: 1rem;">Log in to Enroll</a>
                    </c:otherwise>
                </c:choose>
                
                <hr style="border: 0; border-top: 1px solid var(--border-color); margin: 1.5rem 0;">
                <ul style="list-style: none; color: var(--text-light);">
                    <li style="margin-bottom: 0.5rem;"><i class="fa-solid fa-infinity" style="width: 20px;"></i> Full lifetime access</li>
                    <li style="margin-bottom: 0.5rem;"><i class="fa-solid fa-mobile-screen" style="width: 20px;"></i> Access on mobile and TV</li>
                    <li style="margin-bottom: 0.5rem;"><i class="fa-solid fa-certificate" style="width: 20px;"></i> Certificate of completion</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
