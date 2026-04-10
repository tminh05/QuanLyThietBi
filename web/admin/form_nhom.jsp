<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.NhomDAO, model.Nhom"%>
<%
    if(session.getAttribute("adminUser") == null) { response.sendRedirect("login.jsp"); return; }
    String idStr = request.getParameter("id");
    Nhom n = null;
    String action = "add";
    if (idStr != null) {
        n = new NhomDAO().getNhomById(Integer.parseInt(idStr));
        action = "edit";
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"><title><%= (n==null)?"Thêm mới":"Cập nhật" %> Nhóm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light py-5">
    <div class="container" style="max-width: 500px;">
        <div class="card shadow border-0">
            <div class="card-header bg-primary text-white py-3">
                <h4 class="m-0"><i class="fa-solid fa-tags me-2"></i><%= (n==null) ? "THÊM NHÓM MỚI" : "CẬP NHẬT NHÓM" %></h4>
            </div>
            <div class="card-body p-4">
                <form action="xuly_nhom.jsp" method="post">
                    <input type="hidden" name="action" value="<%= action %>">
                    <% if(n!=null) { %> <input type="hidden" name="id" value="<%= n.getMaNhom() %>"> <% } %>
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold">Tên nhóm thiết bị <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="tenNhom" value="<%= (n!=null)?n.getTenNhom():"" %>" required>
                    </div>
                    
                    <div class="d-flex justify-content-end gap-2">
                        <a href="ql_nhom.jsp" class="btn btn-secondary">Quay lại</a>
                        <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk me-1"></i> Lưu dữ liệu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>