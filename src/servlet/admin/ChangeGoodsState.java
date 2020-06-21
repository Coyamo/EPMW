package servlet.admin;

import dao.GoodsDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ChangeGoodsState")
public class ChangeGoodsState extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    //ajax 调用
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String stateStr = req.getParameter("state");
        int id, state;
        try {
            id = Integer.parseInt(idStr);
            state = Integer.parseInt(stateStr);
            GoodsDao dao = new GoodsDao();
            dao.changeState(id, state);
            resp.getWriter().write("ok");
        } catch (Exception e) {
            resp.getWriter().write("err");
        }
    }

}
