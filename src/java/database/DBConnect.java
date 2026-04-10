package database;

import java.sql.*;

public class DBConnect {
    // Thông tin kết nối database
    private static final String SERVER = "localhost";
    private static final String DATABASE = "dbQuanLyThietBi"; 
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "123456"; 
    
    private static final String CONNECTION_URL = String.format(
        "jdbc:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s;encrypt=false;integratedSecurity=false",
        SERVER, DATABASE, USERNAME, PASSWORD
    );
    
    private Connection conn = null;
    private Statement stmt = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    
    // Mở kết nối
    public void openConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(CONNECTION_URL);
            // System.out.println("✅ KẾT NỐI DATABASE THÀNH CÔNG!"); // Bỏ comment dòng này nếu muốn test
        } catch (ClassNotFoundException e) {
            System.err.println("❌ THIẾU THƯ VIỆN: Bạn chưa Add thư viện mssql-jdbc.jar vào thư mục Libraries của Project!");
        } catch (SQLException e) {
            System.err.println("❌ LỖI SQL SERVER: Sai tên Database, sai Pass tài khoản 'sa', hoặc SQL Server chưa bật TCP/IP Port 1433!");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Đóng kết nối
    public void closeConnection() {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public ResultSet executeQuery(String sql) {
        try {
            openConnection();
            if (conn == null) return null; // Chặn lỗi ngầm
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public int executeUpdate(String sql) {
        int result = 0;
        try {
            openConnection();
            if (conn == null) return 0; // Chặn lỗi ngầm
            stmt = conn.createStatement();
            result = stmt.executeUpdate(sql);
            closeConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public ResultSet executePreparedQuery(String sql, Object... params) {
        try {
            openConnection();
            if (conn == null) return null; // Chặn lỗi ngầm
            pstmt = conn.prepareStatement(sql);
            for (int i = 0; i < params.length; i++) {
                pstmt.setObject(i + 1, params[i]);
            }
            rs = pstmt.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    public int executePreparedUpdate(String sql, Object... params) {
        int result = 0;
        try {
            openConnection();
            if (conn == null) return 0; // Chặn lỗi ngầm
            pstmt = conn.prepareStatement(sql);
            for (int i = 0; i < params.length; i++) {
                pstmt.setObject(i + 1, params[i]);
            }
            result = pstmt.executeUpdate();
            closeConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}