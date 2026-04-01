package com.tomatolms.dao;

import com.tomatolms.model.Submission;
import com.tomatolms.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubmissionDAO {

    public boolean addOrUpdateSubmission(Submission submission) {
        String query = "INSERT INTO submissions (assignment_id, user_id, file_url) VALUES (?, ?, ?) " +
                       "ON DUPLICATE KEY UPDATE file_url = ?, submitted_at = CURRENT_TIMESTAMP";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, submission.getAssignmentId());
            stmt.setInt(2, submission.getUserId());
            stmt.setString(3, submission.getFileUrl());
            stmt.setString(4, submission.getFileUrl());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean gradeSubmission(int submissionId, int marks) {
        String query = "UPDATE submissions SET marks = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, marks);
            stmt.setInt(2, submissionId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Submission getSubmissionByUserAndAssignment(int userId, int assignmentId) {
        String query = "SELECT * FROM submissions WHERE user_id = ? AND assignment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, assignmentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Integer marks = rs.getObject("marks") != null ? rs.getInt("marks") : null;
                return new Submission(
                        rs.getInt("id"),
                        rs.getInt("assignment_id"),
                        rs.getInt("user_id"),
                        rs.getString("file_url"),
                        marks,
                        rs.getTimestamp("submitted_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Submission> getSubmissionsByAssignmentId(int assignmentId) {
        List<Submission> list = new ArrayList<>();
        String query = "SELECT * FROM submissions WHERE assignment_id = ? ORDER BY submitted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, assignmentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Integer marks = rs.getObject("marks") != null ? rs.getInt("marks") : null;
                list.add(new Submission(
                        rs.getInt("id"),
                        rs.getInt("assignment_id"),
                        rs.getInt("user_id"),
                        rs.getString("file_url"),
                        marks,
                        rs.getTimestamp("submitted_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
