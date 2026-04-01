package com.tomatolms.model;

import java.sql.Timestamp;

public class Submission {
    private int id;
    private int assignmentId;
    private int userId;
    private String fileUrl;
    private Integer marks;
    private Timestamp submittedAt;

    public Submission() {}

    public Submission(int id, int assignmentId, int userId, String fileUrl, Integer marks, Timestamp submittedAt) {
        this.id = id;
        this.assignmentId = assignmentId;
        this.userId = userId;
        this.fileUrl = fileUrl;
        this.marks = marks;
        this.submittedAt = submittedAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getAssignmentId() { return assignmentId; }
    public void setAssignmentId(int assignmentId) { this.assignmentId = assignmentId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFileUrl() { return fileUrl; }
    public void setFileUrl(String fileUrl) { this.fileUrl = fileUrl; }

    public Integer getMarks() { return marks; }
    public void setMarks(Integer marks) { this.marks = marks; }

    public Timestamp getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(Timestamp submittedAt) { this.submittedAt = submittedAt; }
}
