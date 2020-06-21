package servlet.admin;

import dao.OrderDao;
import vo.Order;
import vo.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ManageOrders")
public class ManageOrders extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNum = 1;
        int count = 8;
        String pageNumStr = req.getParameter("pageNum");
        try {
            pageNum = Integer.parseInt(pageNumStr);
            if (pageNum < 1) pageNum = 1;
        } catch (Exception e) {
        }
        OrderDao dao = new OrderDao();
        Page<Order> page = null;
        try {
            page = dao.queryOrdersByPage(pageNum, count);
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.setAttribute("page", page);
        req.getRequestDispatcher("orderManagerAdmin.jsp").forward(req, resp);
    }
}
