<%@page import="DAO.DAOEnrollmentCourse"%>
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
            String studentId = request.getParameter("student-id");
            String courseId = request.getParameter("course-id");
            
            DAOEnrollmentCourse.getInstance().delete(studentId, courseId);
            response.sendRedirect("/student-management/course/register-course.jsp?course-id=" + courseId);
        %>
        
    </body>
</html>
