<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.NhomDAO"%>
<%@page import="dao.ThietBiDAO"%>
<%@page import="model.Nhom"%>
<%@page import="model.ThietBi"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chi tiết thiết bị</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
            text-align: center;
            position: relative; 
        }
        .header img {
            max-width: 400px;
            height: auto;
        }
        .container {
            display: flex;
            min-height: 500px;
        }
        .sidebar {
            width: 250px;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .sidebar h3 {
            background-color: #ff9933;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            text-align: center;
        }
        .sidebar ul {
            list-style: none;
        }
        .sidebar ul li {
            margin-bottom: 10px;
        }
        .sidebar ul li a {
            display: block;
            padding: 10px;
            background-color: white;
            color: #333;
            text-decoration: none;
            border-left: 3px solid #ff9933;
            transition: all 0.3s;
        }
        .sidebar ul li a:hover,
        .sidebar ul li a.active {
            background-color: #ff9933;
            color: white;
            padding-left: 15px;
        }
        .content {
            flex: 1;
            padding: 30px;
            background-color: white;
        }
        .product-detail {
            border: 2px solid #ddd;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .product-detail-content {
            display: flex;
            gap: 30px;
        }
        .product-image {
            flex: 0 0 300px;
        }
        .product-image img {
            width: 100%;
            height: auto;
            border: 1px solid #ddd;
        }
        .product-info {
            flex: 1;
        }
        .product-info h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 20px;
        }
        .product-info .detail-row {
            margin-bottom: 15px;
            line-height: 1.6;
        }
        .product-info .detail-row strong {
            display: inline-block;
            width: 120px;
        }
        .product-info .price {
            color: #ff0000;
            font-size: 20px;
            font-weight: bold;
            margin: 15px 0;
        }
        .quantity-section {
            margin: 20px 0;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .quantity-section label {
            font-weight: bold;
        }
        .quantity-section input {
            width: 80px;
            padding: 8px;
            font-size: 16px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .btn-add-cart {
            padding: 12px 30px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-add-cart:hover {
            background-color: #218838;
        }
        .footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 15px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1 style="color: white; font-size: 40px; margin: 0; text-transform: uppercase;">SHOP BÁN LINH KIỆN MÁY TÍNH - NTMINH</h1>
        <a href="giohang.jsp" style="position: absolute; right: 20px; top: 30px; color: white; font-weight: bold; font-size: 18px; text-decoration: none; border: 2px solid white; padding: 5px 15px; border-radius: 5px;">🛒 Giỏ hàng</a>
    </div>
    
    <div class="container">
        <div class="sidebar">
            <h3>NHÓM THIẾT BỊ</h3>
            <ul>
                <%
                    String maThietBiStr = request.getParameter("mathietbi");
                    int maThietBi = (maThietBiStr != null) ? Integer.parseInt(maThietBiStr) : 0;
                    
                    ThietBiDAO thietBiDAO = new ThietBiDAO();
                    ThietBi thietBi = thietBiDAO.getThietBiById(maThietBi);
                    int maNhomSelected = (thietBi != null) ? thietBi.getMaNhom() : 1;
                    
                    NhomDAO nhomDAO = new NhomDAO();
                    List<Nhom> listNhom = nhomDAO.getAllNhom();
                    for (Nhom nhom : listNhom) {
                        String activeClass = (nhom.getMaNhom() == maNhomSelected) ? "active" : "";
                %>
                <li><a href="danhsach.jsp?manhom=<%= nhom.getMaNhom() %>" class="<%= activeClass %>"><%= nhom.getTenNhom() %></a></li>
                <%
                    }
                %>
            </ul>
        </div>
 
        <div class="content">
            <%
                if (thietBi != null) {
                    DecimalFormat formatter = new DecimalFormat("#,###");
            %>
            <div class="product-detail">
                <div class="product-detail-content">
                    <div class="product-image">
                        <img src="images/<%= thietBi.getHinhAnh() %>" alt="<%= thietBi.getTenThietBi() %>" 
                             onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22300%22%3E%3Crect width=%22300%22 height=%22300%22 fill=%22%23ddd%22/%3E%3Ctext x=%2250%25%22 y=%2250%25%22 font-size=%2220%22 fill=%22%23999%22 text-anchor=%22middle%22 dy=%22.3em%22%3ENo Image%3C/text%3E%3C/svg%3E'">
                    </div>
                    <div class="product-info">
                        <h2>Tên thiết bị: <%= thietBi.getTenThietBi() %></h2>
                        <div class="detail-row">
                            <strong>Mô tả:</strong> <%= (thietBi.getMoTa() != null) ? thietBi.getMoTa() : "" %>
                        </div>
                        <div class="price">Đơn giá: <%= formatter.format(thietBi.getDonGia()) %> VNĐ</div>
                        
                        <form action="giohang.jsp" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="mathietbi" value="<%= thietBi.getMaThietBi() %>">
                            
                            <div class="quantity-section">
                                <label>Số lượng:</label>
                                <input type="number" name="soluong" value="1" min="1" max="<%= thietBi.getSoLuong() %>">
                                <button type="submit" class="btn-add-cart">Thêm vào Giỏ hàng</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%
                } else {
            %>
            <p>Không tìm thấy thông tin thiết bị!</p>
            <%
                }
            %>
        </div>
    </div>
    
    <div class="footer">
    <p style="margin: 0; font-size: 16px; letter-spacing: 1px;">
        <strong>HỆ THỐNG QUẢN LÝ CỬA HÀNG LINH KIỆN MÁY TÍNH</strong>
    </p>
    <p style="margin: 8px 0 0 0; font-size: 14px; color: #ccc;">
        Phát triển bởi: <span style="color: #ff9933; font-weight: bold;">Nguyễn Trọng Minh</span>
    </p>
    <p style="margin: 5px 0 0 0; font-size: 13px; color: #bbb; font-style: italic;">
        Liên hệ công việc: <a href="mailto:minhndfgh05@gmail.com" style="color: #bbb; text-decoration: none;">minhndfgh05@gmail.com</a> hoặc (+84) 963 760 551
    </p>
    </div>
</body>
</html>