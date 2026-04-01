<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="dashboard-layout">
    <jsp:include page="../../components/sidebar.jsp" />
    
    <div class="main-content">
        <h2 style="color: var(--tomato-dark); margin-bottom: 2rem;">Manage Enrollments</h2>
        <div class="card" style="overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                <thead>
                    <tr style="border-bottom: 2px solid var(--border-color);">
                        <th style="padding: 1rem;">ID</th>
                        <th style="padding: 1rem;">Student Name</th>
                        <th style="padding: 1rem;">Course Title</th>
                        <th style="padding: 1rem;">Requested At</th>
                        <th style="padding: 1rem; text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="en" items="${enrollments}">
                        <tr style="border-bottom: 1px solid var(--border-color);">
                            <td style="padding: 1rem;">${en.id}</td>
                            <td style="padding: 1rem; font-weight: 500;">${en.userName}</td>
                            <td style="padding: 1rem;">${en.courseTitle}</td>
                            <td style="padding: 1rem; color: var(--text-light);">${en.enrolledAt}</td>
                            <td style="padding: 1rem; text-align: center; display: flex; justify-content: center; gap: 0.5rem;">
                                <form action="${pageContext.request.contextPath}/admin/approve-enrollment" method="post">
                                    <input type="hidden" name="id" value="${en.id}">
                                    <button type="submit" class="btn-primary" style="background-color: #28a745; padding: 0.4rem 1rem; font-size: 0.9rem;"><i class="fa-solid fa-check"></i> Approve</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/reject-enrollment" method="post">
                                    <input type="hidden" name="id" value="${en.id}">
                                    <button type="submit" class="btn-primary" style="background-color: #dc3545; padding: 0.4rem 1rem; font-size: 0.9rem;"><i class="fa-solid fa-xmark"></i> Reject</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty enrollments}">
                        <tr><td colspan="5" style="padding: 1rem; text-align: center; color: var(--text-light);">No pending enrollments. You are all caught up!</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
