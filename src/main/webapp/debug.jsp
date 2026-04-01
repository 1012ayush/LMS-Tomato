<%@ page import="java.sql.*, com.tomatolms.util.DBConnection, com.tomatolms.model.Course, com.tomatolms.dao.CourseDAO, java.util.List" %>
<%
    out.println("<h2>Debugging getAllCourses</h2>");
    try {
        CourseDAO dao = new CourseDAO();
        List<Course> clist = dao.getAllCourses();
        out.println("DAO returned " + clist.size() + " courses.<br>");
        
        // Manual check bypassing DAO
        out.println("<h3>Manual Check</h3>");
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM courses");
             ResultSet rs = stmt.executeQuery()) {
            ResultSetMetaData meta = rs.getMetaData();
            for (int i = 1; i <= meta.getColumnCount(); i++) {
                out.print(meta.getColumnName(i) + " | ");
            }
            out.println("<br>");
            while (rs.next()) {
                out.println("Row ID: " + rs.getInt("id") + ", Title: " + rs.getString("title") + "<br>");
                // Test specific column
                out.println("FullDesc: " + rs.getString("full_description") + "<br>");
            }
        } catch (Exception e) {
            out.println("SQL Error: " + e.getMessage() + "<br>");
            for (StackTraceElement el : e.getStackTrace()) {
                out.println(el.toString() + "<br>");
            }
        }
    } catch (Exception e) {
        out.println("Outer Error: " + e.getMessage());
    }
%>
