<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="dashboard-layout">
    <jsp:include page="../../components/sidebar.jsp" />
    
    <div class="main-content">
        <h2 style="color: var(--tomato-dark); margin-bottom: 2rem;">Welcome back, ${sessionScope.user.name}!</h2>
        
        <div class="grid" style="margin-bottom: 3rem;">
            <div class="card" style="border-left: 4px solid var(--tomato-red); transition: transform 0.2s; cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/student/my-courses'">
                <h3>Total Enrolled Courses</h3>
                <p style="font-size: 2rem; font-weight: bold; color: var(--tomato-red);">${enrolledCount}</p>
            </div>
            
            <div class="card" style="border-left: 4px solid var(--tomato-red);">
                <h3>Completed Courses</h3>
                <p style="font-size: 2rem; font-weight: bold; color: var(--tomato-red);">${completedCount}</p>
            </div>
            
            <div class="card" style="border-left: 4px solid var(--tomato-red); transition: transform 0.2s; cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/student/assignments'">
                <h3>Pending Assignments</h3>
                <p style="font-size: 2rem; font-weight: bold; color: var(--tomato-red);">${pendingAssignments}</p>
            </div>
        </div>
        
        <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-clock-rotate-left"></i> Recent Courses</h3>
        <div class="grid">
            <c:choose>
                <c:when test="${not empty recentCourses}">
                    <c:forEach var="course" items="${recentCourses}">
                        <div class="card">
                            <img src="${empty course.thumbnail ? pageContext.request.contextPath.concat('/images/default-course.jpg') : course.thumbnail}" 
                                 alt="Thumbnail" style="width:100%; height:150px; object-fit:cover; border-radius:4px; margin-bottom:1rem; background-color:#ddd;">
                            <h4>${course.title}</h4>
                            <p style="font-size:0.9rem; color:var(--text-light); margin-bottom:1rem;">
                                ${course.description.length() > 60 ? course.description.substring(0, 60).concat('...') : course.description}
                            </p>
                            <a href="${pageContext.request.contextPath}/courses/details/${course.id}" class="btn-primary" style="display:block; text-align:center;">Continue Learning</a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="color: var(--text-light);">You haven't enrolled in any courses yet.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
