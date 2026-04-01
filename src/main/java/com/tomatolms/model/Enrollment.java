package com.tomatolms.model;

import java.sql.Timestamp;

public class Enrollment {
    private int id;
    private int userId;
    private int courseId;
    private String approvalStatus;
    private Timestamp enrolledAt;
    
    // Virtual fields for joined queries
    private String userName;
    private String courseTitle;

    public Enrollment() {}

    public Enrollment(int id, int userId, int courseId, String approvalStatus, Timestamp enrolledAt) {
        this.id = id;
        this.userId = userId;
        this.courseId = courseId;
        this.approvalStatus = approvalStatus;
        this.enrolledAt = enrolledAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }

    public Timestamp getEnrolledAt() { return enrolledAt; }
    public void setEnrolledAt(Timestamp enrolledAt) { this.enrolledAt = enrolledAt; }

    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { this.approvalStatus = approvalStatus; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
}
