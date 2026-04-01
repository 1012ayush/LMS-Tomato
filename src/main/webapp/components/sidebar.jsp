<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="sidebar">

    <div class="sidebar-profile">
        <img src="https://ui-avatars.com/api/?name=${not empty sessionScope.user ? sessionScope.user.name : 'User'}&background=c41e3a&color=fff&rounded=true" alt="Profile">
        <div>
            <h4>${not empty sessionScope.user ? sessionScope.user.name : 'Student'}</h4>
            <p>${not empty sessionScope.user ? sessionScope.user.role : 'Member'}</p>
        </div>
    </div>

    <ul class="sidebar-menu">
        <c:choose>
            <c:when test="${not empty sessionScope.user && sessionScope.user.role == 'admin'}">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link ${pageContext.request.servletPath.contains('/admin/dashboard') ? 'active' : ''}">
                    <i class="fa-solid fa-chart-pie"></i> Dashboard
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/manage-courses" class="sidebar-link ${pageContext.request.servletPath.contains('manage-courses') ? 'active' : ''}">
                    <i class="fa-solid fa-book"></i> Manage Courses
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/manage-enrollments" class="sidebar-link ${pageContext.request.servletPath.contains('manage-enrollments') ? 'active' : ''}">
                    <i class="fa-solid fa-list-check"></i> Enrollments
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/manage-users" class="sidebar-link ${pageContext.request.servletPath.contains('manage-users') ? 'active' : ''}">
                    <i class="fa-solid fa-users"></i> Manage Users
                </a></li>
            </c:when>
            <c:otherwise>
                <li><a href="${pageContext.request.contextPath}/student/my-courses" class="sidebar-link ${pageContext.request.servletPath.contains('/student/my-courses') ? 'active' : ''}">
                    <i class="fa-solid fa-book-open"></i> Dashboard
                </a></li>
                <li><a href="${pageContext.request.contextPath}/courses/list" class="sidebar-link ${pageContext.request.servletPath.contains('/courses/list') ? 'active' : ''}">
                    <i class="fa-solid fa-compass"></i> All Courses
                </a></li>
                <li><a href="${pageContext.request.contextPath}/student/my-courses" class="sidebar-link ${pageContext.request.servletPath.contains('/student/my-courses') ? 'active' : ''}">
                    <i class="fa-solid fa-graduation-cap"></i> Enrolled
                </a></li>
                <li><a href="${pageContext.request.contextPath}/student/profile" class="sidebar-link ${pageContext.request.servletPath.contains('profile') ? 'active' : ''}">
                    <i class="fa-solid fa-user"></i> Profile
                </a></li>
                <li><a href="#" class="sidebar-link">
                    <i class="fa-solid fa-gear"></i> Settings
                </a></li>
            </c:otherwise>
        </c:choose>
    </ul>
    
    <div style="margin-top: auto; padding-bottom: 2rem;">
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link" style="color: #ff6b6b;">
                <i class="fa-solid fa-right-from-bracket"></i> Logout
            </a></li>
        </ul>
    </div>
</div>
