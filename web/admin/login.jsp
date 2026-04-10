<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập Quản trị</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }
        .login-box { width: 400px; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <div class="login-box">
        <h3 class="text-center mb-4"><i class="fa-solid fa-user-shield me-2"></i>ADMIN LOGIN</h3>
        
        <%
            String error = request.getParameter("error");
            if(error != null) {
        %>
            <div class="alert alert-danger py-2"><i class="fa-solid fa-circle-exclamation me-1"></i> Sai tài khoản hoặc mật khẩu!</div>
        <% } %>

        <form action="xuly_login.jsp" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold">Tên đăng nhập</label>
                <input type="text" class="form-control" name="username" required placeholder="Nhập admin">
            </div>
            <div class="mb-4">
                <label class="form-label fw-bold">Mật khẩu</label>
                <input type="password" class="form-control" name="password" required placeholder="Nhập 123456">
            </div>
            <button type="submit" class="btn btn-primary w-100"><i class="fa-solid fa-right-to-bracket me-1"></i> ĐĂNG NHẬP</button>
            <div class="text-center mt-3">
                <a href="../index.jsp" class="text-decoration-none text-muted"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại cửa hàng</a>
            </div>
        </form>
    </div>
</body>
</html>