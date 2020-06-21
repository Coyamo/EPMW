package servlet.admin;

import dao.OrderDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ChangeOrderStateAdmin")
public class ChangeOrderStateAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    //ajax 调用
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


            resp.getWriter().write("ok");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("err");
        }
    }
}
