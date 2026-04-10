<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.NhomDAO, model.Nhom, model.User, java.util.List"%>
<%
    // Lấy thông tin user từ session
    User loggedInUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NTMINH COMPUTER - Gear Up Game On</title>
    <style>
        :root {
            --primary: #ff9933;
            --secondary: #764ba2;
            --dark: #1a1a1a;
            --light: #f4f4f4;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { display: flex; flex-direction: column; min-height: 100vh; background-color: #fff; color: #333; }

        /* --- Header VIP --- */
        .header {
            background: linear-gradient(135deg, #667eea 0%, var(--secondary) 100%);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .header h1 { font-size: 26px; text-transform: uppercase; font-weight: 900; letter-spacing: 1px; }
        .header-actions { display: flex; align-items: center; gap: 20px; }
        
        .user-info { font-size: 14px; display: flex; align-items: center; gap: 15px; }
        .user-info b { color: var(--primary); }
        
        .btn-auth { color: white; text-decoration: none; font-weight: bold; font-size: 14px; transition: 0.3s; }
        .btn-auth:hover { color: var(--primary); }
        
        .btn-cart { border: 2px solid white; padding: 8px 20px; border-radius: 30px; font-weight: bold; text-decoration: none; color: white; transition: 0.3s; }
        .btn-cart:hover { background: white; color: var(--secondary); }

        /* --- Layout Container --- */
        .container { display: flex; flex: 1; width: 100%; max-width: 1400px; margin: 0 auto; }

        /* --- Sidebar --- */
        .sidebar { width: 280px; background-color: var(--light); padding: 30px 20px; border-right: 1px solid #eee; }
        .sidebar h3 { background-color: var(--primary); color: white; padding: 12px; margin-bottom: 20px; text-align: center; border-radius: 8px; font-size: 16px; }
        .sidebar ul { list-style: none; }
        .sidebar ul li { margin-bottom: 8px; }
        .sidebar ul li a { 
            display: block; padding: 12px; background: white; color: #444; 
            text-decoration: none; border-radius: 6px; border-left: 4px solid transparent; transition: 0.3s;
        }
        .sidebar ul li a:hover { border-left-color: var(--primary); background: #fff5eb; color: var(--primary); transform: translateX(5px); }

        /* --- Main Content --- */
        .content { flex: 1; padding: 30px; }

        /* Banner VIP */
        .hero-banner {
            background: linear-gradient(90deg, rgba(0,0,0,0.85) 30%, rgba(0,0,0,0.3) 100%), 
                        url('https://images.unsplash.com/photo-1591488320449-011701bb6704?q=80&w=2070&auto=format&fit=crop');
            background-size: cover; background-position: center;
            height: 350px; border-radius: 20px;
            display: flex; flex-direction: column; justify-content: center;
            padding: 0 60px; color: white; margin-bottom: 40px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        }
        .hero-banner h1 { 
            font-size: 50px; font-weight: 900; line-height: 1.1; margin-bottom: 15px;
            background: linear-gradient(to right, #ff9933, #ffcc33);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .hero-banner p { font-size: 18px; color: #ccc; max-width: 450px; border-left: 4px solid var(--primary); padding-left: 20px; }
        
        .btn-discover {
            width: fit-content; margin-top: 30px; padding: 12px 40px;
            background: var(--primary); color: white; text-decoration: none;
            border-radius: 30px; font-weight: bold; text-transform: uppercase;
            font-size: 13px; transition: 0.4s; box-shadow: 0 4px 15px rgba(255, 153, 51, 0.3);
        }
        .btn-discover:hover { background: white; color: var(--primary); transform: translateY(-3px); box-shadow: 0 8px 25px rgba(255, 153, 51, 0.5); }

        /* Services Bar */
        .services-bar { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 40px; }
        .service-item {
            background: white; padding: 20px; border-radius: 15px;
            display: flex; align-items: center; gap: 15px;
            border: 1px solid #eee; transition: 0.4s;
        }
        .service-item:hover { transform: translateY(-8px); border-color: var(--primary); box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
        .service-item span { font-size: 30px; background: #fff5eb; width: 55px; height: 55px; display: flex; align-items: center; justify-content: center; border-radius: 12px; }
        .service-item h4 { font-size: 15px; color: #222; text-transform: uppercase; margin-bottom: 2px; }
        .service-item p { font-size: 12px; color: #888; }

        /* --- Footer VIP --- */
        .footer { background-color: var(--dark); color: #fff; padding: 60px 0 20px; border-top: 5px solid var(--primary); }
        .footer-container { max-width: 1200px; margin: 0 auto; display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 40px; padding: 0 30px; }
        .footer-section h4 { color: var(--primary); font-size: 18px; margin-bottom: 25px; position: relative; }
        .footer-section h4::after { content: ''; position: absolute; left: 0; bottom: -8px; width: 40px; height: 2px; background: var(--primary); }
        .footer-section p, .footer-section a { color: #aaa; font-size: 14px; text-decoration: none; line-height: 2; transition: 0.3s; }
        
        /* Hiệu ứng nổi lên cho liên kết footer */
        .footer-link-item { display: inline-flex; align-items: center; transition: 0.3s; }
        .footer-link-item:hover { color: var(--primary); transform: translateY(-5px); text-shadow: 0 5px 10px rgba(0,0,0,0.5); }
        
        .footer-bottom { text-align: center; padding-top: 30px; margin-top: 40px; border-top: 1px solid #333; font-size: 13px; color: #666; }
    </style>
</head>
<body>

    <header class="header">
        <a href="index.jsp" style="text-decoration: none; color: white;"><h1>NTMINH Center</h1></a>
        <div class="header-actions">
            <% if (loggedInUser != null) { %>
                <div class="user-info">
                    <span>Xin chào, <b><%= loggedInUser.getHoTen() %></b></span>
                    <a href="doimatkhau.jsp" class="btn-auth" style="color: #ffc107;">[Đổi mật khẩu]</a>
                    <a href="logout.jsp" class="btn-auth" style="color: #ffc107;">[Đăng xuất]</a>
                </div>
            <% } else { %>
                <a href="dangnhap.jsp" class="btn-auth">Đăng nhập</a>
            <% } %>
            <a href="giohang.jsp" class="btn-cart">🛒 Giỏ hàng</a>
        </div>
    </header>

    <div class="container">
        <aside class="sidebar">
            <h3>DANH MỤC THIẾT BỊ</h3>
            <ul>
                <%
                    NhomDAO nhomDAO = new NhomDAO();
                    List<Nhom> listNhom = nhomDAO.getAllNhom();
                    for (Nhom nhom : listNhom) {
                %>
                <li><a href="danhsach.jsp?manhom=<%= nhom.getMaNhom() %>"><%= nhom.getTenNhom() %></a></li>
                <% } %>
            </ul>
        </aside>

        <main class="content">
            <section class="hero-banner">
                <h1>GEAR UP<br>GAME ON</h1>
                <p>Nâng tầm trải nghiệm với những linh kiện mạnh mẽ nhất để thống trị mọi cuộc chơi.</p>
                <a href="danhsach.jsp" class="btn-discover">Khám Phá Ngay</a>
            </section>

            <section class="services-bar">
                <div class="service-item">
                    <span>🚚</span>
                    <div><h4>Freeship</h4><p>Đơn từ 2 Triệu</p></div>
                </div>
                <div class="service-item">
                    <span>🛡️</span>
                    <div><h4>Bảo Hành</h4><p>Chính hãng 36 tháng</p></div>
                </div>
                <div class="service-item">
                    <span>💳</span>
                    <div><h4>Trả Góp</h4><p>Lãi suất 0%</p></div>
                </div>
                <div class="service-item">
                    <span>🛠️</span>
                    <div><h4>Kỹ Thuật</h4><p>Hỗ trợ chuyên sâu 24/7</p></div>
                </div>
            </section>
        </main>
    </div>

    <footer class="footer">
        <div class="footer-container">
            <div class="footer-section">
                <h4>VỀ CHÚNG TÔI</h4>
                <p>Đơn vị cung cấp linh kiện, phụ kiện PC, Laptop Gaming hàng đầu với dịch vụ chuyên nghiệp và giá cả hợp lý.</p>
            </div>
            <div class="footer-section">
                <h4>LIÊN KẾT NHANH</h4>
                <a href="index.jsp" class="footer-link-item">• Trang chủ</a><br>
                <a href="giohang.jsp" class="footer-link-item">• Giỏ hàng</a><br>
                <a href="dangnhap.jsp" class="footer-link-item">• Tài khoản cá nhân</a><br>
                <a href="danhsach.jsp" class="footer-link-item">• Tất cả sản phẩm</a>
            </div>
            <div class="footer-section">
                <h4>LIÊN HỆ</h4>
                <a href="mailto:minhndfgh05@gmail.com" class="footer-link-item" style="color: #aaa;">• 📧 minhndfgh05@gmail.com</a><br>
                <a href="tel:0963760551" class="footer-link-item" style="color: #aaa;">• 📞 0963 760 551</a><br>
                <p>• 📍 48 Cao Thắng, TP. Đà Nẵng</p>
            </div>
        </div>
        <div class="footer-bottom">
            Designed & Developed by <b style="color: var(--primary);">Nguyễn Trọng Minh</b>
        </div>
    </footer>

</body>
</html>