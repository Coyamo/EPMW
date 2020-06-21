package servlet;

import dao.OrderDao;
import utils.StringUtil;
import vo.Order;
import vo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/CreateOrder")
public class CreateOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Order order = (Order) req.getSession().getAttribute("order");
        if (order == null || order.getItems().size() == 0) {
            req.setAttribute("state", 2);
            req.getRequestDispatcher("createOrder.jsp").forward(req, resp);
            return;
        }

        OrderDao dao = new OrderDao();
        try {
            String phone = req.getParameter("phone");
            String name = req.getParameter("name");
            String address = req.getParameter("address");
            if (StringUtil.hasEmpty(phone, name, address)) {
                req.setAttribute("state", 3);
                req.setAttribute("errMsg", "请完善基收获信息！");
                req.getRequestDispatcher("createOrder.jsp").forward(req, resp);
                return;
            }
            User user = (User) req.getSession().getAttribute("user");

            User user1 = new User();
            user1.setName(name);
            user1.setAddress(address);
            user1.setPhoneNumber(phone);
            user1.setUsername(user.getUsername());


            dao.addOrder(order, user1);
            req.getSession().setAttribute("order", null);
            req.setAttribute("state", 1);
            req.getRequestDispatcher("createOrder.jsp").forward(req, resp);
            return;
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("state", 3);
            req.setAttribute("errMsg", "创建订单失败");
            req.getRequestDispatcher("createOrder.jsp").forward(req, resp);
            return;
        }
    }
}
