package com.tomatolms.dao;

import com.tomatolms.model.Course;
import com.tomatolms.model.Enrollment;
import com.tomatolms.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAO {

    public boolean enroll(int userId, int courseId) {
        if (isEnrolled(userId, courseId)) {
            return false; // Already enrolled
        }
        String query = "INSERT INTO enrollments (user_id, course_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEnrolled(int userId, int courseId) {
        String query = "SELECT id FROM enrollments WHERE user_id = ? AND course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Course> getEnrolledCourses(int userId) {
        List<Course> list = new ArrayList<>();
        String query = "SELECT c.* FROM courses c INNER JOIN enrollments e ON c.id = e.course_id WHERE e.user_id = ? AND e.approval_status = 'approved' ORDER BY e.enrolled_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Course(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("full_description"),
                        rs.getInt("instructor_id"),
                        rs.getString("thumbnail"),
                        rs.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Course> getPendingCourses(int userId) {
        List<Course> list = new ArrayList<>();
        String query = "SELECT c.* FROM courses c INNER JOIN enrollments e ON c.id = e.course_id WHERE e.user_id = ? AND e.approval_status = 'pending' ORDER BY e.enrolled_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Course(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("full_description"),
                        rs.getInt("instructor_id"),
                        rs.getString("thumbnail"),
                        rs.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Enrollment> getPendingEnrollmentsForAdmin() {
        List<Enrollment> list = new ArrayList<>();
        String query = "SELECT e.*, u.name as user_name, c.title as course_title " +
                       "FROM enrollments e " +
                       "JOIN users u ON e.user_id = u.id " +
                       "JOIN courses c ON e.course_id = c.id " +
                       "WHERE e.approval_status = 'pending' " +
                       "ORDER BY e.enrolled_at ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Enrollment en = new Enrollment(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getInt("course_id"),
                    rs.getString("approval_status"),
                    rs.getTimestamp("enrolled_at")
                );
                en.setUserName(rs.getString("user_name"));
                en.setCourseTitle(rs.getString("course_title"));
                list.add(en);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateEnrollmentStatus(int id, String status) {
        String query = "UPDATE enrollments SET approval_status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public int getEnrollmentCountByCourse(int courseId) {
        String query = "SELECT COUNT(*) FROM enrollments WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
