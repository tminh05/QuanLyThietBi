<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.HoaDonDAO, model.HoaDon, java.util.List, java.text.DecimalFormat, java.text.SimpleDateFormat"%>
<%
    if(session.getAttribute("adminUser") == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đơn hàng</title>
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
            <a href="ql_nhom.jsp"><i class="fa-solid fa-tags me-2"></i>Quản lý Nhóm</a>
            <a href="ql_donhang.jsp" class="active"><i class="fa-solid fa-cart-shopping me-2"></i>Đơn hàng</a>
            <a href="logout.jsp" class="text-danger mt-5 border-top border-secondary"><i class="fa-solid fa-right-from-bracket me-2"></i>Đăng xuất</a>
        </div>

        <div class="flex-grow-1 p-4 bg-light">
            <h3 class="mb-4 text-dark">Danh sách Đơn đặt hàng</h3>

            <% String msg = (String) session.getAttribute("message"); if (msg != null) { %>
                <div class="alert alert-info alert-dismissible fade show">
                    <i class="fa-solid fa-bell me-2"></i> <%= msg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% session.removeAttribute("message"); } %>

            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <table class="table table-hover table-striped align-middle m-0">
                        <thead class="table-dark">
                            <tr>
                                <th class="ps-3">Mã ĐH</th>
                                <th>Khách hàng</th>
                                <th>Số điện thoại</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<HoaDon> list = new HoaDonDAO().getAllHoaDon();
                                DecimalFormat df = new DecimalFormat("#,###");
                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                                
                                for (HoaDon hd : list) {
                                    String badge = "bg-secondary"; String text = "Chờ duyệt";
                                    if(hd.getTrangThai()==1) { badge = "bg-primary"; text = "Đang giao"; }
                                    else if(hd.getTrangThai()==2) { badge = "bg-success"; text = "Đã giao xong"; }
                                    else if(hd.getTrangThai()==3) { badge = "bg-danger"; text = "Đã hủy"; }
                            %>
                            <tr>
                                <td class="ps-3 fw-bold">#<%= hd.getMaHD() %></td>
                                <td class="fw-semibold"><%= hd.getTenKhach() %></td>
                                <td><%= hd.getSoDienThoai() %></td>
                                <td><%= (hd.getNgayDat()!=null) ? sdf.format(hd.getNgayDat()) : "" %></td>
                                <td class="text-danger fw-bold"><%= df.format(hd.getTongTien()) %> đ</td>
                                <td><span class="badge <%= badge %>"><%= text %></span></td>
                                <td class="text-center">
                                    <% if(hd.getTrangThai() == 0) { %>
                                        <a href="xuly_donhang.jsp?id=<%= hd.getMaHD() %>&stt=1" class="btn btn-sm btn-info text-white" title="Duyệt & Giao hàng"><i class="fa-solid fa-truck"></i> Giao</a>
                                        <a href="xuly_donhang.jsp?id=<%= hd.getMaHD() %>&stt=3" class="btn btn-sm btn-danger" onclick="return confirm('Bạn muốn hủy đơn này?');" title="Hủy đơn"><i class="fa-solid fa-xmark"></i> Hủy</a>
                                    <% } else if(hd.getTrangThai() == 1) { %>
                                        <a href="xuly_donhang.jsp?id=<%= hd.getMaHD() %>&stt=2" class="btn btn-sm btn-success" title="Xác nhận giao thành công"><i class="fa-solid fa-check-double"></i> Hoàn tất</a>
                                    <% } else { %>
                                        <span class="text-muted"><i class="fa-solid fa-lock"></i> Đã đóng</span>
                                    <% } %>
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