<%@page import="java.time.LocalDate"%>
<%@page import="model.Student"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.DAOStudent"%>
<%@page import="db.JDBCUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang học sinh</title>
        <%@include file="./styles-fonts.jsp" %>
        <% String keyword = (String) request.getAttribute("search-keyword");%>
        <% String sortBy = (String) request.getAttribute("sort-by");
            if (sortBy == null)
                sortBy = "";
        %>


        <script>
            function confirmDelete(name, id) {
                var result = confirm("Bạn chắc chắn muốn xóa học sinh " + name + '\n(Trong trường hợp  học sinh này đã đăng ký khóa học thì sẽ không xóa được. \n=> Vui lòng xóa đăng ký trước)');
                if (result) {
                    window.location.href= "<%= request.getContextPath()%>/student/delete-student.jsp?id=" +id;
                } else {
                    return false;
                }
            }

        </script>
    </head>
    <body>

        <div class="container-fluid">
            <div class="container">
                <%@include file="./sidebar.jsp"%>
                <div class="content">
                    <h2 class="content-title">
                        Học sinh
                    </h2>
                    <div class="content-inner">
                        <div class="content-item">
                            <h3 class="content-item-heading">Thêm học sinh</h3>
                            <form class="form-adding" action="<%= request.getContextPath()%>/student/create-student.jsp" method="POST">
                                <div class="form-group">
                                    <label for="form-input" class="form-label">Mã số: </label>
                                    <input name="id" required id="form-input" class="form-input" type="text" />
                                </div>
                                <div class="form-group">
                                    <label for="form-input" class="form-label">Họ tên: </label>
                                    <input name="name" required id="form-input" class="form-input" type="text" />
                                </div>
                                <div class="form-group">
                                    <label for="form-input" class="form-label">Khối: </label>
                                    <input name="grade" id="form-input" class="form-input" min="1" max="12" type="number" value="1" />
                                </div>
                                <div class="form-group">
                                    <label for="form-input" class="form-label">Ngày sinh: </label>
                                    <input name="birthday" required id="form-input" class="form-input" type="date" />
                                </div>
                                <div class="form-group ml-0 mt-12">
                                    <label for="form-input" class="form-label">Địa chỉ: </label>
                                    <input name="address" id="form-input" class="form-input" type="text" value="" />
                                </div>
                                <div class="form-group mt-12">
                                    <label for="form-input" class="form-label ">Ghi chú: </label>
                                    <input name="notes" id="form-input" class="form-input" type="text" value="" />
                                </div>
                                <button class="add-btn ml-24">Thêm</button>
                            </form>
                        </div>
                        <div class="content-item">
                            <h3 class="content-item-heading">Tìm kiếm và sắp xếp</h3>
                            <form class="content-filter" action="/student-management/student-list" method="GET">
                                <div class="form-group">
                                    <label for="form-input" class="form-label ">Tên học sinh: </label>
                                    <input id="form-input" class="form-input" type="text" name="search-keyword"
                                           <%if (keyword != null) {%>
                                           value="<%=keyword%>"
                                           <%}%>
                                           />
                                </div>

                                <div class="form-group">
                                    <label for="form-input" class="form-label ">Sắp xếp theo: </label>
                                    <select id="form-input" class="form-input" name="sort-by">
                                        <option> --Chọn-- </option>
                                        <option value="name-ascending"
                                                <%if (sortBy.equals("name-ascending")) {%>
                                                selected=""
                                                <%}%> 
                                                >Tên - Tăng</option>

                                        <option value="name-descending"
                                                <%if (sortBy.equals("name-descending")) {%>
                                                selected
                                                <%}%>
                                                >Tên - Giảm</option>
                                        <option value="grade-ascending"
                                                <%if (sortBy.equals("grade-ascending")) {%>
                                                selected
                                                <%}%>
                                                >Khối - Tăng</option>
                                        <option value="grade-descending"
                                                <%if (sortBy.equals("grade-descending")) {%>
                                                selected
                                                <%}%>
                                                >Khối - Giảm</option>
                                    </select>
                                </div>

                                <button class="search-btn ml-24">Tìm kiếm</button>
                                <a class="reset-btn ml-24" href="/student-management/student-list">Reset</a>

                            </form>
                        </div>

                        <div class="content-item">
                            <h3 class="content-item-heading">Danh sách học sinh</h3>
                            <table class="content-table" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th style="width: 10%;">Mã số</th>
                                        <th style="width: 20%">Họ tên</th>
                                        <th style="width: 5%">Khối</th>
                                        <th style="width: 10%">Ngày sinh</th>
                                        <th style="width: 20%">Địa chỉ</th>
                                        <th style="width: 20%">Ghi chú</th>
                                        <th style="width: 10%">Lựa chọn</th>
                                    </tr>
                                </thead>
                                <% ArrayList<Student> list = (ArrayList<Student>) (request.getAttribute("list")); %>

                                <% if (list != null && list.size() == 0) {%>
                                <tr><td colspan="7">Danh sách chưa có học sinh</td></tr>
                                <% } else { %>
                                <%for (Student student : list) {%>
                                <tr >
                                    <td><%= student.getId()%></td>
                                    <td><%= student.getName()%></td>
                                    <td><%= student.getGrade()%></td>
                                    <td><%= student.getBirthday()%></td>
                                    <td><%= student.getAddress()%></td>
                                    <td><%= student.getNotes()%></td>

                                    <td>
                                        <a class="detail-btn" href="<%= request.getContextPath()%>/student/detail-student.jsp?id=<%=student.getId()%>&year=<%=LocalDate.now().getYear()%>" >
                                            <i class="fa-solid fa-circle-info"></i>
                                        </a>
                                        <a class="edit-btn ml-12" href="<%= request.getContextPath()%>/student/edit-student.jsp?id=<%=student.getId()%>"
                                           title="Chỉnh sửa học sinh"
                                           >
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <a class="delete-btn ml-12"
                                           title="Xóa học sinh"
                                           onclick="return confirmDelete('<%=student.getName() %>', '<%=student.getId() %>');"
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

            <% request.setCharacterEncoding("UTF-8");%>
    </body>
</html>
