<%
    // Kiểm tra nếu chưa đăng nhập thì đuổi về trang login
    if(session.getAttribute("adminUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.HoaDonDAO, java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        .admin-header { background-color: #343a40; color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
        .admin-header a { color: #ffc107; text-decoration: none; font-weight: bold; }
        .admin-container { display: flex; min-height: 100vh; }
        .admin-sidebar { width: 250px; background-color: #212529; padding-top: 20px; }
        .admin-sidebar a { display: block; color: white; padding: 15px 20px; text-decoration: none; border-bottom: 1px solid #343a40; transition: 0.3s; }
        .admin-sidebar a:hover, .admin-sidebar a.active { background-color: #0d6efd; }
        .admin-content { flex: 1; padding: 30px; background-color: #f4f6f9; }
        .card { background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        
        /* CSS THỐNG KÊ */
        .stat-wrapper { display: flex; gap: 20px; margin-bottom: 25px; }
        .stat-item { flex: 1; background: white; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0,0,0,0.1); display: flex; align-items: center; gap: 20px; border-left: 5px solid #28a745; }
        .stat-item.revenue { border-left-color: #ffc107; }
        .stat-icon { font-size: 35px; color: #dee2e6; }
        .stat-label { font-size: 13px; color: #666; text-transform: uppercase; margin-bottom: 5px; font-weight: bold; }
        .stat-value { font-size: 22px; font-weight: bold; color: #333; }

        /* STYLE NÚT ĐĂNG XUẤT GIỐNG HÌNH MẪU */
        .btn-logout { 
            color: #ef4444 !important; /* Màu đỏ rực giống hình */
            font-weight: 500;
            border-top: 1px solid #343a40; 
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .btn-logout i {
            font-size: 18px;
        }
        .btn-logout:hover { 
            background-color: #dc3545 !important; 
            color: white !important; 
        }
    </style>
</head>
<body>
    <div class="admin-header">
        <h2>HỆ THỐNG QUẢN TRỊ</h2>
        <a href="../index.jsp" target="_blank">Xem trang Web</a>
    </div>
    
    <div class="admin-container">
        <div class="admin-sidebar">
            <a href="index.jsp" class="active">Bảng thống kê</a>
            <a href="ql_thietbi.jsp">Quản lý Thiết bị</a>
            <a href="ql_nhom.jsp">Quản lý Nhóm</a>
            <a href="ql_donhang.jsp">Quản lý Đơn hàng</a>
            
            <a href="logout.jsp" class="btn-logout">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </div>
        
        <div class="admin-content">
            <%
                // Khởi tạo DAO và lấy dữ liệu thống kê (Trạng thái = 2 là giao thành công)
                HoaDonDAO hdDAO = new HoaDonDAO();
                int countHD = hdDAO.countHoaDonThanhCong();
                long totalRev = hdDAO.getTotalRevenueThanhCong();
                DecimalFormat df = new DecimalFormat("#,###");
            %>
            
            <div class="stat-wrapper">
                <div class="stat-item">
                    <div class="stat-icon"><i class="fa-solid fa-file-circle-check" style="color: #28a745;"></i></div>
                    <div>
                        <div class="stat-label">Đơn giao thành công</div>
                        <div class="stat-value"><%= countHD %> hóa đơn</div>
                    </div>
                </div>
                <div class="stat-item revenue">
                    <div class="stat-icon"><i class="fa-solid fa-money-bill-trend-up" style="color: #ffc107;"></i></div>
                    <div>
                        <div class="stat-label">Doanh thu</div>
                        <div class="stat-value"><%= df.format(totalRev) %> VNĐ</div>
                    </div>
                </div>
            </div>

            <div class="card">
                <h3>Chào mừng đến với trang quản trị</h3>
                <p style="margin-top: 10px;">Dữ liệu thống kê trên chỉ bao gồm các hóa đơn đã xác nhận <strong>Giao thành công</strong>.</p>
                <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;">
                <p>Trạng thái hệ thống: <span style="color: #28a745; font-weight: bold;">Đang hoạt động</span></p>
            </div>
        </div>
    </div>
</body>
</html>