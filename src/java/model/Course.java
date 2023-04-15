
package model;

public class Course {
    private String id;
    private String name;
    private String lecture;
    private int year;
    private String notes;

    public Course() {
    }

    public Course(String id, String name, String lecture, int year, String notes) {
        this.id = id;
        this.name = name;
        this.lecture = lecture;
        this.year = year;
        this.notes = notes;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLecture() {
        return lecture;
    }

    public void setLecture(String lecture) {
        this.lecture = lecture;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    
}
