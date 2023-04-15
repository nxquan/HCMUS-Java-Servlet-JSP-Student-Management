package DAO;

import db.JDBCUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import java.util.ArrayList;
import model.EnrollmentCourse;

public class DAOEnrollmentCourse implements DAOInterface<EnrollmentCourse> {

    public static DAOEnrollmentCourse instance;

    private DAOEnrollmentCourse() {
    }

    public static DAOEnrollmentCourse getInstance() {
        if (instance == null) {
            instance = new DAOEnrollmentCourse();
        }
        return instance;
    }

    @Override
    public int insert(EnrollmentCourse t) {
        int count = 0;
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "INSERT INTO enroll_course (studentId, courseId, score) "
                    + "VALUES (?, ?, ?)";

            PreparedStatement statement = connect.prepareStatement(sql);
            
            statement.setString(1, t.getStudentId());
            statement.setString(2, t.getCourseId());
            statement.setDouble(3, t.getScore());

            count = statement.executeUpdate();
            JDBCUtils.closeConnection(connect);
            
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return count;
        
        
    }

    @Override
    public int update(EnrollmentCourse t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public int delete(String studentId, String courseId) {
        int count = 0;
        
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "DELETE FROM enroll_course WHERE studentId=? and courseId=?";

            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, studentId);
            statement.setString(2, courseId);

            count = statement.executeUpdate();
            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        
        return count;
    }

    @Override
    public ArrayList<EnrollmentCourse> selectAll() {
        ArrayList<EnrollmentCourse> result = new ArrayList<>();
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "SELECT * FROM course";

            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet set = statement.executeQuery();

            while (set.next()) {
                String id = set.getString("studentId");
                String name = set.getString("courseId");
                double score = set.getDouble("score");
                EnrollmentCourse course = new EnrollmentCourse(id, id, score);
                result.add(course);
            }
            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        
        return result;
    }

    @Override
    public EnrollmentCourse selectById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<EnrollmentCourse> selectByGivenCondition(String condition) {
        
        ArrayList<EnrollmentCourse> result = new ArrayList<>();
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "SELECT * FROM enroll_course WHERE " + condition;

            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet set = statement.executeQuery();

            while (set.next()) {
                String studentId = set.getString("studentId");
                String courseId = set.getString("courseId");
                double score = set.getDouble("score");
                
                EnrollmentCourse enrollmentCourse = new EnrollmentCourse(studentId, courseId, score);
                result.add(enrollmentCourse);
            }

            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return result;
    }

    @Override
    public int delete(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
