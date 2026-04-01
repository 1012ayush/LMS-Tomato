<%@ page import="java.sql.*, com.tomatolms.util.DBConnection" %>
<%
    out.println("Adding specific courses to database...<br>");
    try (Connection conn = DBConnection.getConnection();
         Statement stmt = conn.createStatement()) {
         
         String[] titles = {"Web Development", "AI & ML", "WEB 3.0"};
         String[] descs = {
             "Master full-stack programming and build interactive, dynamic web applications from scratch.",
             "Way to Intelligent Automation: Dive into Artificial Intelligence and Machine Learning to drive automation.",
             "Explore decentralized technologies, blockchain, and smart contracts to build the future internet."
         };
         String[] fullDescs = {
             "This comprehensive Web Development course covers HTML, CSS, JavaScript, React, Node.js, and database management. You will build real-world projects, understand responsive design, and learn best practices for modern web architecture.",
             "Learn the foundations of AI and Machine Learning. This course covers neural networks, deep learning, natural language processing, and computer vision. Gain hands-on experience using Python and popular ML libraries to build intelligent models.",
             "WEB 3.0 represents the future of the internet. In this course, you will understand the fundamentals of blockchain technology, how to write and deploy smart contracts using Solidity, and how to create decentralized applications (dApps)."
         };
         String[] thumbnails = {
             request.getContextPath() + "/images/web-development.jpg",
             request.getContextPath() + "/images/ai-ml.jpg",
             request.getContextPath() + "/images/web-3-0.jpg"
         };
         
         for (int i = 0; i < titles.length; i++) {
             String insertCourse = "INSERT INTO courses (title, description, full_description, instructor_id, thumbnail) VALUES (?, ?, ?, ?, ?)";
             try (PreparedStatement pstmt = conn.prepareStatement(insertCourse, Statement.RETURN_GENERATED_KEYS)) {
                 pstmt.setString(1, titles[i]);
                 pstmt.setString(2, descs[i]);
                 pstmt.setString(3, fullDescs[i]);
                 pstmt.setInt(4, 1); // Admin user
                 pstmt.setString(5, thumbnails[i]);
                 pstmt.executeUpdate();
                 
                 ResultSet rs = pstmt.getGeneratedKeys();
                 if (rs.next()) {
                     int courseId = rs.getInt(1);
                     out.println("Success: Added course " + titles[i] + " with ID " + courseId + "<br>");
                     
                     // Enroll all existing users into this course as 'approved'
                     String enrollQuery = "INSERT INTO enrollments (user_id, course_id, approval_status) SELECT id, ?, 'approved' FROM users ON DUPLICATE KEY UPDATE approval_status='approved'";
                     try (PreparedStatement enrollStmt = conn.prepareStatement(enrollQuery)) {
                         enrollStmt.setInt(1, courseId);
                         int enrolledCount = enrollStmt.executeUpdate();
                         out.println("Enrolled users in " + titles[i] + "<br>");
                     }
                 }
             } catch (Exception e) {
                 out.println("Failed to insert course: " + titles[i] + " - " + e.getMessage() + "<br>");
             }
         }

    } catch (Exception e) {
        out.println("Database connection error: " + e.getMessage());
    }
%>
