package dao;

import database.DBConnect;
import model.User;
import java.sql.ResultSet;

public class UserDAO {
    private DBConnect db = new DBConnect();

    // Hàm xử lý Đăng nhập
    public User login(String username, String password) {
        User u = null;
        String sql = "SELECT * FROM tbUSER WHERE TENDANGNHAP = ? AND MATKHAU = ?";
        try {
            ResultSet rs = db.executePreparedQuery(sql, username, password);
            if (rs.next()) {
                u = new User(rs.getInt("MAUSER"), rs.getString("TENDANGNHAP"), rs.getString("MATKHAU"),
                             rs.getString("HOTEN"), rs.getString("SDT"), rs.getString("DIACHI"), rs.getInt("VAITRO"));
            }
            db.closeConnection();
        } catch (Exception e) { e.printStackTrace(); }
        return u;
    }

    // Kiểm tra xem tên đăng nhập đã tồn tại chưa
    public boolean checkExist(String username) {
        boolean exist = false;
        String sql = "SELECT * FROM tbUSER WHERE TENDANGNHAP = ?";
        try {
            ResultSet rs = db.executePreparedQuery(sql, username);
            if (rs.next()) exist = true;
            db.closeConnection();
        } catch (Exception e) { e.printStackTrace(); }
        return exist;
    }

    // Hàm xử lý Đăng ký
    public boolean register(User u) {
        if (checkExist(u.getTenDangNhap())) return false; // Không cho trùng username
        String sql = "INSERT INTO tbUSER (TENDANGNHAP, MATKHAU, HOTEN, SDT, DIACHI, VAITRO) VALUES (?, ?, ?, ?, ?, 0)";
        return db.executePreparedUpdate(sql, u.getTenDangNhap(), u.getMatKhau(), u.getHoTen(), u.getSdt(), u.getDiaChi()) > 0;
    }

    // ==========================================
    // HÀM MỚI: XỬ LÝ ĐỔI MẬT KHẨU
    // ==========================================
    public boolean changePassword(String usernameFromSession, String usernameInput, String oldPass, String newPass) {
    // Kiểm tra xem tên đăng nhập nhập vào có khớp với tài khoản đang login không
    if (!usernameFromSession.equalsIgnoreCase(usernameInput)) {
        return false; 
    }

    String sqlCheck = "SELECT * FROM tbUSER WHERE TENDANGNHAP = ? AND MATKHAU = ?";
    try {
        // Dùng dbConnect của bạn để thực thi
        ResultSet rs = db.executePreparedQuery(sqlCheck, usernameInput, oldPass);
        if (rs.next()) {
            String sqlUpdate = "UPDATE tbUSER SET MATKHAU = ? WHERE TENDANGNHAP = ?";
            int result = db.executePreparedUpdate(sqlUpdate, newPass, usernameInput);
            db.closeConnection();
            return result > 0;
        }
        db.closeConnection();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
}