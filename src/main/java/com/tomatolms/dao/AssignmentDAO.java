package com.tomatolms.dao;

import com.tomatolms.model.Assignment;
import com.tomatolms.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO {

    public boolean addAssignment(Assignment assignment) {
        String query = "INSERT INTO assignments (course_id, title, description, due_date) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, assignment.getCourseId());
            stmt.setString(2, assignment.getTitle());
            stmt.setString(3, assignment.getDescription());
            if (assignment.getDueDate() != null) {
                stmt.setTimestamp(4, new Timestamp(assignment.getDueDate().getTime()));
            } else {
                stmt.setNull(4, java.sql.Types.TIMESTAMP);
            }
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Assignment> getAssignmentsByCourseId(int courseId) {
        List<Assignment> list = new ArrayList<>();
        String query = "SELECT * FROM assignments WHERE course_id = ? ORDER BY due_date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Assignment(
                        rs.getInt("id"),
                        rs.getInt("course_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getTimestamp("due_date"),
                        rs.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteAssignment(int id) {
        String query = "DELETE FROM assignments WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getPendingAssignmentsCount(int userId) {
        String query = "SELECT count(a.id) FROM assignments a " +
                       "JOIN enrollments e ON a.course_id = e.course_id " +
                       "WHERE e.user_id = ? AND a.id NOT IN (" +
                       "  SELECT assignment_id FROM submissions WHERE user_id = ?" +
                       ")";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Assignment> getPendingAssignmentsForUser(int userId) {
        List<Assignment> list = new ArrayList<>();
        String query = "SELECT a.* FROM assignments a " +
                       "JOIN enrollments e ON a.course_id = e.course_id " +
                       "WHERE e.user_id = ? AND a.id NOT IN (" +
                       "  SELECT assignment_id FROM submissions WHERE user_id = ?" +
                       ") ORDER BY a.due_date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Assignment(
                        rs.getInt("id"),
                        rs.getInt("course_id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getTimestamp("due_date"),
                        rs.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
