package servlet;

import dao.OrderDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ChangeOrderState")
public class ChangeOrderState extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderIdStr = req.getParameter("orderId");
        String stateStr = req.getParameter("state");

        int orderId, state;
        try {
            orderId = Integer.parseInt(orderIdStr);
            state = Integer.parseInt(stateStr);

            OrderDao dao = new OrderDao();
            dao.changeOrderState(orderId, state);


            req.getRequestDispatcher("ListMyOrders").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errMsg", "提交失败");
            req.getRequestDispatcher("listMyOrders.jsp").forward(req, resp);
        }
    }
}
