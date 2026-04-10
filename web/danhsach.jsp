<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.*, model.*, java.util.List, java.text.DecimalFormat"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    // LẤY THÔNG TIN USER TỪ SESSION
    User loggedInUser = (User) session.getAttribute("user");

    String keyword = request.getParameter("keyword");
    String minStr = request.getParameter("min");
    String maxStr = request.getParameter("max");
    String maNhomStr = request.getParameter("manhom");

    keyword = (keyword != null) ? keyword.trim() : "";
    long minPrice = (minStr != null && !minStr.isEmpty()) ? Long.parseLong(minStr) : 0;
    long maxPrice = (maxStr != null && !maxStr.isEmpty()) ? Long.parseLong(maxStr) : 0;
    int maNhomSelected = (maNhomStr != null && !maNhomStr.isEmpty()) ? Integer.parseInt(maNhomStr) : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh sách thiết bị - NTMINH</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f4f4f4; line-height: 1.6; }
        
        /* Header */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 15px 40px; display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); color: white;
        }
        .header-logo { text-decoration: none; color: white; }
        .header-right { display: flex; align-items: center; gap: 20px; }
        .user-info { font-size: 14px; display: flex; align-items: center; gap: 10px; }
        .user-info b { color: #ff9933; }
        
        .btn-auth { color: white; text-decoration: none; font-weight: bold; font-size: 14px; transition: 0.3s; }
        .btn-auth:hover { color: #ff9933; }

        .search-box { display: flex; gap: 8px; }
        .search-box input { padding: 8px; width: 280px; border-radius: 4px; border: none; outline: none; }
        .search-box button { padding: 8px 15px; background: #ff9933; color: white; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }

        .btn-cart { color: white; font-weight: bold; text-decoration: none; border: 2px solid white; padding: 8px 18px; border-radius: 30px; transition: 0.3s; }
        .btn-cart:hover { background: white; color: #764ba2; }

        /* Container & Sidebar */
        .container { display: flex; min-height: 600px; max-width: 1400px; margin: 20px auto; gap: 20px; padding: 0 20px; }
        .sidebar { width: 280px; background-color: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); height: fit-content; }
        .sidebar h3 { background-color: #ff9933; color: white; padding: 12px; margin-bottom: 20px; text-align: center; border-radius: 6px; font-size: 16px; }
        .sidebar ul { list-style: none; }
        .sidebar ul li a { display: block; padding: 12px; background-color: #f9f9f9; color: #444; text-decoration: none; border-left: 4px solid transparent; margin-bottom: 8px; border-radius: 4px; transition: 0.3s; }
        .sidebar ul li a:hover, .sidebar ul li a.active { border-left-color: #ff9933; background-color: #fff5eb; color: #ff9933; padding-left: 15px; }
        
        .filter-price { margin-top: 30px; padding-top: 25px; border-top: 2px dashed #eee; }
        .filter-price h4 { margin-bottom: 15px; color: #333; font-size: 16px; text-transform: uppercase; }
        .filter-price input { width: 100%; padding: 12px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 6px; }
        .filter-price button { width: 100%; padding: 12px; background: #28a745; color: white; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; }

        /* Product Grid */
        .content { flex: 1; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 25px; }
        .product-item { position: relative; border: 1px solid #eee; padding: 20px; text-align: center; background-color: #fff; border-radius: 12px; transition: 0.4s; height: 400px; display: flex; flex-direction: column; z-index: 1; }
        .product-item:hover { transform: scale(1.05); box-shadow: 0 15px 35px rgba(0,0,0,0.15); height: auto; min-height: 400px; z-index: 100; border-color: #ff9933; }
        .product-item img { width: 100%; height: 200px; object-fit: contain; margin-bottom: 15px; }
        .product-item h4 { color: #222; margin: 10px 0; font-size: 15px; height: 45px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
        .product-item:hover h4 { height: auto; display: block; overflow: visible; -webkit-line-clamp: unset; color: #ff9933; }
        .price { color: #d0021b; font-weight: bold; font-size: 20px; margin: 10px 0; }
        .btn-actions { margin-top: auto; display: flex; flex-direction: column; gap: 8px;}
        .btn-detail { padding: 10px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 6px; font-size: 13px; }
        .btn-add-cart { padding: 12px; background-color: #ff9933; color: white; text-decoration: none; border-radius: 6px; font-weight: bold; }

        /* Footer */
        .footer { background-color: #2c3e50; color: #ecf0f1; padding: 50px 20px; text-align: center; border-top: 5px solid #ff9933; margin-top: 60px; }
        .footer-contact { display: flex; justify-content: center; gap: 30px; font-size: 14px; flex-wrap: wrap; margin-top: 20px; }
        .contact-item { display: inline-flex; align-items: center; gap: 8px; color: #bdc3c7; text-decoration: none; transition: 0.3s; }
        .contact-item:hover { color: #ff9933; transform: translateY(-5px); }
    </style>
</head>
<body>
    <div class="header">
        <a href="index.jsp" class="header-logo">
            <h1 style="font-size: 26px; text-transform: uppercase; font-weight: 900;">NTMINH CENTER</h1>
        </a>

        <form action="danhsach.jsp" method="get" class="search-box">
            <input type="text" name="keyword" placeholder="Tìm kiếm linh kiện..." value="<%= keyword %>">
            <button type="submit">Tìm kiếm</button>
        </form>

        <div class="header-right">
            <% if (loggedInUser != null) { %>
                <div class="user-info">
                    <span>Chào, <b><%= loggedInUser.getHoTen() %></b></span>
                    <a href="doimatkhau.jsp" class="btn-auth" style="margin-left: 10px; color: #ffc107" >[Đổi mật khẩu]</a>
                    <a href="logout.jsp" class="btn-auth" style="color: #ffc107;">[Đăng xuất]</a>
                </div>
            <% } else { %>
                <a href="dangnhap.jsp" class="btn-auth">Đăng nhập</a>
            <% } %>

            <a href="giohang.jsp" class="btn-cart">🛒 Giỏ hàng</a>
        </div>
    </div>
    
    <div class="container">
        <div class="sidebar">
            <h3>DANH MỤC THIẾT BỊ</h3>
            <ul>
                <li><a href="danhsach.jsp" class="<%= (maNhomSelected == 0) ? "active" : "" %>">Tất cả sản phẩm</a></li>
                <%
                    NhomDAO nhomDAO = new NhomDAO();
                    List<Nhom> listNhom = nhomDAO.getAllNhom();
                    for (Nhom nhom : listNhom) {
                %>
                <li><a href="danhsach.jsp?manhom=<%= nhom.getMaNhom() %>" class="<%= (nhom.getMaNhom() == maNhomSelected) ? "active" : "" %>"><%= nhom.getTenNhom() %></a></li>
                <% } %>
            </ul>
            <div class="filter-price">
                <h4>Lọc theo giá</h4>
                <form action="danhsach.jsp" method="get">
                    <input type="hidden" name="keyword" value="<%= keyword %>">
                    <input type="hidden" name="manhom" value="<%= maNhomSelected %>">
                    <input type="number" name="min" placeholder="Từ (VNĐ)" value="<%= (minPrice > 0) ? minPrice : "" %>">
                    <input type="number" name="max" placeholder="Đến (VNĐ)" value="<%= (maxPrice > 0) ? maxPrice : "" %>">
                    <button type="submit">ÁP DỤNG</button>
                </form>
            </div>
        </div>

        <div class="content">
            <div class="product-grid">
                <%
                    ThietBiDAO thietBiDAO = new ThietBiDAO();
                    List<ThietBi> listThietBi = thietBiDAO.searchAndFilter(keyword, minPrice, maxPrice, maNhomSelected);
                    DecimalFormat formatter = new DecimalFormat("#,###");
                    for (ThietBi tb : listThietBi) {
                %>
                <div class="product-item">
                    <img src="images/<%= tb.getHinhAnh() %>" onerror="this.src='images/no-image.png'">
                    <h4><%= tb.getTenThietBi() %></h4>
                    <p class="price"><%= formatter.format(tb.getDonGia()) %> đ</p>
                    <div class="btn-actions">
                        <a href="chitiet.jsp?mathietbi=<%= tb.getMaThietBi() %>" class="btn-detail">Xem chi tiết</a>
                        <a href="xuly_giohang.jsp?action=add&mathietbi=<%= tb.getMaThietBi() %>" class="btn-add-cart">🛒 Thêm vào giỏ</a>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-content">
            <p style="font-size: 20px; text-transform: uppercase; margin-bottom: 15px;"><strong>HỆ THỐNG QUẢN LÝ CỬA HÀNG LINH KIỆN MÁY TÍNH</strong></p>
            <p style="margin-bottom: 25px;">Được thiết kế & phát triển bởi: <b>Nguyễn Trọng Minh</b></p>
            <div class="footer-contact">
                <a href="mailto:minhndfgh05@gmail.com" class="contact-item"><span>📧</span> minhndfgh05@gmail.com</a>
                <a href="tel:0963760551" class="contact-item"><span>📞</span> 0963 760 551</a>
                <span class="contact-item"><span>📍</span> 48 Cao Thắng, TP.Đà Nẵng</span>
            </div>
        </div>
    </footer>
</body>
</html>