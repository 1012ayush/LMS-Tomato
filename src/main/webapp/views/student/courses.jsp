<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="dashboard-layout">
    <!-- Render sidebar conditionally or unconditionally if logged in -->
    <c:if test="${not empty sessionScope.user}">
        <jsp:include page="../../components/sidebar.jsp" />
    </c:if>

    <div class="main-content">
        <div class="dashboard-nav">
            <span class="nav-title">Student Dashboard</span>
            <a href="${pageContext.request.contextPath}/courses/list" class="dashboard-tab active">All Courses</a>
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/student/my-courses" class="dashboard-tab">My Courses</a>
                <a href="${pageContext.request.contextPath}/student/assignments" class="dashboard-tab">Assignments</a>
                <a href="${pageContext.request.contextPath}/student/profile" class="dashboard-tab">Progress</a>
            </c:if>
        </div>

        <div class="content-inner">
            <div class="flex-between" style="margin-bottom: 2rem;">
                <h2 class="section-title" style="margin: 0;">All Courses</h2>
                <div style="display:flex; gap:1rem;">
                    <button class="btn-outline"><i class="fa-solid fa-filter"></i> Filters</button>
                    <button class="btn-outline"><i class="fa-solid fa-sort"></i> Sort: Newest</button>
                </div>
            </div>

            <div class="grid">
                <c:choose>
                    <c:when test="${not empty courses}">
                        <c:forEach var="course" items="${courses}">
                            <div class="card course-card">
                                <img src="${empty course.thumbnail ? pageContext.request.contextPath.concat('/images/default-course.jpg') : course.thumbnail}" alt="Thumbnail">
                                <h3>${course.title}</h3>
                                <p>${course.description}</p>
                                <div class="card-actions">
                                    <a href="${pageContext.request.contextPath}/courses/details/${course.id}" class="btn-outline">Details</a>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user}">
                                            <form action="${pageContext.request.contextPath}/student/enroll" method="post" style="flex: 1; display:flex;">
                                                <input type="hidden" name="courseId" value="${course.id}">
                                                <button type="submit" class="btn-primary" style="width: 100%;">Enroll Now</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/auth/login" class="btn-primary" style="flex: 1; text-align:center;">Login</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="grid-column: 1/-1; text-align:center; padding: 4rem 2rem; background:white; border-radius:12px; border:1px solid var(--border);">
                            <h3 style="color: var(--text-dark); margin-bottom:0.5rem;">No Courses Found</h3>
                            <p style="color: var(--text-light);">Check back later for new programs.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
