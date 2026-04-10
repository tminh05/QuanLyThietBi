<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. Xóa thông tin đăng nhập của Quản trị viên (Admin)
    session.removeAttribute("adminUser");
    
    // 2. Hủy toàn bộ phiên làm việc cho an toàn tuyệt đối
    session.invalidate();
    
    // 3. Điều hướng quay lại trang ĐĂNG NHẬP của Admin
    response.sendRedirect("login.jsp");
%>