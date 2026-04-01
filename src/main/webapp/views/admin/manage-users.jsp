<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="dashboard-layout">
    <jsp:include page="../../components/sidebar.jsp" />
    
    <div class="main-content">
        <h2 style="color: var(--tomato-dark); margin-bottom: 2rem;">Manage Users</h2>

        <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("deleted")) { %>
            <div style="background-color: #f8d7da; color: #721c24; padding: 1rem; border-radius: 4px; margin-bottom: 2rem;">User deleted successfully.</div>
        <% } %>

        <div class="card" style="overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                <thead>
                    <tr style="border-bottom: 2px solid var(--border-color);">
                        <th style="padding: 1rem;">ID</th>
                        <th style="padding: 1rem;">Name</th>
                        <th style="padding: 1rem;">Email</th>
                        <th style="padding: 1rem;">Role</th>
                        <th style="padding: 1rem;">Registered On</th>
                        <th style="padding: 1rem; text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr style="border-bottom: 1px solid var(--border-color);">
                            <td style="padding: 1rem;">${u.id}</td>
                            <td style="padding: 1rem; font-weight: 500;">
                                <i class="fa-solid ${u.role == 'admin' ? 'fa-user-shield' : 'fa-user'}" style="color: var(--text-light); margin-right: 0.5rem;"></i>
                                ${u.name}
                            </td>
                            <td style="padding: 1rem; color: var(--text-light);">${u.email}</td>
                            <td style="padding: 1rem;">
                                <span style="background-color: ${u.role == 'admin' ? 'var(--tomato-light)' : '#e0e0e0'}; color: ${u.role == 'admin' ? 'var(--tomato-dark)' : 'var(--text-dark)'}; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.8rem; text-transform: uppercase;">
                                    ${u.role}
                                </span>
                            </td>
                            <td style="padding: 1rem; color: var(--text-light);">${u.createdAt}</td>
                            <td style="padding: 1rem; text-align: center;">
                                <c:if test="${u.id != sessionScope.user.id}"> <!-- Don't let admin delete themselves -->
                                    <form action="${pageContext.request.contextPath}/admin/delete-user" method="post" style="display: inline-block;" onsubmit="return confirm('Are you sure you want to delete this user forever?');">
                                        <input type="hidden" name="userId" value="${u.id}">
                                        <button type="submit" style="background: none; border: none; color: var(--tomato-red); cursor: pointer; font-size: 1.2rem;" title="Delete User">
                                            <i class="fa-solid fa-user-xmark"></i>
                                        </button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr><td colspan="6" style="padding: 1rem; text-align: center; color: var(--text-light);">No users found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
