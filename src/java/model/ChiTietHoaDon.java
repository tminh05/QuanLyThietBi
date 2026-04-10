package model;

public class ChiTietHoaDon {
    private int maHD;
    private int maThietBi;
    private String tenThietBi; // Thêm tên để hiển thị cho dễ
    private int soLuong;
    private long donGia;

    public ChiTietHoaDon() {}
    
    // Getters và Setters
    public int getMaHD() { return maHD; } public void setMaHD(int maHD) { this.maHD = maHD; }
    public int getMaThietBi() { return maThietBi; } public void setMaThietBi(int maThietBi) { this.maThietBi = maThietBi; }
    public String getTenThietBi() { return tenThietBi; } public void setTenThietBi(String tenThietBi) { this.tenThietBi = tenThietBi; }
    public int getSoLuong() { return soLuong; } public void setSoLuong(int soLuong) { this.soLuong = soLuong; }
    public long getDonGia() { return donGia; } public void setDonGia(long donGia) { this.donGia = donGia; }
}