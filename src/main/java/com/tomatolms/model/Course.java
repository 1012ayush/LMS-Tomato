package com.tomatolms.model;

import java.sql.Timestamp;

public class Course {
    private int id;
    private String title;
    private String description;
    private String fullDescription;
    private int instructorId;
    private String thumbnail;
    private Timestamp createdAt;

    public Course() {}

    public Course(int id, String title, String description, String fullDescription, int instructorId, String thumbnail, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.fullDescription = fullDescription;
        this.instructorId = instructorId;
        this.thumbnail = thumbnail;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getFullDescription() { return fullDescription; }
    public void setFullDescription(String fullDescription) { this.fullDescription = fullDescription; }

    public int getInstructorId() { return instructorId; }
    public void setInstructorId(int instructorId) { this.instructorId = instructorId; }

    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
