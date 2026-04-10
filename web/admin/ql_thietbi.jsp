<%
    // Kiểm tra nếu chưa đăng nhập thì đuổi về trang login
    if(session.getAttribute("adminUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.ThietBiDAO"%>
<%@page import="model.ThietBi"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Thiết bị</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .sidebar { min-height: 100vh; background-color: #212529; }
        .sidebar a { color: #adb5bd; text-decoration: none; padding: 15px 20px; display: block; font-weight: 500; }
        .sidebar a:hover, .sidebar a.active { background-color: #0d6efd; color: #fff; }
        .content { padding: 30px; background-color: #f8f9fa; width: 100%; }
        .table-image { width: 60px; height: 60px; object-fit: contain; background: #fff; border-radius: 5px; padding: 2px; border: 1px solid #dee2e6; }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark bg-dark px-3">
        <a class="navbar-brand fw-bold" href="index.jsp"><i class="fa-solid fa-microchip me-2"></i>ADMIN DASHBOARD</a>
        <a href="../index.jsp" class="btn btn-outline-warning btn-sm"><i class="fa-solid fa-shop me-1"></i>Xem Website</a>
    </nav>

    <div class="d-flex">
        <div class="sidebar w-25" style="max-width: 250px;">
            <a href="index.jsp">Trang chủ</a>
            <a href="ql_thietbi.jsp" class="active"><i class="fa-solid fa-desktop me-2"></i>Quản lý Thiết bị</a>
            <a href="ql_nhom.jsp"><i class="fa-solid fa-tags me-2"></i>Quản lý Nhóm</a>
            <a href="ql_donhang.jsp"><i class="fa-solid fa-cart-shopping me-2"></i>Đơn hàng</a>
            <a href="logout.jsp" class="text-danger mt-5 border-top border-secondary"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a>
        </div>

        <div class="content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="m-0 text-dark">Danh sách Thiết bị</h3>
                <a href="form_thietbi.jsp" class="btn btn-success"><i class="fa-solid fa-plus me-1"></i> Thêm mới</a>
            </div>

            <%
                String msg = (String) session.getAttribute("message");
                if (msg != null) {
            %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fa-solid fa-circle-check me-2"></i> <%= msg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                    session.removeAttribute("message"); // Xóa thông báo sau khi hiển thị
                }
            %>

            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <table class="table table-hover table-striped align-middle m-0">
                        <thead class="table-dark">
                            <tr>
                                <th class="ps-3">ID</th>
                                <th>Hình ảnh</th>
                                <th>Tên thiết bị</th>
                                <th>Đơn giá</th>
                                <th>Kho</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ThietBiDAO dao = new ThietBiDAO();
                                List<ThietBi> list = dao.getAllThietBi();
                                DecimalFormat df = new DecimalFormat("#,###");
                                for (ThietBi tb : list) {
                            %>
                            <tr>
                                <td class="ps-3 fw-bold">#<%= tb.getMaThietBi() %></td>
                                <td>
                                    <img src="../images/<%= tb.getHinhAnh() %>" class="table-image" 
                                         onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%2260%22 height=%2260%22%3E%3Crect width=%2260%22 height=%2260%22 fill=%22%23eee%22/%3E%3Ctext x=%2250%25%22 y=%2250%25%22 font-size=%2210%22 fill=%22%23999%22 text-anchor=%22middle%22 dy=%22.3em%22%3ENo Image%3C/text%3E%3C/svg%3E'">
                                </td>
                                <td class="fw-semibold"><%= tb.getTenThietBi() %></td>
                                <td class="text-danger fw-bold"><%= df.format(tb.getDonGia()) %> ₫</td>
                                <td>
                                    <span class="badge <%= (tb.getSoLuong() > 0) ? "bg-primary" : "bg-danger" %>">
                                        <%= tb.getSoLuong() %> <%= tb.getDonViTinh() %>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="form_thietbi.jsp?id=<%= tb.getMaThietBi() %>" class="btn btn-sm btn-warning">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <a href="xuly_thietbi.jsp?action=delete&id=<%= tb.getMaThietBi() %>" 
                                       class="btn btn-sm btn-danger" 
                                       onclick="return confirm('Bạn có chắc muốn xóa thiết bị này vĩnh viễn?');">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>