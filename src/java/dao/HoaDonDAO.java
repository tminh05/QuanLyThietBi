package dao;

import database.DBConnect;
import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HoaDonDAO {
    private DBConnect db = new DBConnect();

    // 1. Khách hàng Thanh toán
    public boolean thanhToan(HoaDon hd, Cart cart) {
        boolean result = false;
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=dbQuanLyThietBi;user=sa;password=123456;encrypt=false");
            conn.setAutoCommit(false); 

            String sqlHD = "INSERT INTO tbHOADON (TENKHACH, SODIENTHOAI, DIACHI, TONGTIEN, TRANGTHAI) VALUES (?, ?, ?, ?, 0)";
            PreparedStatement pstHD = conn.prepareStatement(sqlHD, Statement.RETURN_GENERATED_KEYS);
            pstHD.setString(1, hd.getTenKhach());
            pstHD.setString(2, hd.getSoDienThoai());
            pstHD.setString(3, hd.getDiaChi());
            pstHD.setLong(4, hd.getTongTien());
            pstHD.executeUpdate();

            ResultSet rs = pstHD.getGeneratedKeys();
            int maHD = 0;
            if (rs.next()) {
                maHD = rs.getInt(1);
            }

            if (maHD > 0) {
                String sqlCT = "INSERT INTO tbCHITIETHOADON (MAHD, MATHIETBI, SOLUONG, DONGIA) VALUES (?, ?, ?, ?)";
                PreparedStatement pstCT = conn.prepareStatement(sqlCT);
                
                String sqlUpdateKho = "UPDATE tbTHIETBI SET SOLUONG = SOLUONG - ? WHERE MATHIETBI = ?";
                PreparedStatement pstUpdateKho = conn.prepareStatement(sqlUpdateKho);

                for (CartItem item : cart.getItems()) {
                    pstCT.setInt(1, maHD);
                    pstCT.setInt(2, item.getThietBi().getMaThietBi());
                    pstCT.setInt(3, item.getSoLuong());
                    pstCT.setLong(4, item.getThietBi().getDonGia());
                    pstCT.executeUpdate();

                    pstUpdateKho.setInt(1, item.getSoLuong());
                    pstUpdateKho.setInt(2, item.getThietBi().getMaThietBi());
                    pstUpdateKho.executeUpdate();
                }
                conn.commit(); 
                result = true;
            }
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        }
        return result;
    }

    // 2. Lấy danh sách Hóa đơn cho Admin
    public List<HoaDon> getAllHoaDon() {
        List<HoaDon> list = new ArrayList<>();
        String sql = "SELECT * FROM tbHOADON ORDER BY MAHD DESC";
        try {
            ResultSet rs = db.executeQuery(sql);
            while (rs.next()) {
                HoaDon hd = new HoaDon(
                    rs.getInt("MAHD"), rs.getString("TENKHACH"), rs.getString("SODIENTHOAI"),
                    rs.getString("DIACHI"), rs.getTimestamp("NGAYDAT"), rs.getLong("TONGTIEN"), rs.getInt("TRANGTHAI")
                );
                list.add(hd);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 3. Admin Cập nhật trạng thái đơn hàng
    public boolean updateTrangThai(int maHD, int trangThai) {
        String sql = "UPDATE tbHOADON SET TRANGTHAI = ? WHERE MAHD = ?";
        return db.executePreparedUpdate(sql, trangThai, maHD) > 0;
    }

    // ==========================================
    // HÀM MỚI: THỐNG KÊ CHO DASHBOARD
    // ==========================================

    // Hàm đếm tổng số hóa đơn
    public int countHoaDonThanhCong() {
        String sql = "SELECT COUNT(*) FROM tbHOADON WHERE TRANGTHAI = 2";
        try {
            ResultSet rs = db.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Hàm tính tổng doanh thu thực tế (chỉ tính đơn đã giao)
    public long getTotalRevenueThanhCong() {
        String sql = "SELECT SUM(TONGTIEN) FROM tbHOADON WHERE TRANGTHAI = 2";
        try {
            ResultSet rs = db.executeQuery(sql);
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}