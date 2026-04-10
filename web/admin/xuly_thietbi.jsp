<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.ThietBiDAO"%>
<%@page import="model.ThietBi"%>
<%
    // Fix lỗi tiếng Việt khi submit form
    request.setCharacterEncoding("UTF-8");
    
    String action = request.getParameter("action");
    ThietBiDAO dao = new ThietBiDAO();

    try {
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (dao.deleteThietBi(id)) {
                session.setAttribute("message", "Đã xóa thiết bị ID #" + id + " thành công!");
            }
        } 
        else if ("add".equals(action) || "edit".equals(action)) {
            // Lấy dữ liệu an toàn
            String ten = request.getParameter("ten");
            String dvt = request.getParameter("dvt");
            int sl = Integer.parseInt(request.getParameter("sl"));
            long gia = Long.parseLong(request.getParameter("gia"));
            String anh = request.getParameter("anh");
            String mota = request.getParameter("mota");
            int maNhom = Integer.parseInt(request.getParameter("maNhom"));
            
            ThietBi tb = new ThietBi(0, ten, dvt, sl, gia, anh, mota, maNhom);
            
            if ("add".equals(action)) {
                if (dao.insertThietBi(tb)) {
                    session.setAttribute("message", "Thêm thiết bị mới thành công!");
                }
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                tb.setMaThietBi(id);
                if (dao.updateThietBi(tb)) {
                    session.setAttribute("message", "Cập nhật thiết bị ID #" + id + " thành công!");
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
    }
    
    // Điều hướng về trang quản lý sau khi xử lý xong
    response.sendRedirect("ql_thietbi.jsp");
%>