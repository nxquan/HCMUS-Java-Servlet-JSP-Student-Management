package controllers;

import DAO.DAOStudent;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import static java.util.Collections.sort;
import java.util.Comparator;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Student;

@WebServlet(urlPatterns = "/student-list")
public class StudentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("./students.jsp");

        //Check sorting in here or finding
        String keyword = req.getParameter("search-keyword");
        String sortBy = req.getParameter("sort-by");

        ArrayList< Student> list = new ArrayList<>();

        if (keyword != null && keyword.length() > 0) {
            list = DAOStudent.getInstance().selectByGivenCondition("name LIKE '%" + keyword + "%'");
            req.setAttribute("search-keyword", keyword);

        } else {
            list = DAOStudent.getInstance().selectAll();
        }

        if (sortBy != null && !sortBy.equals("--Chọn--")) {
            req.setAttribute("sort-by", sortBy);
            switch (sortBy) {
                case "name-ascending" ->
                    sort(list, (Student o1, Student o2) -> o1.getName().compareTo(o2.getName()));
                case "name-descending" ->
                    sort(list, (Student o1, Student o2) -> o2.getName().compareTo(o1.getName()));
                case "grade-ascending" ->
                    sort(list, (Student o1, Student o2) -> o1.getGrade() - o2.getGrade());
                case "grade-descending" ->
                    sort(list, (Student o1, Student o2) -> o2.getGrade() - o1.getGrade());

            }
        }

        req.setAttribute("list", list);
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("./students.jsp");
        req.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");
        String name = req.getParameter("name");
        int grade = Integer.parseInt(req.getParameter("grade"));
        String birthday = req.getParameter("birthday");
        String address = req.getParameter("address");
        String notes = req.getParameter("notes");
        Date birthday2 = Date.valueOf(birthday);
        Student student = new Student(id, name, grade, birthday2, address, notes);

        DAOStudent.getInstance().update(student);

        ArrayList< Student> list = DAOStudent.getInstance().selectAll();
        req.setAttribute("list", list);
        dispatcher.forward(req, resp);
    }
}
