package com.tomatolms.dao;

import com.tomatolms.model.Progress;
import com.tomatolms.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProgressDAO {

    public boolean markLessonCompleted(int userId, int lessonId) {
        String query = "INSERT INTO progress (user_id, lesson_id, status) VALUES (?, ?, 'completed') " +
                       "ON DUPLICATE KEY UPDATE status = 'completed', completed_at = CURRENT_TIMESTAMP";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, lessonId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isLessonCompleted(int userId, int lessonId) {
        String query = "SELECT id FROM progress WHERE user_id = ? AND lesson_id = ? AND status = 'completed'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, lessonId);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Integer> getCompletedLessonIdsByCourse(int userId, int courseId) {
        List<Integer> list = new ArrayList<>();
        String query = "SELECT p.lesson_id FROM progress p " +
                       "INNER JOIN lessons l ON p.lesson_id = l.id " +
                       "WHERE p.user_id = ? AND l.course_id = ? AND p.status = 'completed'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, courseId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("lesson_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
