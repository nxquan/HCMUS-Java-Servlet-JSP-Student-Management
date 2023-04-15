<%@page import="model.Student"%>
<%@page import="DAO.DAOStudent"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chỉnh sửa học sinh</title>
        <%@include file="../styles-fonts.jsp" %>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            String id = request.getParameter("id");
            Student editedStudent = DAOStudent.getInstance().selectById(id);
        %>

        <div class="container-fluid">
            <div class="container">
                <div class="content">
                    <h3 class="content-item-heading">Chỉnh sửa học sinh</h3>
                    <form class="form-edit" action="/student-management/student-list" method="POST">
                        <div class="form-group">
                            <label for="form-input" class="form-label">Mã số: </label>
                            <input name="id" required id="form-input" class="form-input" type="text" value="<%=editedStudent.getId()%>" readonly/>
                        </div>
                        <div class="form-group">
                            <label for="form-input" class="form-label">Họ tên: </label>
                            <input name="name" required id="form-input" class="form-input" type="text" value="<%=editedStudent.getName()%>" />
                        </div>
                        <div class="form-group">
                            <label for="form-input" class="form-label">Điểm số: </label>
                            <input name="grade" id="form-input" class="form-input" min="0" max="12" type="number" value="<%=editedStudent.getGrade()%>" />
                        </div>
                        <div class="form-group">
                            <label for="form-input" class="form-label">Ngày sinh: </label>
                            <input name="birthday" required id="form-input" class="form-input" type="date" value="<%=editedStudent.getBirthday()%>" />
                        </div>
                        <div class="form-group ml-0 mt-12">
                            <label for="form-input" class="form-label ml-12">Địa chỉ: </label>
                            <input name="address" id="form-input" class="form-input" type="text" value="<%=editedStudent.getAddress()%>" />
                        </div>
                        <div class="form-group mt-12 ml-0">
                            <label for="form-input" class="form-label ">Ghi chú: </label>
                            <input name="notes" id="form-input" class="form-input" type="text" value="<%=editedStudent.getNotes()%>" />
                        </div>
                        <button class="add-btn ml-24">Chỉnh sửa</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
