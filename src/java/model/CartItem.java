package model;

public class CartItem {
    private ThietBi thietBi;
    private int soLuong;

    public CartItem() {
    }

    public CartItem(ThietBi thietBi, int soLuong) {
        this.thietBi = thietBi;
        this.soLuong = soLuong;
    }

    public ThietBi getThietBi() {
        return thietBi;
    }

    public void setThietBi(ThietBi thietBi) {
        this.thietBi = thietBi;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }
    
    // Tính thành tiền cho 1 sản phẩm
    public long getThanhTien() {
        return this.thietBi.getDonGia() * this.soLuong;
    }
}