package dao;

import database.DBConnect;
import model.Nhom;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NhomDAO {
    private DBConnect db = new DBConnect();
    
    // =====================================================================
    // LẤY DANH SÁCH (Dùng cho cả Admin và Khách hàng)
    // =====================================================================
    public List<Nhom> getAllNhom() {
        List<Nhom> list = new ArrayList<>();
        String sql = "SELECT * FROM tbNHOM ORDER BY MANHOM";
        
        try {
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                Nhom nhom = new Nhom();
                nhom.setMaNhom(rs.getInt("MANHOM"));
                nhom.setTenNhom(rs.getString("TENNHOM"));
                list.add(nhom);
            }
            db.closeConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // =====================================================================
    // CÁC HÀM XỬ LÝ DỮ LIỆU DÀNH CHO PHÂN HỆ ADMIN
    // =====================================================================

    // 1. Thêm nhóm thiết bị mới
    public boolean insertNhom(Nhom n) {
        String sql = "INSERT INTO tbNHOM (TENNHOM) VALUES (?)";
        // Sử dụng executePreparedUpdate để chống SQL Injection
        int result = db.executePreparedUpdate(sql, n.getTenNhom());
        return result > 0;
    }

    // 2. Cập nhật tên nhóm thiết bị
    public boolean updateNhom(Nhom n) {
        String sql = "UPDATE tbNHOM SET TENNHOM=? WHERE MANHOM=?";
        int result = db.executePreparedUpdate(sql, n.getTenNhom(), n.getMaNhom());
        return result > 0;
    }

    // 3. Xóa nhóm thiết bị khỏi CSDL
    public boolean deleteNhom(int maNhom) {
        String sql = "DELETE FROM tbNHOM WHERE MANHOM=?";
        int result = db.executePreparedUpdate(sql, maNhom);
        return result > 0;
    }

    // 4. Lấy thông tin chi tiết 1 nhóm dựa vào ID (Dùng khi hiển thị form Sửa)
    public Nhom getNhomById(int maNhom) {
        Nhom n = null;
        String sql = "SELECT * FROM tbNHOM WHERE MANHOM = " + maNhom;
        try {
            ResultSet rs = db.executeQuery(sql);
            if (rs.next()) {
                n = new Nhom();
                n.setMaNhom(rs.getInt("MANHOM"));
                n.setTenNhom(rs.getString("TENNHOM"));
            }
            db.closeConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return n;
    }
}