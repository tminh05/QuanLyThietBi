<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = request.getParameter("username");
    String pass = request.getParameter("password");
    
    // Kiểm tra tài khoản
    if("admin".equals(user) && "123456".equals(pass)) {
        // Nếu đúng, tạo session đánh dấu đã đăng nhập
        session.setAttribute("adminUser", user);
        response.sendRedirect("index.jsp");
    } else {
        // Nếu sai, quay lại trang login báo lỗi
        response.sendRedirect("login.jsp?error=1");
    }
%>