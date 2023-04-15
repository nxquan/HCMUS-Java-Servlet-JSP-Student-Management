<%@page import="java.time.LocalDate"%>
<%@page import="DAO.DAOCourse"%>
<%@page import="model.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh sửa khóa học</title>
        <%@include file="../styles-fonts.jsp" %>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            String id = request.getParameter("course-id");
            Course editedCourse = DAOCourse.getInstance().selectById(id);
        %>

        <div class="container-fluid">
            <div class="container">
                <div class="content">
                    <h3 class="content-item-heading" style="font-size: 3rem; margin-bottom: 20px">Sửa khóa khóa học</h3>
                    <form class="form-edit" style="display: block" action="<%= request.getContextPath()%>/course-list" method="POST">
                        <div style="display: flex;">
                            <div class="form-group">
                                <label for="form-input" class="form-label">Mã khóa học: </label>
                                <input name="id" value="<%=editedCourse.getId()%>" readonly required id="form-input" class="form-input" type="text" />
                            </div>
                            <div class="form-group">
                                <label for="form-input" class="form-label">Tên khóa học: </label>
                                <input name="name" required id="form-input" class="form-input" type="text" value="<%=editedCourse.getName()%>" />
                            </div>
                            <div class="form-group">
                                <label for="form-input" class="form-label">Tên người dạy:  </label>
                                <input name="lecture" required id="form-input" class="form-input" type="text" value="<%=editedCourse.getLecture()%>"/>
                            </div>
                        </div>
                        <div style="display: flex; margin-top: 12px;">
                            <div class="form-group">
                                <label for="form-input" class="form-label">Năm: </label>
                                <input name="year" required id="form-input" class="form-input" min="1990" max="<%=LocalDate.now().getYear() + 1%>" type="number" value="<%=editedCourse.getYear()%>" />
                            </div>
                            <div class="form-group ">
                                <label for="form-input" class="form-label ">Ghi chú: </label>
                                <input name="notes" id="form-input" class="form-input" type="text" value="<%=editedCourse.getNotes()%>" />
                            </div>
                        </div>
                        <button class="add-btn ml-12 mt-12">Sửa</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
