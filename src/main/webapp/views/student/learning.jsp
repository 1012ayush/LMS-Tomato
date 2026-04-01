<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="main-content" style="max-width: 1400px; margin: 0 auto; padding: 2rem;">
    <a href="${pageContext.request.contextPath}/student/my-courses" style="color: var(--text-light); text-decoration: none; margin-bottom: 1.5rem; display: inline-block;">
        <i class="fa-solid fa-arrow-left"></i> Back to My Courses
    </a>

    <div style="display: flex; gap: 2rem; flex-wrap: wrap;">
        <!-- Left: Video Player -->
        <div style="flex: 3; min-width: 60%;">
            <div style="background: black; aspect-ratio: 16/9; display: flex; justify-content: center; align-items: center; border-radius: 8px; margin-bottom: 1.5rem; overflow: hidden;">
                <c:choose>
                    <c:when test="${not empty activeLesson}">
                        <iframe src="${activeLesson.videoUrl}" frameborder="0" allowfullscreen style="width:100%; height:100%;"></iframe>
                    </c:when>
                    <c:otherwise>
                        <i class="fa-solid fa-play" style="color: white; font-size: 4rem; opacity: 0.8;"></i>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <h2 style="color: var(--tomato-dark); margin-bottom: 1rem;">${activeLesson != null ? activeLesson.title : 'No Lesson Selected'}</h2>
            <div class="card">
                <h3>Lesson Overview</h3>
                <p style="color: var(--text-light); margin-top: 0.5rem; line-height: 1.6;">
                    Explore this chapter from the course "${course.title}". Follow along with the video and download notes below.
                </p>
                <div style="margin-top: 1rem; display: flex; gap: 1rem;">
                    <button class="btn-primary" style="background-color: var(--text-dark);"><i class="fa-solid fa-download"></i> Download Notes</button>
                    <button class="btn-primary"><i class="fa-solid fa-check"></i> Mark Complete</button>
                </div>
            </div>
        </div>

        <!-- Right: Lesson List -->
        <div style="flex: 1; min-width: 300px;">
            <div class="card" style="position: sticky; top: 100px; max-height: 80vh; overflow-y: auto;">
                <h3 style="margin-bottom: 1.5rem; border-bottom: 1px solid var(--border-color); padding-bottom: 0.5rem;">Course Content</h3>
                
                <ul style="list-style: none;">
                    <c:forEach var="lesson" items="${lessons}" varStatus="status">
                        <li style="padding: 1rem; margin-bottom: 0.5rem; border-radius: 4px; ${lesson.id == activeLesson.id ? 'background-color: var(--tomato-light); border-left: 4px solid var(--tomato-red);' : 'border: 1px solid var(--border-color); cursor:pointer;'}" onclick="location.href='${pageContext.request.contextPath}/student/learning?courseId=${course.id}&lessonId=${lesson.id}'">
                            <strong>${status.index + 1}. ${lesson.title}</strong>
                            <div style="font-size: 0.8rem; color: var(--text-light); margin-top: 0.25rem;">Video Lesson</div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
