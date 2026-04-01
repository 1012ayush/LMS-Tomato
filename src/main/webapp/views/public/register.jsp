<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../../components/navbar.jsp" />

<div style="display: flex; justify-content: center; align-items: center; min-height: 80vh; padding: 2rem 0;">
    <div class="card" style="width: 100%; max-width: 450px;">
        <h2 style="text-align: center; color: var(--tomato-red); margin-bottom: 1.5rem;">
            <i class="fa-solid fa-user-plus"></i> ${param.role == 'admin' ? 'Register as Admin' : 'Register'}
        </h2>
        
        <% if(request.getParameter("error") != null) { %>
            <div style="color: red; margin-bottom: 1rem; text-align: center;">Registration failed. Email might already exist!</div>
        <% } %>

        <form action="${pageContext.request.contextPath}/auth/register" method="post">
            <c:if test="${param.role == 'admin'}">
                <input type="hidden" name="role" value="admin">
            </c:if>
            <div class="form-group">
                <label for="name"><i class="fa-solid fa-user"></i> Full Name</label>
                <input type="text" id="name" name="name" class="form-control" required placeholder="John Doe">
            </div>

            <div class="form-group">
                <label for="email"><i class="fa-solid fa-envelope"></i> Email Address</label>
                <input type="email" id="email" name="email" class="form-control" required placeholder="johndoe@example.com">
            </div>
            
            <div class="form-group" style="margin-bottom: 1.5rem;">
                <label for="password"><i class="fa-solid fa-lock"></i> Password</label>
                <input type="password" id="password" name="password" class="form-control" required placeholder="Create a strong password">
            </div>
            
            <button type="submit" class="btn-primary" style="width: 100%; font-size: 1.1rem;">Register Account</button>
        </form>
        
        <div style="text-align: center; margin-top: 1.5rem;">
            <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login" style="color: var(--tomato-red); font-weight: 500;">Login here</a></p>
        </div>
    </div>
</div>

<jsp:include page="../../components/footer.jsp" />
