package dao;

import utils.JdbcUtil;
import vo.Order;
import vo.OrderItem;
import vo.Page;
import vo.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDao {

    /**
     * 给订单添加内容，如果存在就累计数量，不存在则添加
     *
     * @param order     订单
     * @param orderItem 购买的商品，Goods的封装
     */
    public void addItem(Order order, OrderItem orderItem) {
        for (OrderItem item : order.getItems()) {
            if (item.getGoods().getId() == orderItem.getGoods().getId()) {
                item.setCount(item.getCount() + orderItem.getCount());
                order.updatePrice();
                return;
            }
        }
        order.getItems().add(orderItem);
        order.updatePrice();
    }

    /**
     * 改变订单，如果orderItem存在，则替换数量，不存在则添加，数量<=0则移除
     *
     * @param order
     * @param orderItem
     */
    public void changeItem(Order order, OrderItem orderItem) {
        for (OrderItem item : order.getItems()) {
            if (item.getGoods().getId() == orderItem.getGoods().getId()) {
                if (orderItem.getCount() <= 0) {
                    order.getItems().remove(item);
                } else {
                    item.setCount(orderItem.getCount());
                }

                order.updatePrice();
                return;
            }
        }
        order.getItems().add(orderItem);
        order.updatePrice();
    }

    /**
     * 把订单存入数据库，user不是登录的user 而是登录的user的username和提交订单填的收货信息组成的
     *
     * @param order
     * @param user
     * @throws Exception
     */
    public void addOrder(Order order, User user) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            order.setTime(new Timestamp(new Date().getTime()));
            conn = JdbcUtil.getConnection();
            String sql = "insert into orders(time,price,username,state,phone,address,name) values (?,?,?,?,?,?,?) ";
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setTimestamp(1, order.getTime());
            ps.setFloat(2, order.getPrice());
            ps.setString(3, user.getUsername());
            ps.setInt(4, order.getState());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getName());
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                order.setId(rs.getInt(1));
            }

            JdbcUtil.free(rs, ps, null);
            List<OrderItem> orderItemList = order.getItems();
            sql = "insert into order_datail values (?,?,?) ";
            ps = conn.prepareStatement(sql);
            for (OrderItem orderItem : orderItemList) {
                ps.setInt(1, order.getId());
                ps.setInt(2, orderItem.getGoods().getId());
                ps.setInt(3, orderItem.getCount());
                ps.executeUpdate();
            }


        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
    }

    /**
     * 修改订单的状态
     *
     * @param orderId
     * @param state
     * @throws Exception
     */
    public void changeOrderState(int orderId, int state) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "update orders set state=? where id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, state);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
    }

    /*public void changeOrderState(Order order, int state) throws Exception {
        changeOrderState(order.getId(), state);
    }*/

    /**
     * 查询用户的订单记录，不包括详细的物品记录
     *
     * @param user
     * @return
     * @throws Exception
     */
    public List<Order> queryOrdersWithoutItem(User user) throws Exception {
        List<Order> list = new ArrayList<>();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "select * from orders where username=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt(1));
                order.setTime(rs.getTimestamp(2));
                order.setPrice(rs.getFloat(3));
                order.setState(rs.getInt(5));
                order.setPhone(rs.getString(6));
                order.setAddress(rs.getString(7));
                order.setName(rs.getString(8));
                list.add(order);
            }

        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        return list;
    }

    /**
     * 获取完整的订单信息，包括商品数据
     *
     * @param id
     * @return
     * @throws Exception
     */
    public Order getOrderById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "select * from orders where id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt(1));
                order.setTime(rs.getTimestamp(2));
                order.setPrice(rs.getFloat(3));
                order.setState(rs.getInt(5));
                order.setPhone(rs.getString(6));
                order.setAddress(rs.getString(7));
                order.setName(rs.getString(8));
                JdbcUtil.free(rs, ps, null);
                sql = "select * from order_datail where orderId=?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, order.getId());
                rs = ps.executeQuery();
                List<OrderItem> list = order.getItems();
                GoodsDao dao = new GoodsDao();
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setGoods(dao.findGoodsById(rs.getInt(2)));
                    item.setCount(rs.getInt(3));
                    list.add(item);
                }
                order.updatePrice();
                return order;
            }

        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        return null;
    }

    public int getOrdersCount() throws Exception {
        int count = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "select count(*) from orders";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        return count;
    }

    /**
     * 分页查询，没有区分用户。用于管理员查询
     *
     * @param pageNum
     * @param count
     * @return
     * @throws Exception
     */
    public Page<Order> queryOrdersByPage(int pageNum, int count) throws Exception {
        Page<Order> page = new Page<>();
        page.setCount(count);
        int allPageNum = (int) Math.ceil(getOrdersCount() / (float) count);
        if (allPageNum == 0) allPageNum = 1;
        page.setAllPageNum(allPageNum);
        if (pageNum > page.getAllPageNum()) pageNum = page.getAllPageNum();
        if (pageNum <= 0) pageNum = 1;
        page.setCurrentPageNum(pageNum);
        int start = (pageNum - 1) * count;
        String sql = "select * from orders limit ?,?";

        List<Order> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Order order;
        try {
            conn = JdbcUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, start);
            ps.setInt(2, count);

            rs = ps.executeQuery();
            while (rs.next()) {
                order = new Order();
                order.setId(rs.getInt(1));
                order.setTime(rs.getTimestamp(2));
                order.setPrice(rs.getFloat(3));
                order.setState(rs.getInt(5));
                order.setPhone(rs.getString(6));
                order.setAddress(rs.getString(7));
                order.setName(rs.getString(8));
                list.add(order);
            }

        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        page.setList(list);
        return page;
    }
}
