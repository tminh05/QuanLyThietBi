<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.UserDAO, model.User"%>
<%
    request.setCharacterEncoding("UTF-8");
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        User u = new User(0, request.getParameter("username"), request.getParameter("password"),
                          request.getParameter("hoten"), request.getParameter("sdt"), request.getParameter("diachi"), 0);
        
        UserDAO dao = new UserDAO();
        if (dao.checkExist(u.getTenDangNhap())) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
        } else {
            if (dao.register(u)) {
                out.println("<script>alert('Đăng ký thành công! Vui lòng đăng nhập.'); window.location.href='dangnhap.jsp';</script>");
                return;
            } else {
                request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại sau!");
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light py-5">
    <div class="container d-flex justify-content-center">
        <div class="card p-4 shadow" style="width: 500px;">
            <h3 class="text-center text-success mb-4">ĐĂNG KÝ THÀNH VIÊN</h3>
            <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-danger py-2"><%= request.getAttribute("error") %></div>
            <% } %>
            <form method="post">
                <div class="mb-3"><label>Tên đăng nhập (*)</label><input type="text" name="username" class="form-control" required></div>
                <div class="mb-3"><label>Mật khẩu (*)</label><input type="password" name="password" class="form-control" required></div>
                <div class="mb-3"><label>Họ và tên (*)</label><input type="text" name="hoten" class="form-control" required></div>
                <div class="mb-3"><label>Số điện thoại (*)</label><input type="text" name="sdt" class="form-control" required></div>
                <div class="mb-3"><label>Địa chỉ</label><textarea name="diachi" class="form-control"></textarea></div>
                
                <button type="submit" class="btn btn-success w-100 fw-bold">ĐĂNG KÝ TÀI KHOẢN</button>
            </form>
            <div class="text-center mt-3">
                Đã có tài khoản? <a href="dangnhap.jsp">Đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>