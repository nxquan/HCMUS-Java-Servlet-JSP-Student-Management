<%@page import="model.Student"%>
<%@page import="DAO.DAOStudent"%>
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
            DAOStudent.getInstance().delete(id);
            response.sendRedirect("/student-management/student-list");
        %>
    </body>
</html>
