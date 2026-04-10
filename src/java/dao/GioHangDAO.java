package dao;

import database.DBConnect;
import model.CartItem;
import model.ThietBi;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GioHangDAO {
    private DBConnect db = new DBConnect();

    public List<CartItem> getCartByUser(int maUser) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT g.SOLUONG, t.* FROM tbGIOHANG g JOIN tbTHIETBI t ON g.MATHIETBI = t.MATHIETBI WHERE g.MAUSER = ?";
        try {
            ResultSet rs = db.executePreparedQuery(sql, maUser);
            if (rs != null) {
                while (rs.next()) {
                    ThietBi tb = new ThietBi();
                    tb.setMaThietBi(rs.getInt("MATHIETBI"));
                    tb.setTenThietBi(rs.getString("TENTHIETBI"));
                    tb.setDonGia(rs.getLong("DONGIA"));
                    tb.setHinhAnh(rs.getString("HINHANH"));
                    
                    CartItem item = new CartItem(tb, rs.getInt("SOLUONG"));
                    list.add(item);
                }
            }
            db.closeConnection();
        } catch(Exception e) { 
            e.printStackTrace();
        }
        return list;
    }

    public boolean addToCart(int maUser, int maThietBi, int soLuong) {
        String checkSql = "SELECT SOLUONG FROM tbGIOHANG WHERE MAUSER = ? AND MATHIETBI = ?";
        try {
            ResultSet rs = db.executePreparedQuery(checkSql, maUser, maThietBi);
            if (rs != null && rs.next()) {
                int currentQty = rs.getInt("SOLUONG");
                String updateSql = "UPDATE tbGIOHANG SET SOLUONG = ? WHERE MAUSER = ? AND MATHIETBI = ?";
                return db.executePreparedUpdate(updateSql, currentQty + soLuong, maUser, maThietBi) > 0;
            } else {
                String insertSql = "INSERT INTO tbGIOHANG (MAUSER, MATHIETBI, SOLUONG) VALUES (?, ?, ?)";
                return db.executePreparedUpdate(insertSql, maUser, maThietBi, soLuong) > 0;
            }
        } catch(Exception e) { 
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeItem(int maUser, int maThietBi) {
        String sql = "DELETE FROM tbGIOHANG WHERE MAUSER = ? AND MATHIETBI = ?";
        try {
            return db.executePreparedUpdate(sql, maUser, maThietBi) > 0;
        } catch(Exception e) { 
            e.printStackTrace();
            return false;
        }
    }

    public boolean clearCart(int maUser) {
        String sql = "DELETE FROM tbGIOHANG WHERE MAUSER = ?";
        try {
            return db.executePreparedUpdate(sql, maUser) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}