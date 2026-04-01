<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tomato LMS</title>
    <!-- Use Outfit font for a premium look -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/" class="nav-brand">
        <i class="fa-solid fa-graduation-cap" style="color: white; background: var(--primary); padding: 5px; border-radius: 8px;"></i> Tomato LMS
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/" class="nav-link ${pageContext.request.servletPath == '/index.jsp' ? 'active' : ''}">Home</a>
        <a href="${pageContext.request.contextPath}/about.jsp" class="nav-link ${pageContext.request.servletPath == '/about.jsp' ? 'active' : ''}">About</a>
        <a href="${pageContext.request.contextPath}/courses/list" class="nav-link ${pageContext.request.servletPath.contains('/courses') ? 'active' : ''}">Courses</a>
        <a href="#" class="nav-link">Contact</a>
        
        <div style="width: 1px; height: 24px; background: rgba(255,255,255,0.2); margin: 0 1rem;"></div>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <c:choose>
                    <c:when test="${sessionScope.user.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-primary outline">Admin Panel</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/student/my-courses" class="btn-primary">Dashboard</a>
                    </c:otherwise>
                </c:choose>
                <a href="${pageContext.request.contextPath}/auth/logout" class="nav-link" style="color: rgba(255,255,255,0.7); margin-left: 1rem;"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/auth/login" class="nav-link">Student Login</a>
                <a href="${pageContext.request.contextPath}/auth/register" class="btn-primary">Sign Up</a>
                <a href="${pageContext.request.contextPath}/auth/login?role=admin" class="btn-primary outline" style="margin-left: 1rem;">Admin Portal</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
