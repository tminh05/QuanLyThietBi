<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.NhomDAO, model.Nhom, java.util.List"%>
<%
    if(session.getAttribute("adminUser") == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Nhóm Thiết bị</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .sidebar { min-height: 100vh; background-color: #212529; }
        .sidebar a { color: #adb5bd; text-decoration: none; padding: 15px 20px; display: block; font-weight: 500; }
        .sidebar a:hover, .sidebar a.active { background-color: #0d6efd; color: #fff; }
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
            <a href="ql_thietbi.jsp"><i class="fa-solid fa-desktop me-2"></i>Quản lý Thiết bị</a>
            <a href="ql_nhom.jsp" class="active"><i class="fa-solid fa-tags me-2"></i>Quản lý Nhóm</a>
            <a href="ql_donhang.jsp"><i class="fa-solid fa-cart-shopping me-2"></i>Đơn hàng</a>
            <a href="logout.jsp" class="text-danger mt-5 border-top border-secondary"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a>
        </div>

        <div class="flex-grow-1 p-4 bg-light">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="m-0 text-dark">Danh sách Nhóm thiết bị</h3>
                <a href="form_nhom.jsp" class="btn btn-success"><i class="fa-solid fa-plus me-1"></i> Thêm nhóm mới</a>
            </div>

            <% String msg = (String) session.getAttribute("message"); if (msg != null) { %>
                <div class="alert alert-success alert-dismissible fade show">
                    <i class="fa-solid fa-circle-check me-2"></i> <%= msg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% session.removeAttribute("message"); } %>

            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <table class="table table-hover table-striped m-0">
                        <thead class="table-dark">
                            <tr><th class="ps-3">Mã Nhóm</th><th>Tên Nhóm</th><th class="text-center">Thao tác</th></tr>
                        </thead>
                        <tbody>
                            <%
                                List<Nhom> list = new NhomDAO().getAllNhom();
                                for (Nhom n : list) {
                            %>
                            <tr>
                                <td class="ps-3 fw-bold">#<%= n.getMaNhom() %></td>
                                <td class="fw-semibold"><%= n.getTenNhom() %></td>
                                <td class="text-center">
                                    <a href="form_nhom.jsp?id=<%= n.getMaNhom() %>" class="btn btn-sm btn-warning"><i class="fa-solid fa-pen-to-square"></i></a>
                                    <a href="xuly_nhom.jsp?action=delete&id=<%= n.getMaNhom() %>" class="btn btn-sm btn-danger" onclick="return confirm('Xóa nhóm này có thể làm lỗi các thiết bị thuộc nhóm. Bạn chắc chứ?');"><i class="fa-solid fa-trash"></i></a>
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