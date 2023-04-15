<%@page import="DAO.DAOEnrollmentCourse"%>
<%@page import="model.EnrollmentCourse"%>
<%@page import="DAO.DAOCourse"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Course"%>
<%@page import="java.time.LocalDate"%>
<%@page import="model.Student"%>
<%@page import="DAO.DAOStudent"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="../styles-fonts.jsp" %>
    </head>

    <%
        int year = Integer.parseInt(request.getParameter("year"));
        String studentId = request.getParameter("id");
        Student currentStudent = DAOStudent.getInstance().selectById(studentId);

        String condition = "course.year=" + year + " AND EXISTS("
                + " SELECT * FROM enroll_course"
                + " WHERE course.id = enroll_course.courseId AND enroll_course.studentId = '" + studentId + "')";
        ArrayList<Course> courses = DAOCourse.getInstance().selectByGivenCondition(condition);

        String enrollCondition = "enroll_course.studentId = '" + studentId + "'"
                + " AND EXISTS"
                + " (SELECT * FROM course "
                + " WHERE enroll_course.courseId = course.id AND YEAR = '" + year + "')";

        ArrayList<EnrollmentCourse> enrollmentCourses = DAOEnrollmentCourse.getInstance().selectByGivenCondition(enrollCondition);

    %>
    <body>
        <div class="container-fluid">
            <div class="container">
                <%@include file="../sidebar.jsp"%>
                <div class="content">
                    <h2 class="content-title">Thông tin chi tiết của học sinh</h2>
                    <div class="content-inner mt-12">
                        <div class="content-item">
                            <p class="course-item"> <span class="course-heading" style="font-size: 1.8rem; font-weight: 700; color: #3551de">Thông tin khóa học</p>
                            <p class="course-item"> <span class="course-heading">- Mã số: </span><span class="course-info"><%=currentStudent.getId()%></span></p>
                            <p class="course-item"> <span class="course-heading">- Họ tên: </span><span class="course-info"><%=currentStudent.getName()%></span></p>
                            <p class="course-item"> <span class="course-heading">- Ngày sinh: </span><span class="course-info"><%=currentStudent.getBirthday()%></span></p>
                        </div>
                        <div class="content-item">
                            <form method="GET" action="<%=request.getContextPath()%>/student/detail-student.jsp" class="form-adding mt-12">
                                <input id="form-input" class="form-input"  name="id" value="<%=studentId%>" hidden />
                                <div class="form-group">
                                    <label for="form-input" class="form-label ">Chọn năm: </label>
                                    <input id="form-input" class="form-input" type="number" name="year" min="1990" max="<%=LocalDate.now().getYear()%>" value="<%=year%>"/>
                                </div>
                                <button class="add-btn ml-24">Tìm kiếm</button>
                            </form>
                        </div>
                        <div class="content-item">
                            <h3 class="content-item-heading">Danh sách khóa học và điểm của học sinh</h3>
                            <table class="content-table" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th style="width: 40%;">Tên khóa học</th>
                                        <th style="width: 30%">Người dạy</th>
                                        <th style="width: 20%; text-align: center;">Năm</th>
                                        <th style="width: 10%; text-align: center;">Điểm</th>
                                    </tr>
                                </thead>

                                <% if (courses.size() == 0) {%>
                                <tr>
                                    <td colspan="3"> Năm <%=year%>, học sinh chưa học khóa học nào! Hãy tìm kiếm các năm khác</td>
                                </tr>
                                <%} else {
                                    for (Course c : courses) {%>
                                <tr>
                                    <td><%= c.getName()%></td>
                                    <td><%= c.getLecture()%></td>
                                    <td><%= c.getYear()%></td>

                                    <% for (EnrollmentCourse er : enrollmentCourses) { %>
                                    <%if (er.getCourseId().equals(c.getId())) {%>
                                    <td style="text-align: center;"><%= er.getScore()%></td>
                                    <%}
                                            }%>    
                                </tr>
                                <%}
                                    }%>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

    </body>
</html>
