package model;

public class ThietBi {
    private int maThietBi;
    private String tenThietBi;
    private String donViTinh;
    private int soLuong;
    private long donGia;
    private String hinhAnh;
    private String moTa;
    private int maNhom;
    
    public ThietBi() {}
    
    // Constructor đầy đủ
    public ThietBi(int maThietBi, String tenThietBi, String donViTinh, 
                   int soLuong, long donGia, String hinhAnh, String moTa, int maNhom) {
        this.maThietBi = maThietBi;
        this.tenThietBi = tenThietBi;
        this.donViTinh = donViTinh;
        this.soLuong = soLuong;
        this.donGia = donGia;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
        this.maNhom = maNhom;
    }
    
    // Getters and Setters
    public int getMaThietBi() { return maThietBi; }
    public void setMaThietBi(int maThietBi) { this.maThietBi = maThietBi; }
    
    public String getTenThietBi() { return tenThietBi; }
    public void setTenThietBi(String tenThietBi) { this.tenThietBi = tenThietBi; }
    
    public String getDonViTinh() { return donViTinh; }
    public void setDonViTinh(String donViTinh) { this.donViTinh = donViTinh; }
    
    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }
    
    public long getDonGia() { return donGia; }
    public void setDonGia(long donGia) { this.donGia = donGia; }
    
    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }
    
    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }
    
    public int getMaNhom() { return maNhom; }
    public void setMaNhom(int maNhom) { this.maNhom = maNhom; }
}