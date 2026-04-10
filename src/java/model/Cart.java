package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items = new HashMap<>();

    public void addItem(ThietBi tb, int soLuong) {
        if (items.containsKey(tb.getMaThietBi())) {
            CartItem item = items.get(tb.getMaThietBi());
            item.setSoLuong(item.getSoLuong() + soLuong);
        } else {
            items.put(tb.getMaThietBi(), new CartItem(tb, soLuong));
        }
    }

    public void removeItem(int maThietBi) {
        items.remove(maThietBi);
    }

    public List<CartItem> getItems() {
        return new ArrayList<>(items.values());
    }

    public long getTotal() {
        long total = 0;
        for (CartItem item : items.values()) {
            total += item.getThanhTien();
        }
        return total;
    }
    
    public int getSize() {
        return items.size();
    }
}