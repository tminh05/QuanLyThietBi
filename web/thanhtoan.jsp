<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, dao.*"%>
<%
    request.setCharacterEncoding("UTF-8");

    // Ép đăng nhập mới được mua
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("dangnhap.jsp");
        return;
    }

    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null || cart.getSize() == 0) {
        response.sendRedirect("giohang.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String ten = request.getParameter("tenKhach");
        String sdt = request.getParameter("soDienThoai");
        String diachi = request.getParameter("diaChi");

        HoaDon hd = new HoaDon(0, ten, sdt, diachi, null, cart.getTotal(), 0);
        HoaDonDAO hdDAO = new HoaDonDAO();
        
        if (hdDAO.thanhToan(hd, cart)) {
            // 1. Xóa Session giỏ hàng
            session.removeAttribute("cart"); 
            
            // 2. Xóa giỏ hàng trong Database để khách không mua trùng
            new GioHangDAO().clearCart(loggedInUser.getMaUser());
            
            out.println("<script>alert('Đặt hàng thành công! Mã đơn hàng của bạn đang được xử lý.'); window.location.href='index.jsp';</script>");
        } else {
            out.println("<script>alert('Có lỗi xảy ra, vui lòng thử lại!');</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh Toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h4 class="m-0">THÔNG TIN GIAO HÀNG</h4>
                    </div>
                    <div class="card-body">
                        <h5 class="text-danger mb-3">Tổng tiền cần thanh toán: <%= new java.text.DecimalFormat("#,###").format(cart.getTotal()) %> đ</h5>
                        <form method="post">
                            <div class="mb-3">
                                <label class="fw-bold">Họ và tên</label>
                                <input type="text" class="form-control" name="tenKhach" value="<%= loggedInUser.getHoTen() != null ? loggedInUser.getHoTen() : "" %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="fw-bold">Số điện thoại</label>
                                <input type="text" class="form-control" name="soDienThoai" value="<%= loggedInUser.getSdt() != null ? loggedInUser.getSdt() : "" %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="fw-bold">Địa chỉ nhận hàng</label>
                                <textarea class="form-control" name="diaChi" rows="3" required><%= loggedInUser.getDiaChi() != null ? loggedInUser.getDiaChi() : "" %></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 fw-bold">XÁC NHẬN ĐẶT HÀNG</button>
                            <a href="giohang.jsp" class="btn btn-secondary w-100 mt-2">Quay lại giỏ hàng</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>