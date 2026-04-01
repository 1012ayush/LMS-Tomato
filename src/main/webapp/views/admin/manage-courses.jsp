<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../components/navbar.jsp" />

<div class="dashboard-layout">
    <jsp:include page="../../components/sidebar.jsp" />
    
    <div class="main-content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
            <h2 style="color: var(--tomato-dark);">Manage Courses</h2>
            <button class="btn-primary" onclick="document.getElementById('addCourseForm').style.display='block';">
                <i class="fa-solid fa-plus"></i> Add Course
            </button>
        </div>

        <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("added")) { %>
            <div style="background-color: #d4edda; color: #155724; padding: 1rem; border-radius: 4px; margin-bottom: 2rem;">Course added successfully!</div>
        <% } %>
        <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("deleted")) { %>
            <div style="background-color: #f8d7da; color: #721c24; padding: 1rem; border-radius: 4px; margin-bottom: 2rem;">Course deleted.</div>
        <% } %>

        <!-- Add Course Form (Hidden by default) -->
        <div id="addCourseForm" class="card" style="display: none; margin-bottom: 2rem; border-top: 4px solid var(--tomato-red);">
            <h3 style="margin-bottom: 1.5rem;">Create New Course</h3>
            <form action="${pageContext.request.contextPath}/admin/add-course" method="post">
                <div class="form-group">
                    <label>Course Title</label>
                    <input type="text" name="title" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Short Description (For Cards)</label>
                    <textarea name="description" class="form-control" rows="2" required></textarea>
                </div>
                <div class="form-group">
                    <label>Full Course Description (For View Details)</label>
                    <textarea name="fullDescription" class="form-control" rows="6" required></textarea>
                </div>
                <div class="form-group">
                    <label>Thumbnail URL (Optional)</label>
                    <input type="url" name="thumbnail" class="form-control" placeholder="https://example.com/image.jpg">
                </div>
                <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
                    <button type="submit" class="btn-primary">Save Course</button>
                    <button type="button" class="btn-primary" style="background-color: var(--text-light);" onclick="document.getElementById('addCourseForm').style.display='none';">Cancel</button>
                </div>
            </form>
        </div>

        <!-- Courses Table -->
        <div class="card" style="overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                <thead>
                    <tr style="border-bottom: 2px solid var(--border-color);">
                        <th style="padding: 1rem;">ID</th>
                        <th style="padding: 1rem;">Thumbnail</th>
                        <th style="padding: 1rem;">Title</th>
                        <th style="padding: 1rem;">Created</th>
                        <th style="padding: 1rem; text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="course" items="${courses}">
                        <tr style="border-bottom: 1px solid var(--border-color);">
                            <td style="padding: 1rem;">${course.id}</td>
                            <td style="padding: 1rem;">
                                <img src="${empty course.thumbnail ? pageContext.request.contextPath.concat('/images/default-course.jpg') : course.thumbnail}" alt="thumb" style="width:50px; height:50px; object-fit:cover; border-radius:4px; background:#eee;">
                            </td>
                            <td style="padding: 1rem; font-weight: 500;">${course.title}</td>
                            <td style="padding: 1rem; color: var(--text-light);">${course.createdAt}</td>
                            <td style="padding: 1rem; text-align: center;">
                                <form action="${pageContext.request.contextPath}/admin/delete-course" method="post" style="display: inline-block;" onsubmit="return confirm('Are you sure you want to delete this course and all its lessons?');">
                                    <input type="hidden" name="courseId" value="${course.id}">
                                    <button type="submit" style="background: none; border: none; color: var(--tomato-red); cursor: pointer; font-size: 1.2rem;" title="Delete Course">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty courses}">
                        <tr><td colspan="5" style="padding: 1rem; text-align: center; color: var(--text-light);">No courses found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
