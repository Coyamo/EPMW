package vo;

public class OrderItem {

    private Goods goods;
    private int count = 1;
    private float price;


    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
        price = goods.getPrice() * count;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
        if (goods != null) price = goods.getPrice() * count;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }
}
