<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User, dao.UserDAO"%>
<%
    // 1. Kiểm tra xem người dùng đã đăng nhập chưa
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("dangnhap.jsp");
        return;
    }

    String msg = "";
    String color = "#ff4d4d"; // Mặc định màu đỏ cho lỗi
    
    // 2. Xử lý logic khi người dùng nhấn nút cập nhật
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String inputUser = request.getParameter("username"); // Lấy tên đăng nhập nhập vào
        String oldP = request.getParameter("oldPass");
        String newP = request.getParameter("newPass");
        String confirmP = request.getParameter("confirmPass");
        
        // Kiểm tra xem các trường có trống không
        if (inputUser == null || oldP == null || newP == null || inputUser.isEmpty() || oldP.isEmpty() || newP.isEmpty()) {
            msg = "Vui lòng nhập đầy đủ thông tin!";
        } 
        // Kiểm tra tên đăng nhập có khớp với tài khoản đang login không
        else if (!inputUser.equals(loggedInUser.getTenDangNhap())) {
            msg = "Tên đăng nhập không chính xác!";
        }
        // Kiểm tra mật khẩu mới và xác nhận
        else if (!newP.equals(confirmP)) {
            msg = "Mật khẩu xác nhận không khớp!";
        } 
        else {
            UserDAO dao = new UserDAO();
            // Gọi hàm changePassword đã cập nhật (yêu cầu truyền username, pass cũ, pass mới)
            if (dao.changePassword(loggedInUser.getTenDangNhap(), inputUser, oldP, newP)) {
                msg = "Chúc mừng! Đổi mật khẩu thành công.";
                color = "#2ecc71";
            } else {
                msg = "Mật khẩu hiện tại không chính xác!";
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Xác thực bảo mật - NTMINH CENTER</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .change-pass-card {
            background: rgba(255, 255, 255, 0.98);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            width: 420px;
            text-align: center;
        }

        h2 {
            color: #764ba2;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        p.subtitle {
            color: #777;
            font-size: 13px;
            margin-bottom: 25px;
        }

        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .input-group label {
            display: block;
            font-size: 12px;
            color: #555;
            margin-bottom: 5px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .input-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            outline: none;
            transition: 0.3s;
            background: #fdfdfd;
        }

        .input-group input:focus {
            border-color: #ff9933;
            box-shadow: 0 0 8px rgba(255, 153, 51, 0.2);
            background: #fff;
        }

        .btn-update {
            width: 100%;
            padding: 14px;
            background: #ff9933;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
            letter-spacing: 1px;
        }

        .btn-update:hover {
            background: #e68a00;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 153, 51, 0.4);
        }

        .message {
            margin-bottom: 20px;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            text-decoration: none;
            color: #764ba2;
            font-size: 14px;
            font-weight: bold;
            transition: 0.3s;
        }

        .back-link:hover {
            color: #ff9933;
            transform: translateX(-5px);
        }
    </style>
</head>
<body>

    <div class="change-pass-card">
        <h2>BẢO MẬT TÀI KHOẢN</h2>
        <p class="subtitle">Vui lòng xác thực thông tin để thay đổi mật khẩu</p>

        <% if (!msg.isEmpty()) { %>
            <div class="message" style="background: <%= color %>15; color: <%= color %>; border: 1px solid <%= color %>44;">
                <%= msg %>
            </div>
        <% } %>

        <form action="doimatkhau.jsp" method="POST">
            <div class="input-group">
                <label>Tên đăng nhập</label>
                <input type="text" name="username" placeholder="Nhập lại username để xác minh" required>
            </div>

            <div class="input-group">
                <label>Mật khẩu hiện tại</label>
                <input type="password" name="oldPass" placeholder="••••••••" required>
            </div>

            <div class="input-group">
                <label>Mật khẩu mới</label>
                <input type="password" name="newPass" placeholder="••••••••" required>
            </div>

            <div class="input-group">
                <label>Xác nhận mật khẩu mới</label>
                <input type="password" name="confirmPass" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn-update">XÁC NHẬN CẬP NHẬT</button>
        </form>

        <a href="index.jsp" class="back-link">← Quay lại trang cửa hàng</a>
    </div>

</body>
</html>