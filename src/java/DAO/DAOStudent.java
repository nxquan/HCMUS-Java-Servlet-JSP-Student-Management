package DAO;

import db.JDBCUtils;
import java.util.ArrayList;
import model.Student;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Date;

public class DAOStudent implements DAOInterface<Student> {

    public static DAOStudent instance;

    private DAOStudent() {
    }

    public static DAOStudent getInstance() {
        if (instance == null) {
            instance = new DAOStudent();
        }
        return instance;
    }

    @Override
    public int insert(Student t) {
        int count = 0;
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "INSERT INTO student (id, name, grade, birthday, address, notes) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, t.getId());
            statement.setNString(2, t.getName());
            statement.setInt(3, t.getGrade());
            statement.setDate(4, t.getBirthday());
            statement.setString(5, t.getAddress());
            statement.setString(6, t.getNotes());

            count = statement.executeUpdate();
            JDBCUtils.closeConnection(connect);

        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return count;
    }

    @Override
    public int update(Student t) {
        int count = 0;
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "UPDATE student SET name=?, grade=?, birthday=?, address=?, notes=? WHERE id=?";

            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, t.getName());
            statement.setDouble(2, t.getGrade());
            statement.setDate(3, t.getBirthday());
            statement.setString(4, t.getAddress());
            statement.setString(5, t.getNotes());
            statement.setString(6, t.getId());
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

            String sql = "DELETE FROM student WHERE id=?";

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
    public ArrayList<Student> selectAll() {
        ArrayList<Student> result = new ArrayList<>();
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "SELECT * FROM student";

            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet set = statement.executeQuery();

            while (set.next()) {
                String id = set.getString("id");
                String name = set.getString("name");
                int grade = set.getInt("grade");
                Date birthday = set.getDate("birthday");
                String address = set.getString("address");
                String notes = set.getString("notes");

                Student student = new Student(id, name, grade, birthday, address, notes);
                result.add(student);
            }
            
            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return result;
    }

    @Override
    public Student selectById(String id) {
        Student result = null;
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "SELECT * FROM student WHERE id=?";

            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, id);

            ResultSet set = statement.executeQuery();

            while (set.next()) {
                String _id = set.getString("id");
                String name = set.getString("name");
                int grade = set.getInt("grade");
                Date birthday = set.getDate("birthday");
                String address = set.getString("address");
                String notes = set.getString("notes");

                Student student = new Student(_id, name, grade, birthday, address, notes);
                result = student;
            }

            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return result;
    }

    @Override
    public ArrayList<Student> selectByGivenCondition(String condition) {
        ArrayList<Student> result = new ArrayList<>();
        try {
            Connection connect = JDBCUtils.getConnection();

            String sql = "SELECT * FROM student WHERE " + condition;

            PreparedStatement statement = connect.prepareStatement(sql);
            ResultSet set = statement.executeQuery();
            
            System.out.println(sql);

            while (set.next()) {
                String id = set.getString("id");
                String name = set.getString("name");
                int grade = set.getInt("grade");
                Date birthday = set.getDate("birthday");
                String address = set.getString("address");
                String notes = set.getString("notes");

                Student student = new Student(id, name, grade, birthday, address, notes);
                result.add(student);
            }
            JDBCUtils.closeConnection(connect);
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return result;
        
    }

}
