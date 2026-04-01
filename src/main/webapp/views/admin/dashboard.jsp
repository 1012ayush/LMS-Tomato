<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="dashboard-layout">
    <jsp:include page="../../components/sidebar.jsp" />
    
    <div class="main-content">
        <h2 style="color: var(--tomato-dark); margin-bottom: 2rem;">Admin Dashboard</h2>
        
        <div class="grid" style="margin-bottom: 3rem;">
            <div class="card" style="border-left: 4px solid var(--tomato-dark);">
                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <div>
                        <h3 style="color: var(--text-light); font-size: 1rem; text-transform: uppercase;">Total Users</h3>
                        <p style="font-size: 2.5rem; font-weight: bold; color: var(--text-dark);">${userCount}</p>
                    </div>
                    <i class="fa-solid fa-users" style="font-size: 3rem; color: var(--tomato-light);"></i>
                </div>
            </div>
            
            <div class="card" style="border-left: 4px solid var(--tomato-dark);">
                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <div>
                        <h3 style="color: var(--text-light); font-size: 1rem; text-transform: uppercase;">Total Courses</h3>
                        <p style="font-size: 2.5rem; font-weight: bold; color: var(--text-dark);">${courseCount}</p>
                    </div>
                    <i class="fa-solid fa-book" style="font-size: 3rem; color: var(--tomato-light);"></i>
                </div>
            </div>
            
            <div class="card" style="border-left: 4px solid var(--tomato-dark);">
                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <div>
                        <h3 style="color: var(--text-light); font-size: 1rem; text-transform: uppercase;">System Health</h3>
                        <p style="font-size: 2.5rem; font-weight: bold; color: var(--text-dark);">100%</p>
                    </div>
                    <i class="fa-solid fa-server" style="font-size: 3rem; color: var(--tomato-light);"></i>
                </div>
            </div>
        </div>
        
        <div class="card">
            <h3 style="margin-bottom: 1.5rem;">Quick Actions</h3>
            <div style="display: flex; gap: 1rem;">
                <a href="${pageContext.request.contextPath}/admin/manage-courses" class="btn-primary"><i class="fa-solid fa-plus"></i> Add New Course</a>
                <a href="${pageContext.request.contextPath}/admin/manage-users" class="btn-primary" style="background-color: var(--text-dark);"><i class="fa-solid fa-gears"></i> Manage Users</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
