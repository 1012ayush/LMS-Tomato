<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/components/navbar.jsp" />

<div class="hero-section" style="background: white; color: var(--text-dark);">
    <div class="hero-content">
        <h1 style="color: var(--dark-bg);">About Us</h1>
        <p style="color: var(--text-light); font-size: 1.1rem; line-height: 1.8;">
            Tomato LMS is dedicated to providing high-quality educational content to students worldwide. We focus on interactive learning, robust progress tracking, and delivering resources that enable you to achieve your career goals. 
            <br><br>
            Our cutting-edge platform ensures a seamless experience whether you are learning to code, exploring new technologies, or mastering complex algorithms.
        </p>
        <a href="${pageContext.request.contextPath}/courses/list" class="btn-primary" style="margin-top: 1rem;">View All Courses</a>
    </div>
    <div class="hero-image">
        <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="About Team">
    </div>
</div>

<div class="content-inner" style="padding-top: 2rem;">
    <h2 class="section-title">Our Goals</h2>
    <p class="section-subtitle">What drives us to build the best platform.</p>

    <div class="grid" style="align-items: stretch;">
        <div class="feature-card red">
            <i class="fa-solid fa-star"></i>
            <h3>Quality Content</h3>
            <p>We partner with industry-leading experts to bring you the highest quality coursework available. Every module is meticulously reviewed.</p>
        </div>
        
        <div class="feature-card dark">
            <i class="fa-solid fa-laptop-code"></i>
            <h3>Flexible Learning</h3>
            <p>Learn at your own pace, on your own schedule. Our platform is accessible 24/7 on any device, anywhere in the world.</p>
        </div>

        <div class="feature-card gradient">
            <i class="fa-solid fa-chart-line"></i>
            <h3>Progress Tracking</h3>
            <p>Our intuitive dashboards give you real-time insights into your learning journey, helping you stay motivated and on track.</p>
        </div>
    </div>
</div>

<jsp:include page="/components/footer.jsp" />
