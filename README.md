# HCMUS-Java-Servlet-JSP-Student-Management
## Chức năng
1. Quản lý học sinh:
  Thêm / Sửa / Xóa
  Sắp xếp theo Tên / Khối
  Tìm kiếm theo tên
2. Quản lý khóa học
  Thêm / Sửa / Xóa
  Sắp xếp và tìm kiếm theo Tên
  Hiện danh sách học sinh của khóa học
  Thêm / Xóa học sinh trong khóa học
3. Xuất danh sách khóa học của học sinh theo năm
4. Xuất bảng điểm của học sinh theo năm

## Công nghệ
- Source code được viết trên IDE *Netbeans 17*, sử dụng *JDK 19*
- Server xử lý yêu cầu: *Tomcat 8.5.87*
- Sử dụng *Servlet / JSP* để viết giao diện và xử lý logic của trang web
- Database: *MySQL* (cấu hình database lưu trong file JDBCUtil.java thuộc package db)
- Bài tập có sử dụng mô hình *MVC* (model – view – controller) để chia câu trúc code dễ quản lý và *DAO* (Data Access Object) để kết nối với database lấy dữ liệu.

*Lưu ý: * 
- Chương trình chưa hoàn thiện về mặt chức năng ở các version sau sẽ bổ sung dần.
- Vấn đề cấu trúc source sẽ chưa được chặt chẽ cũng sẽ được cải thiện sau.
