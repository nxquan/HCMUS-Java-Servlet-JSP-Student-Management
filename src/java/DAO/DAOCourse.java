package DAO;

import db.JDBCUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import java.util.ArrayList;
import model.Course;

public class DAOCourse implements DAOInterface<Course> {

    public static DAOCourse instance;

    private DAOCourse() {
    }

    public static DAOCourse getInstance() {
        if (instance == null) {
            instance = new DAOCourse();
        }
        return instance;
    }

    @Override
    public int insert(Course t) {
        int count = 0;
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "INSERT INTO course (id, name, lecture, year, notes) "
                    + "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, t.getId());
            statement.setString(2, t.getName());
            statement.setString(3, t.getLecture());
            statement.setInt(4, t.getYear());
            statement.setString(5, t.getNotes());

            count = statement.executeUpdate();
            System.out.println("count");
            JDBCUtils.closeConnection(connect);

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return count;
    }

    @Override
    public int update(Course t) {
        int count = 0;
        try {
            Connection connect = JDBCUtils.getConnection();
            String sql = "UPDATE course SET name=?, lecture=?, year=?, notes=? WHERE id=?";

            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, t.getName());
            statement.setString(2, t.getLecture());
            statement.setInt(3, t.getYear());
            statement.setString(4, t.getNotes());
            statement.setString(5, t.getId());
            
            count = statement.executeUpdate();
            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return count;
    }

    @Override
    public int delete(String id) {
        int count = 0;
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "DELETE FROM course WHERE id=?";

            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, id);

            count = statement.executeUpdate();
            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return count;
    }

    @Override
    public ArrayList<Course> selectAll() {
        ArrayList<Course> result = new ArrayList<>();
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "SELECT * FROM course";

            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet set = statement.executeQuery();

            while (set.next()) {
                String id = set.getString("id");
                String name = set.getString("name");
                String lecture = set.getString("lecture");
                int year = set.getInt("year");
                String notes = set.getString("notes");
                Course course = new Course(id, name, lecture, year, notes);

                result.add(course);
            }

            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return result;
    }

    @Override
    public Course selectById(String id) {
        Course result = null;
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "SELECT * FROM course WHERE id=?";

            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, id);
            ResultSet set = statement.executeQuery();

            while (set.next()) {
                String _id = set.getString("id");
                String name = set.getString("name");
                String lecture = set.getString("lecture");
                int year = set.getInt("year");
                String notes = set.getString("notes");
                Course course = new Course(_id, name, lecture, year, notes);

                result = course;
            }

            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }

        return result;
    }

    @Override
    public ArrayList<Course> selectByGivenCondition(String condition) {
        ArrayList<Course> result = new ArrayList<>();
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "SELECT * FROM course WHERE " + condition;

            System.out.println(sql);
            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet set = statement.executeQuery();

            while (set.next()) {
                String id = set.getString("id");
                String name = set.getString("name");
                String lecture = set.getString("lecture");
                int year = set.getInt("year");
                String notes = set.getString("notes");
                Course course = new Course(id, name, lecture, year, notes);

                result.add(course);
            }

            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return result;
    }

}
