package model;

public class User {
    private int maUser;
    private String tenDangNhap;
    private String matKhau;
    private String hoTen;
    private String sdt;
    private String diaChi;
    private int vaiTro;

    public User() {}

    public User(int maUser, String tenDangNhap, String matKhau, String hoTen, String sdt, String diaChi, int vaiTro) {
        this.maUser = maUser; this.tenDangNhap = tenDangNhap; this.matKhau = matKhau;
        this.hoTen = hoTen; this.sdt = sdt; this.diaChi = diaChi; this.vaiTro = vaiTro;
    }

    public int getMaUser() { return maUser; } public void setMaUser(int maUser) { this.maUser = maUser; }
    public String getTenDangNhap() { return tenDangNhap; } public void setTenDangNhap(String tenDangNhap) { this.tenDangNhap = tenDangNhap; }
    public String getMatKhau() { return matKhau; } public void setMatKhau(String matKhau) { this.matKhau = matKhau; }
    public String getHoTen() { return hoTen; } public void setHoTen(String hoTen) { this.hoTen = hoTen; }
    public String getSdt() { return sdt; } public void setSdt(String sdt) { this.sdt = sdt; }
    public String getDiaChi() { return diaChi; } public void setDiaChi(String diaChi) { this.diaChi = diaChi; }
    public int getVaiTro() { return vaiTro; } public void setVaiTro(int vaiTro) { this.vaiTro = vaiTro; }
}