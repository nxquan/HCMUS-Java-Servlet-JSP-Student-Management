<%@page import="DAO.DAOEnrollmentCourse"%>
<%@page import="model.EnrollmentCourse"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Student"%>
<%@page import="DAO.DAOStudent"%>
<%@page import="model.Course"%>
<%@page import="DAO.DAOCourse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang đăng ký khóa học</title>
        <%@include file="../styles-fonts.jsp" %>
    </head>

    <%
        //Reading students who don't register this course
        String courseId = request.getParameter("course-id");
        Course course = DAOCourse.getInstance().selectById(courseId);
        String condition = "NOT EXISTS("
                + " SELECT * FROM enroll_course"
                + " WHERE enroll_course.studentId = student.id AND enroll_course.courseId = '" + course.getId() + "')";
        ArrayList<Student> unregisterStudent = DAOStudent.getInstance().selectByGivenCondition(condition);
    %>

    <%
        //Reading the list of students who registerd this course
        //Query from 2 table to get data: enroll_course + student
        String conditionForGetRegisterStudent = "EXISTS("
                + " SELECT * FROM enroll_course"
                + " WHERE enroll_course.studentId = student.id AND enroll_course.courseId = '" + course.getId() + "')";
        ArrayList<Student> registeredStudent = DAOStudent.getInstance().selectByGivenCondition(conditionForGetRegisterStudent);

        String conditionForGetScore = "courseId='" + courseId + "'";
        ArrayList<EnrollmentCourse> enrollmentCourses = DAOEnrollmentCourse.getInstance().selectByGivenCondition(conditionForGetScore);
    %>

    <script>
        function confirmDelete(name, courseId, studentId) {
            var result = confirm("Bạn chắc chắn muốn xóa Học sinh " + name + " này ra khỏi khóa học?");
            if (result) {
                window.location.href = "<%= request.getContextPath()%>/course/unregister-course.jsp?course-id=" + courseId + "&student-id=" + studentId ;
            } else {
                return false;
            }
        }

    </script>


    <body>
        <div class="container-fluid">
            <div class="container">
                <%@include file="../sidebar.jsp"%>
                <div class="content">
                    <h2 class="content-title">Thêm học sinh vào khóa học</h2>
                    <div class="content-inner mt-12">
                        <div class="content-item">
                            <p class="course-item"> <span class="course-heading" style="font-size: 1.8rem; font-weight: 700; color: #3551de">Thông tin khóa học</p>
                            <p class="course-item"> <span class="course-heading">- Khóa học: </span><span class="course-info"><%=course.getName()%></span></p>
                            <p class="course-item"> <span class="course-heading">- Người dạy: </span><span class="course-info"><%=course.getLecture()%></span></p>
                            <p class="course-item"> <span class="course-heading">- Năm: </span><span class="course-info"><%=course.getYear()%></span></p>
                            <form class="form-adding mt-12" action="<%= request.getContextPath()%>/course/handle-register-course.jsp" method="POST">
                                <div class="form-group">
                                    <label for="form-input" class="form-label">Học sinh:</label>
                                    <input name="courseId" value="<%=courseId%>" hidden/>
                                    <input style="min-width: 300px;" name="studentId" list="student-list" required id="form-input" class="form-input" type="text" 
                                           <% if (unregisterStudent.size() == 0) { %>
                                           readonly title="Chưa có học sinh nào để đăng ký"
                                           placeholder="Chưa có học sinh nào để đăng ký"
                                           <%}%>
                                           />
                                    <datalist id="student-list">
                                        <% for (Student student : unregisterStudent) {%>
                                        <option value="<%= student.getId()%>"><%= student.getId()%> - <%= student.getName()%></option>
                                        <%}%>
                                    </datalist>
                                </div>
                                <div class="form-group">
                                    <label for="form-input" class="form-label">Điểm: </label>
                                    <input name="score" required id="form-input" class="form-input" min="0" max="10" type="number" step="0.01" />
                                </div>

                                <button class="add-btn ml-24">Thêm</button>
                            </form>
                        </div>

                        <div class="content-item">
                            <h3 class="content-item-heading">Danh sách học sinh đang học</h3>
                            <table class="content-table" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th style="width: 12.5%;">Mã học sinh</th>
                                        <th style="width: 25%">Họ tên</th>
                                        <th style="width: 10%">Khối</th>
                                        <th style="width: 12.5%">Ngày sinh</th>
                                        <th style="width: 5%; text-align: center;">Điểm</th>
                                        <th style="width: 5%">Lựa chọn</th>
                                    </tr>
                                </thead>

                                <% for (Student student : registeredStudent) {%>
                                <tr>
                                    <td><%=student.getId()%></td>
                                    <td><%=student.getName()%></td>
                                    <td><%=student.getGrade()%></td>
                                    <td><%=student.getBirthday()%></td>
                                    <%for (EnrollmentCourse enroll : enrollmentCourses) {
                                            if (enroll.getStudentId().equals(student.getId())) {%>
                                    <td style="text-align: center;"><%= enroll.getScore()%></td>
                                    <% break;
                                            }
                                        }%>

                                    <td style="text-align: center;">
                                        <a class="detail-btn"
                                           onclick="return confirmDelete('<%=student.getName()%>', '<%=courseId%>', '<%=student.getId()%>')"
                                           >
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</body>
</html>
