<%@page import="DAO.DAOStudent"%>
<%@page import="model.Student"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <%
            request.setCharacterEncoding("UTF-8");
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            int grade = Integer.valueOf(request.getParameter("grade"));
            String birthday = request.getParameter("birthday");
            String address = request.getParameter("address");
            String notes = request.getParameter("notes");
            Date birthday2 = Date.valueOf(birthday);
            Student student = new Student(id, name, grade, birthday2, address, notes);
            DAOStudent.getInstance().insert(student);
            
            response.sendRedirect("/student-management/student-list");
        %>
    </head>
    <body>
    </body>
</html>
