<%
    // Kiểm tra nếu chưa đăng nhập thì đuổi về trang login
    if(session.getAttribute("adminUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.ThietBiDAO"%>
<%@page import="dao.NhomDAO"%>
<%@page import="model.ThietBi"%>
<%@page import="model.Nhom"%>
<%@page import="java.util.List"%>
<%
    request.setCharacterEncoding("UTF-8");
    String idStr = request.getParameter("id");
    ThietBi tb = null;
    String action = "add";
    
    if (idStr != null) {
        tb = new ThietBiDAO().getThietBiById(Integer.parseInt(idStr));
        action = "edit";
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><%= (tb==null)?"Thêm mới":"Cập nhật" %> Thiết bị</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style> body { background-color: #f4f6f9; } </style>
</head>
<body class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow border-0">
                    <div class="card-header bg-primary text-white py-3">
                        <h4 class="m-0"><i class="fa-solid fa-box me-2"></i><%= (tb==null) ? "THÊM THIẾT BỊ MỚI" : "CẬP NHẬT THIẾT BỊ" %></h4>
                    </div>
                    <div class="card-body p-4">
                        <form action="xuly_thietbi.jsp" method="post">
                            <input type="hidden" name="action" value="<%= action %>">
                            <% if(tb!=null) { %> <input type="hidden" name="id" value="<%= tb.getMaThietBi() %>"> <% } %>
                            
                            <div class="row g-3">
                                <div class="col-md-8">
                                    <label class="form-label fw-bold">Tên thiết bị <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="ten" value="<%= (tb!=null)?tb.getTenThietBi():"" %>" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Nhóm thiết bị</label>
                                    <select class="form-select" name="maNhom">
                                        <%
                                            List<Nhom> nhoms = new NhomDAO().getAllNhom();
                                            for(Nhom n : nhoms){
                                        %>
                                        <option value="<%= n.getMaNhom() %>" <%= (tb!=null && tb.getMaNhom()==n.getMaNhom())?"selected":"" %>><%= n.getTenNhom() %></option>
                                        <% } %>
                                    </select>
                                </div>
                                
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="gia" value="<%= (tb!=null)?tb.getDonGia():"0" %>" min="0" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Số lượng trong kho</label>
                                    <input type="number" class="form-control" name="sl" value="<%= (tb!=null)?tb.getSoLuong():"1" %>" min="0">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Đơn vị tính</label>
                                    <input type="text" class="form-control" name="dvt" value="<%= (tb!=null)?tb.getDonViTinh():"Cái" %>">
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-bold">Tên file hình ảnh</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa-regular fa-image"></i></span>
                                        <input type="text" class="form-control" name="anh" placeholder="Ví dụ: mainboard_asus.jpg" value="<%= (tb!=null)?tb.getHinhAnh():"" %>">
                                    </div>
                                    <small class="text-muted">Đảm bảo ảnh đã được copy vào thư mục <code>images/</code> của project.</small>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-bold">Mô tả chi tiết</label>
                                    <textarea class="form-control" name="mota" rows="4"><%= (tb!=null && tb.getMoTa()!=null)?tb.getMoTa():"" %></textarea>
                                </div>
                            </div>

                            <hr class="my-4">
                            
                            <div class="d-flex justify-content-end gap-2">
                                <a href="ql_thietbi.jsp" class="btn btn-secondary"><i class="fa-solid fa-arrow-left me-1"></i> Quay lại</a>
                                <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk me-1"></i> Lưu dữ liệu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>