<%@ page import="java.sql.*, com.tomatolms.util.DBConnection, com.tomatolms.model.Course, com.tomatolms.dao.CourseDAO, java.util.List" %>
<%
    out.println("<h2>Debugging getAllCourses Java6</h2>");
    try {
        CourseDAO dao = new CourseDAO();
        List<Course> clist = dao.getAllCourses();
        out.println("DAO returned " + clist.size() + " courses.<br>");
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM courses");
            rs = stmt.executeQuery();
            while (rs.next()) {
                out.println("Course ID: " + rs.getInt("id") + " Title: " + rs.getString("title") + "<br>");
            }
        } catch (Exception e) {
            out.println("SQL Error: " + e.getMessage() + "<br>");
            for (StackTraceElement el : e.getStackTrace()) {
                out.println(el.toString() + "<br>");
            }
        } finally {
            if (rs != null) try { rs.close(); } catch(Exception e) {}
            if (stmt != null) try { stmt.close(); } catch(Exception e) {}
            if (conn != null) try { conn.close(); } catch(Exception e) {}
        }
    } catch (Exception e) {
        out.println("Outer Error: " + e.getMessage());
    }
%>
