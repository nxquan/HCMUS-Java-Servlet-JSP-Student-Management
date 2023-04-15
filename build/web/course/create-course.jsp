<%@page import="DAO.DAOCourse"%>
<%@page import="model.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String lecture = request.getParameter("lecture");
            int year = Integer.parseInt(request.getParameter("year"));
            String notes = request.getParameter("notes");
            Course course = new Course(id, name, lecture, year, notes);
            DAOCourse.getInstance().insert(course);

            response.sendRedirect("/student-management/course-list");
        %>
    </body>
</html>
