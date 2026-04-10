<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, dao.*"%>
<%
    // 1. Nhận dữ liệu từ nút bấm
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    String idStr = request.getParameter("mathietbi");
    
    int id = 0;
    try {
        if (idStr != null && !idStr.isEmpty()) {
            id = Integer.parseInt(idStr.trim());
        }
    } catch (Exception e) {
        System.out.println("Lỗi ép kiểu ID: " + e.getMessage());
    }

    // 2. Lấy giỏ hàng từ Session (Nếu chưa có thì tạo mới)
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        session.setAttribute("cart", cart);
    }

    // 3. Xử lý THÊM sản phẩm
    if ("add".equals(action) && id > 0) {
        ThietBi tb = new ThietBiDAO().getThietBiById(id);
        if (tb != null) {
            cart.addItem(tb, 1); // Thêm vào bộ nhớ tạm (Session)
            
            // Nếu đã đăng nhập thì lưu vào Database luôn
            User loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser != null) {
                GioHangDAO ghDAO = new GioHangDAO();
                ghDAO.addToCart(loggedInUser.getMaUser(), id, 1);
            }
        }
    } 
    // 4. Xử lý XÓA sản phẩm
    else if ("remove".equals(action) && id > 0) {
        cart.removeItem(id);
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser != null) {
            new GioHangDAO().removeItem(loggedInUser.getMaUser(), id);
        }
    }

    // 5. Cập nhật lại Session và chuyển về trang hiển thị giỏ hàng
    session.setAttribute("cart", cart);
    response.sendRedirect("giohang.jsp");
%>