package controllers;

import DAO.DAOCourse;
import java.io.IOException;
import java.util.ArrayList;
import static java.util.Collections.sort;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Course;

@WebServlet(urlPatterns = {"/course-list"})
public class CourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("./courses.jsp");

        String keyword = req.getParameter("search-keyword");
        String sortBy = req.getParameter("sort-by");

        ArrayList< Course> list = null;

        if (keyword != null && keyword.length() > 0) {
            list = DAOCourse.getInstance().selectByGivenCondition("name LIKE '%" + keyword + "%'");
        } else {
            list = DAOCourse.getInstance().selectAll();

        }

        if (sortBy != null && !sortBy.equals("--Chọn--")) {
            System.out.println("sortBy");
            switch (sortBy) {
                case "name-ascending" ->
                    sort(list, (Course o1, Course o2) -> o1.getName().compareTo(o2.getName()));
                case "name-descending" ->
                    sort(list, (Course o1, Course o2) -> o2.getName().compareTo(o1.getName()));
                default -> {
                }
            }
        }

        req.setAttribute("list", list);
        dispatcher.forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        RequestDispatcher dispatcher = req.getRequestDispatcher("./courses.jsp");
        req.setCharacterEncoding("UTF-8");
        
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String lecture = req.getParameter("lecture");
        int year = Integer.parseInt(req.getParameter("year"));
        String notes = req.getParameter("notes");
        Course course = new Course(id, name, lecture, year, notes);
        DAOCourse.getInstance().update(course);
        ArrayList< Course> list = DAOCourse.getInstance().selectAll();
        
        req.setAttribute("list", list);
        dispatcher.forward(req, resp);
    }
}
