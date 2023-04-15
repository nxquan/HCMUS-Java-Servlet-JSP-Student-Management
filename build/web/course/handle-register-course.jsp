<%@page import="DAO.DAOEnrollmentCourse"%>
<%@page import="model.EnrollmentCourse"%>
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
            String studentId = request.getParameter("studentId");
            String courseId = request.getParameter("courseId");
            double score = Double.parseDouble(request.getParameter("score"));
            
            EnrollmentCourse enrollCourse = new EnrollmentCourse(studentId, courseId, score);
            
            DAOEnrollmentCourse.getInstance().insert(enrollCourse);
            
            response.sendRedirect("/student-management/course/register-course.jsp?course-id=" + courseId);
        %>
    </body>
</html>
