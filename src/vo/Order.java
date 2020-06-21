package vo;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Order {
    private List<OrderItem> items = new ArrayList<>();
    private int id, state;
    /**
     * state
     * 0 未付款
     * 1 待派送
     * 2 正在派送
     * 3 已签收
     */
    private float price;
    private Timestamp time;
    private String name, address, phone;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<OrderItem> getItems() {
        return items;
    }


    public void updatePrice() {
        float price = 0;
        for (OrderItem item : items) {
            price += item.getPrice();
        }
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }
}
