<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="dashboard-layout">
    <jsp:include page="../../components/sidebar.jsp" />
    
    <div class="main-content">
        <h2 style="color: var(--tomato-dark); margin-bottom: 2rem;">Assignments</h2>

        <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("submitted")) { %>
            <div style="background-color: #d4edda; color: #155724; padding: 1rem; border-radius: 4px; margin-bottom: 2rem;">
                Assignment submitted successfully!
            </div>
        <% } %>

        <div class="grid">
            <c:choose>
                <c:when test="${not empty assignments}">
                    <c:forEach var="assignment" items="${assignments}">
                        <div class="card">
                            <h3 style="margin-bottom: 0.5rem; color: var(--tomato-red);">${assignment.title}</h3>
                            <p style="font-size:0.95rem; color:var(--text-light); margin-bottom:1rem;">
                                ${assignment.description}
                            </p>
                            <p style="font-size:0.85rem; color:var(--text-dark); margin-bottom:1.5rem;">
                                <strong>Due Date:</strong> ${assignment.dueDate}
                            </p>
                            
                            <hr style="border: 0; border-top: 1px solid var(--border-color); margin-bottom: 1rem;">
                            
                            <form action="${pageContext.request.contextPath}/student/assignments" method="post">
                                <input type="hidden" name="assignmentId" value="${assignment.id}">
                                <input type="hidden" name="courseId" value="${assignment.courseId}">
                                <div class="form-group">
                                    <label style="font-size: 0.9rem;">Submit Document (URL for now)</label>
                                    <input type="url" name="fileUrl" class="form-control" required placeholder="https://drive.google.com/..." style="font-size: 0.9rem;">
                                </div>
                                <button type="submit" class="btn-primary" style="width: 100%;">Submit Assignment</button>
                            </form>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="color: var(--text-light);">No assignments found for this course.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
