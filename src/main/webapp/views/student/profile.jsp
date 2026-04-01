<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="dashboard-layout">
    <jsp:include page="../../components/sidebar.jsp" />
    
    <div class="main-content">
        <h2 style="color: var(--tomato-dark); margin-bottom: 2rem;">My Profile</h2>

        <div class="card" style="max-width: 600px;">
            <div style="text-align: center; margin-bottom: 2rem;">
                <i class="fa-solid fa-circle-user" style="font-size: 6rem; color: var(--tomato-red);"></i>
                <h3 style="margin-top: 1rem;">${sessionScope.user.name}</h3>
                <p style="color: var(--text-light);">${sessionScope.user.role}</p>
            </div>

            <form action="${pageContext.request.contextPath}/student/profile" method="post">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" class="form-control" value="${sessionScope.user.name}">
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" class="form-control" value="${sessionScope.user.email}" readonly style="background-color: var(--bg-color);">
                    <small style="color: var(--text-light);">Email cannot be changed.</small>
                </div>
                <div style="margin-top: 2rem;">
                    <button type="submit" class="btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
