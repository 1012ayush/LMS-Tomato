<%@ page import="java.sql.*, com.tomatolms.util.DBConnection" %>
<%
    out.println("Applying database migration...<br>");
    try (Connection conn = DBConnection.getConnection();
         Statement stmt = conn.createStatement()) {
         
         // 1. Try to add full_description
         try {
             stmt.executeUpdate("ALTER TABLE courses ADD COLUMN full_description TEXT AFTER description");
             out.println("Success: Added full_description to courses.<br>");
         } catch (Exception e) {
             out.println("Failed to add full_description (might already exist): " + e.getMessage() + "<br>");
         }

         // 2. Clear any constraints or ensure user id=1 exists
         try {
             stmt.executeUpdate("INSERT INTO users (id, name, email, password, role) VALUES (1, 'Admin User', 'admin@tomatolms.com', 'admin123', 'admin') ON DUPLICATE KEY UPDATE role='admin'");
             out.println("Success: Ensured Admin User with ID=1 exists for bypass logic.<br>");
         } catch (Exception e) {
             out.println("Failed to ensure Admin User: " + e.getMessage() + "<br>");
         }

         // 3. Test insert course
         try {
             stmt.executeUpdate("INSERT INTO courses (title, description, full_description, instructor_id, thumbnail) VALUES ('Test Course', 'Short', 'Full', 1, '')");
             out.println("Success: Test Course Insertion Passed.<br>");
             // Clean up
             stmt.executeUpdate("DELETE FROM courses WHERE title = 'Test Course'");
         } catch (Exception e) {
             out.println("Failed Test Insertion: " + e.getMessage() + "<br>");
         }

    } catch (Exception e) {
        out.println("Database connection error: " + e.getMessage());
    }
%>
