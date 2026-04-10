package model;
import java.sql.Timestamp;

public class HoaDon {
    private int maHD;
    private String tenKhach;
    private String soDienThoai;
    private String diaChi;
    private Timestamp ngayDat;
    private long tongTien;
    private int trangThai;

    public HoaDon() {}

    public HoaDon(int maHD, String tenKhach, String soDienThoai, String diaChi, Timestamp ngayDat, long tongTien, int trangThai) {
        this.maHD = maHD; this.tenKhach = tenKhach; this.soDienThoai = soDienThoai;
        this.diaChi = diaChi; this.ngayDat = ngayDat; this.tongTien = tongTien; this.trangThai = trangThai;
    }

    // Generate Getters và Setters cho tất cả các biến ở trên
    public int getMaHD() { return maHD; } public void setMaHD(int maHD) { this.maHD = maHD; }
    public String getTenKhach() { return tenKhach; } public void setTenKhach(String tenKhach) { this.tenKhach = tenKhach; }
    public String getSoDienThoai() { return soDienThoai; } public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }
    public String getDiaChi() { return diaChi; } public void setDiaChi(String diaChi) { this.diaChi = diaChi; }
    public Timestamp getNgayDat() { return ngayDat; } public void setNgayDat(Timestamp ngayDat) { this.ngayDat = ngayDat; }
    public long getTongTien() { return tongTien; } public void setTongTien(long tongTien) { this.tongTien = tongTien; }
    public int getTrangThai() { return trangThai; } public void setTrangThai(int trangThai) { this.trangThai = trangThai; }
}