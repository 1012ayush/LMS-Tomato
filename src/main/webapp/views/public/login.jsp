<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../components/navbar.jsp" />

<div style="display: flex; justify-content: center; align-items: center; min-height: 80vh;">
    <div class="card" style="width: 100%; max-width: 400px;">
        <h2 style="text-align: center; color: var(--primary); margin-bottom: 1.5rem;">
            <i class="fa-solid fa-right-to-bracket"></i> ${param.role == 'admin' ? 'Admin Portal' : 'Student Login'}
        </h2>
        
        <% if(request.getParameter("error") != null) { %>
            <div style="color: red; margin-bottom: 1rem; text-align: center;">Invalid Email or Password!</div>
        <% } %>
        <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("registered")) { %>
            <div style="background-color: #d4edda; color: #155724; padding: 1rem; border-radius: 4px; margin-bottom: 1rem; text-align: center;">Registration successful! Please login below.</div>
        <% } %>
        <% if(request.getParameter("msg") != null && request.getParameter("msg").equals("loggedout")) { %>
            <div style="background-color: #d4edda; color: #155724; padding: 1rem; border-radius: 4px; margin-bottom: 1rem; text-align: center;">You have been securely logged out.</div>
        <% } %>

        <form action="${pageContext.request.contextPath}/auth/login" method="post">
            <c:if test="${param.role == 'admin'}">
                <input type="hidden" name="role" value="admin">
            </c:if>
            <div class="form-group">
                <label for="email"><i class="fa-solid fa-envelope"></i> Email Address</label>
                <input type="email" id="email" name="email" class="form-control" required placeholder="Enter email">
            </div>
            
            <div class="form-group" style="margin-bottom: 1.5rem;">
                <label for="password"><i class="fa-solid fa-lock"></i> Password</label>
                <input type="password" id="password" name="password" class="form-control" required placeholder="Enter password">
            </div>
            
            <button type="submit" class="btn-primary" style="width: 100%; font-size: 1.1rem;">Login Securely</button>
        </form>
        
        <div style="text-align: center; margin-top: 1.5rem;">
            <p>Don't have an account? 
            <a href="${pageContext.request.contextPath}/auth/register${param.role == 'admin' ? '?role=admin' : ''}" style="color: var(--primary); font-weight: 500;">
                ${param.role == 'admin' ? 'Register as Admin here' : 'Register here'}
            </a>
            </p>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
