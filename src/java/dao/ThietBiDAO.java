package dao;

import database.DBConnect;
import model.ThietBi;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ThietBiDAO {
    private DBConnect db = new DBConnect();
    
    // CÁC HÀM DÀNH CHO TRANG KHÁCH HÀNG (FRONTEND)
    
    // Lấy danh sách thiết bị theo nhóm (Dùng cho danhsach.jsp)
    public List<ThietBi> getThietBiByNhom(int maNhom) {
        List<ThietBi> list = new ArrayList<>();
        String sql = "SELECT * FROM tbTHIETBI WHERE MANHOM = " + maNhom;
        
        try {
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                ThietBi tb = new ThietBi();
                tb.setMaThietBi(rs.getInt("MATHIETBI"));
                tb.setTenThietBi(rs.getString("TENTHIETBI"));
                tb.setDonViTinh(rs.getString("DONVITINH"));
                tb.setSoLuong(rs.getInt("SOLUONG"));
                tb.setDonGia(rs.getLong("DONGIA"));
                tb.setHinhAnh(rs.getString("HINHANH"));
                tb.setMoTa(rs.getString("MOTA"));
                tb.setMaNhom(rs.getInt("MANHOM"));
                list.add(tb);
            }
            db.closeConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy chi tiết thiết bị theo mã (Dùng cho chitiet.jsp và form_thietbi.jsp)
    public ThietBi getThietBiById(int maThietBi) {
        ThietBi tb = null;
        String sql = "SELECT * FROM tbTHIETBI WHERE MATHIETBI = " + maThietBi;
        
        try {
            ResultSet rs = db.executeQuery(sql);
            if (rs.next()) {
                tb = new ThietBi();
                tb.setMaThietBi(rs.getInt("MATHIETBI"));
                tb.setTenThietBi(rs.getString("TENTHIETBI"));
                tb.setDonViTinh(rs.getString("DONVITINH"));
                tb.setSoLuong(rs.getInt("SOLUONG"));
                tb.setDonGia(rs.getLong("DONGIA"));
                tb.setHinhAnh(rs.getString("HINHANH"));
                tb.setMoTa(rs.getString("MOTA"));
                tb.setMaNhom(rs.getInt("MANHOM"));
            }
            db.closeConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tb;
    }

    // =========================================================
    // HÀM MỚI: TÌM KIẾM VÀ LỌC SẢN PHẨM THEO GIÁ
    // =========================================================
    public List<ThietBi> searchAndFilter(String keyword, long minPrice, long maxPrice, int maNhom) {
        List<ThietBi> list = new ArrayList<>();
        String sql = "SELECT * FROM tbTHIETBI WHERE 1=1";
        
        // Nối thêm điều kiện tìm kiếm theo tên
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND TENTHIETBI LIKE N'%" + keyword.replace("'", "''") + "%'";
        }
        // Nối thêm điều kiện lọc giá thấp nhất
        if (minPrice > 0) {
            sql += " AND DONGIA >= " + minPrice;
        }
        // Nối thêm điều kiện lọc giá cao nhất
        if (maxPrice > 0) {
            sql += " AND DONGIA <= " + maxPrice;
        }
        // Lọc theo nhóm (nếu maNhom = 0 thì lấy tất cả)
        if (maNhom > 0) {
            sql += " AND MANHOM = " + maNhom;
        }
        
        sql += " ORDER BY MATHIETBI DESC";

        try {
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                ThietBi tb = new ThietBi();
                tb.setMaThietBi(rs.getInt("MATHIETBI"));
                tb.setTenThietBi(rs.getString("TENTHIETBI"));
                tb.setDonViTinh(rs.getString("DONVITINH"));
                tb.setSoLuong(rs.getInt("SOLUONG"));
                tb.setDonGia(rs.getLong("DONGIA"));
                tb.setHinhAnh(rs.getString("HINHANH"));
                tb.setMoTa(rs.getString("MOTA"));
                tb.setMaNhom(rs.getInt("MANHOM"));
                list.add(tb);
            }
            db.closeConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // CÁC HÀM DÀNH CHO PHÂN HỆ QUẢN TRỊ (ADMIN)

    public List<ThietBi> getAllThietBi() {
        List<ThietBi> list = new ArrayList<>();
        String sql = "SELECT * FROM tbTHIETBI ORDER BY MATHIETBI DESC";
        
        try {
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                ThietBi tb = new ThietBi();
                tb.setMaThietBi(rs.getInt("MATHIETBI"));
                tb.setTenThietBi(rs.getString("TENTHIETBI"));
                tb.setDonViTinh(rs.getString("DONVITINH"));
                tb.setSoLuong(rs.getInt("SOLUONG"));
                tb.setDonGia(rs.getLong("DONGIA"));
                tb.setHinhAnh(rs.getString("HINHANH"));
                tb.setMoTa(rs.getString("MOTA"));
                tb.setMaNhom(rs.getInt("MANHOM"));
                list.add(tb);
            }
            db.closeConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertThietBi(ThietBi tb) {
        String sql = "INSERT INTO tbTHIETBI (TENTHIETBI, DONVITINH, SOLUONG, DONGIA, HINHANH, MOTA, MANHOM) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int result = db.executePreparedUpdate(sql, tb.getTenThietBi(), tb.getDonViTinh(), 
                                              tb.getSoLuong(), tb.getDonGia(), tb.getHinhAnh(), 
                                              tb.getMoTa(), tb.getMaNhom());
        return result > 0;
    }

    public boolean updateThietBi(ThietBi tb) {
        String sql = "UPDATE tbTHIETBI SET TENTHIETBI=?, DONVITINH=?, SOLUONG=?, DONGIA=?, HINHANH=?, MOTA=?, MANHOM=? WHERE MATHIETBI=?";
        int result = db.executePreparedUpdate(sql, tb.getTenThietBi(), tb.getDonViTinh(), 
                                              tb.getSoLuong(), tb.getDonGia(), tb.getHinhAnh(), 
                                              tb.getMoTa(), tb.getMaNhom(), tb.getMaThietBi());
        return result > 0;
    }

    public boolean deleteThietBi(int maThietBi) {
        String sql = "DELETE FROM tbTHIETBI WHERE MATHIETBI=?";
        int result = db.executePreparedUpdate(sql, maThietBi);
        return result > 0;
    }
}