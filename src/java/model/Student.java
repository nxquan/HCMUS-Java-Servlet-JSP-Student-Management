package model;

import java.sql.Date;

public class Student {

    private String id;
    private String name;
    private int grade;

    private Date birthday;
    private String address;
    private String notes;

    public Student() {
    }

    public Student(String id, String name, int grade, Date birthday, String address, String notes) {
        this.id = id;
        this.name = name;
        this.grade = grade;
        this.birthday = birthday;
        this.address = address;
        this.notes = notes;
    }

    
    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getGrade() {
        return grade;
    }

    public Date getBirthday() {
        return birthday;
    }

    public String getAddress() {
        return address;
    }

    public String getNotes() {
        return notes;
    }

    
}
