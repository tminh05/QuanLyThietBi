<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.NhomDAO, model.Nhom"%>
<%
    request.setCharacterEncoding("UTF-8");
    String action = request.getParameter("action");
    NhomDAO dao = new NhomDAO();

    try {
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (dao.deleteNhom(id)) session.setAttribute("message", "Đã xóa nhóm ID #" + id + " thành công!");
        } else if ("add".equals(action) || "edit".equals(action)) {
            String ten = request.getParameter("tenNhom");
            Nhom n = new Nhom(0, ten);
            
            if ("add".equals(action)) {
                if (dao.insertNhom(n)) session.setAttribute("message", "Thêm nhóm mới thành công!");
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                n.setMaNhom(id);
                if (dao.updateNhom(n)) session.setAttribute("message", "Cập nhật nhóm thành công!");
            }
        }
    } catch (Exception e) {
        session.setAttribute("message", "Lỗi: " + e.getMessage());
    }
    response.sendRedirect("ql_nhom.jsp");
%>