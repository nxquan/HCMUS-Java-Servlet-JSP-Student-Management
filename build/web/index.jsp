<%@page import="java.sql.Connection"%>
<%@page import="db.JDBCUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/main.css"/>
        <%@include file="./styles-fonts.jsp" %>
    </head>

    <body>
        <div class="container-fluid">
            <div class="container" style="flex-direction: column">
                <div style="margin: auto;">
                    <a href="/student-management/student-list" style="font-size: 3rem; color: blue;">
                        <i class="fa-solid fa-right-long"></i>
                        Chương trình quản lý học sinh và khóa học</a>
                    <p style="text-align: center; color: red; font-size: 1.2rem; margin-top: 16px">Tôi sẽ xây dựng phần login sau này tại đây!</p>
                </div>
            </div>
        </div>
    </body>
</html>
