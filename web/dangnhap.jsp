<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.*, model.*, java.util.List"%>
<%
    request.setCharacterEncoding("UTF-8");
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User u = userDAO.login(user, pass);
        
        if (u != null) {
            session.setAttribute("user", u); 
            
            GioHangDAO ghDAO = new GioHangDAO();
            Cart sessionCart = (Cart) session.getAttribute("cart");
            
            // 1. GỘP GIỎ HÀNG: Nếu ở ngoài khách có nhặt đồ -> Nhét vào DB
            if (sessionCart != null && sessionCart.getSize() > 0) {
                for(CartItem item : sessionCart.getItems()) {
                    ghDAO.addToCart(u.getMaUser(), item.getThietBi().getMaThietBi(), item.getSoLuong());
                }
            }
            
            // 2. TẢI GIỎ HÀNG: Quét toàn bộ DB lên lại Session (Đồ cũ + Đồ mới gộp)
            List<CartItem> dbItems = ghDAO.getCartByUser(u.getMaUser());
            Cart finalCart = new Cart();
            for(CartItem item : dbItems) {
                finalCart.addItem(item.getThietBi(), item.getSoLuong());
            }
            session.setAttribute("cart", finalCart); 
            
            response.sendRedirect("index.jsp"); 
            return;
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="card p-4 shadow" style="width: 400px;">
        <h3 class="text-center text-primary mb-4">ĐĂNG NHẬP</h3>
        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-danger py-2"><%= request.getAttribute("error") %></div>
        <% } %>
        <form method="post">
            <div class="mb-3">
                <label class="fw-bold">Tên đăng nhập</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="fw-bold">Mật khẩu</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 fw-bold">ĐĂNG NHẬP</button>
        </form>
        <div class="text-center mt-3">Chưa có tài khoản? <a href="dangky.jsp">Đăng ký ngay</a></div>
        <div class="text-center mt-2"><a href="index.jsp" class="text-muted">Quay lại trang chủ</a></div>
    </div>
</body>
</html>