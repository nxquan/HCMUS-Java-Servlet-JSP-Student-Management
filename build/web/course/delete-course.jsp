
<%@page import="DAO.DAOCourse"%>
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
            String id = request.getParameter("course-id");
            DAOCourse.getInstance().delete(id);
            response.sendRedirect("/student-management/course-list");
        %>
    </body>
</html>
