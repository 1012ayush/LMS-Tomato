<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="dashboard-layout">
    <jsp:include page="../../components/sidebar.jsp" />
    
    <div class="main-content">
        <div class="dashboard-nav">
            <span class="nav-title">Student Dashboard</span>
            <a href="${pageContext.request.contextPath}/courses/list" class="dashboard-tab">All Courses</a>
            <a href="${pageContext.request.contextPath}/student/my-courses" class="dashboard-tab active">My Courses</a>
            <a href="${pageContext.request.contextPath}/student/assignments" class="dashboard-tab">Assignments</a>
            <a href="${pageContext.request.contextPath}/student/profile" class="dashboard-tab">Progress</a>
        </div>

        <div class="content-inner">
            <h2 class="section-title" style="margin-bottom: 2rem;">My Courses</h2>
            
            <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("enrolled")) { %>
                <div style="background-color: #d4edda; color: #155724; padding: 1rem; border-radius: 8px; border: 1px solid #c3e6cb; margin-bottom: 2rem;">
                    <i class="fa-solid fa-circle-check"></i> Successfully enrolled in the course! You can now start learning.
                </div>
            <% } %>

            <div class="filter-layout">
                <!-- Left Sidebar Filters -->
                <div class="filter-sidebar">
                    <h3>Categories <i class="fa-solid fa-chevron-down" style="font-size:0.9rem;"></i></h3>
                    
                    <div class="filter-group">
                        <label><input type="checkbox" checked> Core Programming</label>
                        <label><input type="checkbox" checked> Web Development</label>
                        <label><input type="checkbox"> Data Science</label>
                        <label><input type="checkbox"> Mobile Apps</label>
                        <label><input type="checkbox"> UI/UX Design</label>
                    </div>

                    <h3 style="margin-top:2rem;">Duration <i class="fa-solid fa-chevron-down" style="font-size:0.9rem;"></i></h3>
                    <div class="filter-group">
                        <label><input type="checkbox"> Short (0-2 hrs)</label>
                        <label><input type="checkbox" checked> Medium (3-10 hrs)</label>
                        <label><input type="checkbox"> Long (10+ hrs)</label>
                    </div>

                    <h3 style="margin-top:2rem;">Level <i class="fa-solid fa-chevron-down" style="font-size:0.9rem;"></i></h3>
                    <div class="filter-group">
                        <label><input type="checkbox" checked> Beginner</label>
                        <label><input type="checkbox"> Intermediate</label>
                        <label><input type="checkbox"> Advanced</label>
                    </div>
                </div>

                <!-- Right Content Grid -->
                <div class="filter-content grid" style="align-items: start;">
                    <c:choose>
                        <c:when test="${not empty enrolledCourses or not empty pendingCourses}">
                            <!-- Approved Courses -->
                            <c:forEach var="course" items="${enrolledCourses}">
                                <div class="card course-card">
                                    <img src="${empty course.thumbnail ? pageContext.request.contextPath.concat('/images/default-course.jpg') : course.thumbnail}" alt="${course.title}">
                                    <h3>${course.title}</h3>
                                    <p>${course.description}</p>
                                    <div class="card-actions">
                                        <a href="${pageContext.request.contextPath}/student/learning?courseId=${course.id}" class="btn-primary" style="flex: 2; text-align:center;">Watch Course</a>
                                        <a href="${pageContext.request.contextPath}/student/assignments?courseId=${course.id}" class="btn-outline" style="flex: 1; text-align:center;" title="Assignments">Files <i class="fa-solid fa-file-pen"></i></a>
                                    </div>
                                </div>
                            </c:forEach>
                            
                            <!-- Pending Courses -->
                            <c:forEach var="course" items="${pendingCourses}">
                                <div class="card course-card" style="opacity: 0.8; border: 1px dashed var(--primary);">
                                    <img src="${empty course.thumbnail ? pageContext.request.contextPath.concat('/images/default-course.jpg') : course.thumbnail}" alt="${course.title}" style="filter: grayscale(100%);">
                                    <h3 style="color: var(--text-light);">${course.title}</h3>
                                    <div style="margin-top: auto; padding: 0.8rem; background-color: #fff3cd; color: #856404; text-align: center; border-radius: 8px; font-weight: 600;">
                                        <i class="fa-solid fa-clock"></i> Pending Approval
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1/-1; text-align:center; padding: 4rem 2rem; background:white; border-radius:16px; border:1px solid var(--border);">
                                <i class="fa-solid fa-book-open" style="font-size:4rem; color:var(--text-light); margin-bottom:1rem; opacity:0.5;"></i>
                                <h3 style="color: var(--text-dark); margin-bottom:0.5rem; font-size:1.5rem;">No Courses Yet</h3>
                                <p style="color: var(--text-light); margin-bottom: 2rem;">You haven't enrolled in any courses to manage your learning here.</p>
                                <a href="${pageContext.request.contextPath}/courses/list" class="btn-primary">Browse Courses</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
