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

@WebServlet("/AddCart")
public class AddCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Order order = (Order) req.getSession().getAttribute("order");
        if (order == null) {
            order = new Order();
            req.getSession().setAttribute("order", order);
        }

        String idStr = req.getParameter("id");
        int id;
        try {
            id = Integer.parseInt(idStr);

            OrderDao orderDao = new OrderDao();
            GoodsDao goodsDao = new GoodsDao();
            Goods goods = goodsDao.findGoodsById(id);

            OrderItem orderItem = new OrderItem();
            orderItem.setGoods(goods);
            orderItem.setCount(1);

            orderDao.addItem(order, orderItem);
            resp.getWriter().write("ok");
        } catch (Exception e) {
            resp.getWriter().write("err");
        }

    }
}
