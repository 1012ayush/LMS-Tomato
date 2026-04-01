package com.tomatolms.model;

import java.sql.Timestamp;

public class Progress {
    private int id;
    private int userId;
    private int lessonId;
    private String status;
    private Timestamp completedAt;

    public Progress() {}

    public Progress(int id, int userId, int lessonId, String status, Timestamp completedAt) {
        this.id = id;
        this.userId = userId;
        this.lessonId = lessonId;
        this.status = status;
        this.completedAt = completedAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getLessonId() { return lessonId; }
    public void setLessonId(int lessonId) { this.lessonId = lessonId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCompletedAt() { return completedAt; }
    public void setCompletedAt(Timestamp completedAt) { this.completedAt = completedAt; }
}
