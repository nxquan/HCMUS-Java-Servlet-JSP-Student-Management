<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Course"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang khóa học</title>
        <%@include file="./styles-fonts.jsp" %>
    </head>

    <script>
        function confirmDelete(name, id) {
            var result = confirm("Bạn chắc chắn muốn xóa Khóa học " + name + '\n(Trong trường hợp Khóa học này đã đăng ký có Học sinh học thì sẽ không xóa được. \n=> Vui lòng xóa các học sinh trước)');
            if (result) {
                window.location.href = "<%= request.getContextPath()%>/course/delete-course.jsp?course-id=" + id;
            } else {
                return false;
            }
        }

    </script>


    <body>
        <div class="container-fluid">
            <div class="container">
                <%@include file="./sidebar.jsp"%>
                <div class="content">
                    <h2 class="content-title">Khóa học</h2>
                    <div class="content-inner">
                        <div class="content-item">
                            <h3 class="content-item-heading">Thêm khóa học</h3>
                            <form class="form-adding" action="<%= request.getContextPath()%>/course/create-course.jsp" method="POST">
                                <div class="form-group">
                                    <label for="form-input" class="form-label">Mã khóa học: </label>
                                    <input name="id" required id="form-input" class="form-input" type="text" />
                                </div>
                                <div class="form-group">
                                    <label for="form-input" class="form-label">Tên khóa học: </label>
                                    <input name="name" required id="form-input" class="form-input" type="text" />
                                </div>
                                <div class="form-group">
                                    <label for="form-input" class="form-label">Tên người dạy:  </label>
                                    <input name="lecture" required id="form-input" class="form-input" type="text" />
                                </div>
                                <div style="display: flex; margin-top: 12px">
                                    <div class="form-group">
                                        <label for="form-input" class="form-label">Năm: </label>
                                        <input name="year" 
                                               required 
                                               id="form-input" 
                                               class="form-input" 
                                               min="1990" 
                                               max="<%=LocalDate.now().getYear() + 1%>" 
                                               type="number" 
                                               value="<%=LocalDate.now().getYear()%>" />
                                    </div>
                                    <div class="form-group ">
                                        <label for="form-input" class="form-label ">Ghi chú: </label>
                                        <input name="notes" id="form-input" class="form-input" type="text" value="" />
                                    </div>
                                </div>
                                <button class="add-btn ml-24">Thêm</button>
                            </form>

                        </div>
                        <div class="content-item">
                            <h3 class="content-item-heading">Tìm kiếm và sắp xếp</h3>
                            <form class="content-filter" action="/student-management/course-list" method="GET">
                                <div class="form-group">
                                    <label for="form-input" class="form-label ">Tên học sinh: </label>
                                    <input id="form-input" class="form-input" type="text" name="search-keyword"/>
                                </div>

                                <div class="form-group">
                                    <label for="form-input" class="form-label ">Sắp xếp theo: </label>
                                    <select id="form-input" class="form-input" name="sort-by">
                                        <option> --Chọn-- </option>
                                        <option value="name-ascending">Tên - Tăng</option>
                                        <option value="name-descending">Tên - Giảm</option>
                                    </select>
                                </div>

                                <button class="search-btn ml-24">Tìm kiếm</button>
                                <a class="reset-btn ml-24" href="/student-management/course-list">Reset</a>

                            </form>
                        </div>

                        <div class="content-item">
                            <h3 class="content-item-heading">Danh sách khóa học</h3>
                            <table class="content-table" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th style="width: 10%;">Mã khóa học</th>
                                        <th style="width: 20%">Tên khóa học</th>
                                        <th style="width: 15%">Người dạy</th>
                                        <th style="width: 5%">Năm</th>
                                        <th style="width: 15%">Ghi chú</th>
                                        <th style="width: 10%">Lựa chọn</th>
                                    </tr>
                                </thead>

                                <% ArrayList<Course> list = (ArrayList<Course>) (request.getAttribute("list")); %>
                                <% if (list != null && list.size() == 0) {%>
                                <tr><td colspan="7">Danh sách chưa có khóa học nào! Hãy tạo khóa học</td></tr>
                                <% } else if (list != null) { %>
                                <%for (Course c : list) {%>
                                <tr >
                                    <td><%= c.getId()%></td>
                                    <td><%= c.getName()%></td>
                                    <td><%= c.getLecture()%></td>
                                    <td><%= c.getYear()%></td>
                                    <td><%= c.getNotes()%></td>
                                    <td>
                                        <a class="detail-btn" href="<%= request.getContextPath()%>/course/register-course?course-id=<%=c.getId()%>"
                                           title="Thêm học sinh"
                                           >
                                            <i class="fa-solid fa-user-plus"></i>
                                        </a>
                                        <a class="edit-btn ml-12" href="<%= request.getContextPath()%>/course/edit-course.jsp?course-id=<%=c.getId()%>"
                                           title="Chỉnh sửa khóa học"
                                           >
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <a class="delete-btn ml-12""
                                           title="Xóa khóa học"
                                           onclick="return confirmDelete('<%=c.getName()%>', '<%=c.getId() %>')"
                                           >
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
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
