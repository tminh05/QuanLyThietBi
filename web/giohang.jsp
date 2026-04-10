<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.NhomDAO"%>
<%@page import="dao.ThietBiDAO"%>
<%@page import="model.Nhom"%>
<%@page import="model.ThietBi"%>
<%@page import="model.Cart"%>
<%@page import="model.CartItem"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%
    // Xử lý giỏ hàng
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        session.setAttribute("cart", cart);
    }
    
    // Lấy thông tin user để hiển thị trên Header
    User loggedInUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Giỏ hàng - NTMINH CENTER</title>
    <style>
        /* --- NỀN TẢNG --- */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f4f4f4; line-height: 1.6; }

        /* --- HEADER VIP (ĐỒNG BỘ) --- */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 15px 40px; display: flex; justify-content: space-between; 
            align-items: center; color: white; box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .header-logo { text-decoration: none; color: white; transition: 0.3s; }
        .header-logo h1 { font-size: 26px; text-transform: uppercase; font-weight: 900; margin: 0; }
        
        .header-right { display: flex; align-items: center; gap: 20px; }
        .user-info { font-size: 14px; display: flex; align-items: center; gap: 10px; }
        .user-info b { color: #ff9933; }
        
        .btn-auth { color: white; text-decoration: none; font-weight: bold; font-size: 14px; transition: 0.3s; }
        .btn-auth:hover { color: #ff9933; }
        
        .btn-home { 
            color: white; font-weight: bold; text-decoration: none; border: 2px solid white; 
            padding: 8px 20px; border-radius: 30px; transition: 0.3s; 
        }
        .btn-home:hover { background: white; color: #764ba2; }

        /* --- LAYOUT CHÍNH --- */
        .container { display: flex; min-height: 600px; max-width: 1300px; margin: 30px auto; gap: 20px; padding: 0 20px; }
        
        /* Sidebar */
        .sidebar { width: 250px; background-color: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); height: fit-content; }
        .sidebar h3 { background-color: #ff9933; color: white; padding: 12px; margin-bottom: 20px; text-align: center; border-radius: 6px; font-size: 16px; }
        .sidebar ul { list-style: none; }
        .sidebar ul li a { 
            display: block; padding: 12px; background-color: #f9f9f9; color: #444; 
            text-decoration: none; border-left: 4px solid transparent; margin-bottom: 8px; border-radius: 4px; transition: 0.3s; 
        }
        .sidebar ul li a:hover { border-left-color: #ff9933; background-color: #fff5eb; color: #ff9933; padding-left: 15px; }

        /* Content Giỏ hàng */
        .content { flex: 1; padding: 30px; background: white; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .content h2 { margin-bottom: 25px; color: #333; display: flex; align-items: center; gap: 10px; }
        
        .cart-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .cart-table th { background-color: #f8f9fa; padding: 15px; border-bottom: 2px solid #eee; text-align: center; color: #666; font-size: 14px; text-transform: uppercase; }
        .cart-table td { padding: 20px 15px; border-bottom: 1px solid #eee; text-align: center; vertical-align: middle; }
        
        .cart-table img { border-radius: 8px; border: 1px solid #eee; object-fit: contain; background: #fff; }
        
        .btn-remove { 
            padding: 6px 12px; background-color: #fff; color: #dc3545; border: 1px solid #dc3545;
            text-decoration: none; border-radius: 4px; font-size: 12px; font-weight: bold; transition: 0.3s; 
        }
        .btn-remove:hover { background-color: #dc3545; color: white; }

        .cart-summary { 
            margin-top: 30px; text-align: right; padding: 20px; background: #fdf2e9; 
            border-radius: 8px; border: 1px solid #ffe8d1;
        }
        .cart-summary span { font-size: 16px; color: #666; }
        .cart-summary strong { color: #d0021b; font-size: 28px; margin-left: 10px; }

        .action-btns { display: flex; justify-content: space-between; margin-top: 30px; }
        .btn-continue { 
            display: inline-block; padding: 12px 25px; background-color: #6c757d; 
            color: white; text-decoration: none; border-radius: 6px; font-weight: bold; transition: 0.3s; 
        }
        .btn-continue:hover { background-color: #5a6268; transform: translateX(-5px); }
        
        .btn-order { 
            display: inline-block; padding: 12px 35px; background-color: #28a745; 
            color: white; text-decoration: none; border-radius: 6px; font-weight: bold; font-size: 16px; transition: 0.3s; 
        }
        .btn-order:hover { background-color: #218838; transform: translateY(-3px); box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3); }
    </style>
</head>
<body>
    <div class="header">
        <a href="index.jsp" class="header-logo">
            <h1></h1>
        </a>

        <div class="header-right">
            <% if (loggedInUser != null) { %>
                <div class="user-info">
                    <span>Chào, <b><%= loggedInUser.getHoTen() %></b></span>
                    <a href="logout.jsp" class="btn-auth" style="color: #ffc107;">[Đăng xuất]</a>
                </div>
            <% } else { %>
                <a href="dangnhap.jsp" class="btn-auth">Đăng nhập</a>
            <% } %>

            <a href="index.jsp" class="btn-home">🏠 Trang Chủ</a>
        </div>
    </div>
    
    <div class="container">
        <div class="sidebar">
            <h3>DANH MỤC</h3>
            <ul>
                <%
                    NhomDAO nhomDAO = new NhomDAO();
                    List<Nhom> listNhom = nhomDAO.getAllNhom();
                    for (Nhom nhom : listNhom) {
                %>
                <li><a href="danhsach.jsp?manhom=<%= nhom.getMaNhom() %>"><%= nhom.getTenNhom() %></a></li>
                <% } %>
            </ul>
        </div>
        
        <div class="content">
            <h2>🛒 Giỏ hàng của bạn</h2>
            
            <% if (cart.getSize() == 0) { %>
                <div style="text-align: center; padding: 80px 0;">
                    <img src="https://cdn-icons-png.flaticon.com/512/11329/11329060.png" width="120" style="opacity: 0.5; margin-bottom: 20px;">
                    <p style="color: #999; font-size: 18px;">Giỏ hàng của bạn đang trống.</p>
                    <a href="danhsach.jsp" class="btn-continue" style="margin-top: 20px; background: #ff9933;">Mua sắm ngay</a>
                </div>
            <% } else {
                DecimalFormat formatter = new DecimalFormat("#,###");
            %>
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CartItem item : cart.getItems()) {
                            ThietBi tb = item.getThietBi();
                        %>
                        <tr>
                            <td><img src="images/<%= tb.getHinhAnh() %>" width="70" height="70" onerror="this.src='images/no-image.png'"></td>
                            <td style="text-align: left; font-weight: bold; color: #444;"><%= tb.getTenThietBi() %></td>
                            <td><%= formatter.format(tb.getDonGia()) %> đ</td>
                            <td style="font-weight: bold;"><%= item.getSoLuong() %></td>
                            <td style="color: #d0021b; font-weight: bold;"><%= formatter.format(item.getThanhTien()) %> đ</td>
                            <td>
                                <a href="xuly_giohang.jsp?action=remove&mathietbi=<%= tb.getMaThietBi() %>" 
                                   class="btn-remove" onclick="return confirm('Xóa sản phẩm này khỏi giỏ hàng?');">XÓA</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <div class="cart-summary">
                    <span>Tổng số tiền cần thanh toán:</span>
                    <strong><%= formatter.format(cart.getTotal()) %> VNĐ</strong>
                </div>
                
                <div class="action-btns">
                    <a href="danhsach.jsp" class="btn-continue">← Tiếp tục mua sắm</a>
                    <a href="thanhtoan.jsp" class="btn-order">TIẾN HÀNH ĐẶT HÀNG →</a>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>