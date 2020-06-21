package servlet;

import dao.OrderDao;
import vo.Order;
import vo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListMyOrders")
public class ListMyOrders extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderDao dao = new OrderDao();
        User user = (User) req.getSession().getAttribute("user");
        try {
            List<Order> list = dao.queryOrdersWithoutItem(user);
            req.setAttribute("myOrders", list);
            req.getRequestDispatcher("listMyOrders.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errMsg", "查询失败");
            req.getRequestDispatcher("listMyOrders.jsp").forward(req, resp);
        }
    }
}
