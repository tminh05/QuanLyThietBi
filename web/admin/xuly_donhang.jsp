<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.HoaDonDAO"%>
<%
    if(session.getAttribute("adminUser") == null) { response.sendRedirect("login.jsp"); return; }
    
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        int stt = Integer.parseInt(request.getParameter("stt"));
        
        if (new HoaDonDAO().updateTrangThai(id, stt)) {
            String sttText = (stt == 1) ? "Đang giao hàng" : (stt == 2) ? "Đã giao xong" : "Đã hủy";
            session.setAttribute("message", "Đã cập nhật đơn hàng #" + id + " thành: " + sttText);
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
    
    response.sendRedirect("ql_donhang.jsp");
%>