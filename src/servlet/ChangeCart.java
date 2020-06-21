package servlet;

import dao.GoodsDao;
import dao.OrderDao;
import vo.Goods;
import vo.Order;
import vo.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ChangeCart")
public class ChangeCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String countStr = req.getParameter("count");
        Order order = (Order) req.getSession().getAttribute("order");
        if (order == null) {
            order = new Order();
            req.getSession().setAttribute("order", order);
        }
        int id, count;
        try {
            id = Integer.parseInt(idStr);
            count = Integer.parseInt(countStr);

            GoodsDao goodsDao = new GoodsDao();
            Goods goods = goodsDao.findGoodsById(id);
            OrderDao orderDao = new OrderDao();
            OrderItem orderItem = new OrderItem();
            orderItem.setGoods(goods);
            orderItem.setCount(count);

            orderDao.changeItem(order, orderItem);
            resp.getWriter().write(String.valueOf(order.getPrice()));
            if (count == 0) {
                req.getRequestDispatcher("showCart.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            resp.getWriter().write("err");
        }
    }
}
