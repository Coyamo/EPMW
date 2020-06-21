package servlet;

import dao.OrderDao;
import vo.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/OrderDetail")
public class OrderDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderIdStr = req.getParameter("orderId");
        int orderId;
        try {
            orderId = Integer.parseInt(orderIdStr);
            OrderDao dao = new OrderDao();
            Order order = dao.getOrderById(orderId);
            req.setAttribute("order", order);
            req.getRequestDispatcher("orderDetail.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errMsg", "获取参数错误");
            req.getRequestDispatcher("orderDetail.jsp").forward(req, resp);
        }
    }
}
