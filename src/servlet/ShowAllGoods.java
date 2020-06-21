package servlet;

import dao.GoodsDao;
import vo.Goods;
import vo.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ShowAllGoods")
public class ShowAllGoods extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageNum = 1;

        String pageNumStr = req.getParameter("pageNum");
        try {
            pageNum = Integer.parseInt(pageNumStr);
            if (pageNum < 1) pageNum = 1;
        } catch (Exception e) {

        }
        GoodsDao dao = new GoodsDao();
        //int count = 5;
        try {
            String type = req.getParameter("type");
            if ("admin".equals(type)) {
                Page<Goods> page = dao.queryGoodsByPage(pageNum, 5, Goods.ALL);
                req.setAttribute("page", page);
                req.getRequestDispatcher("goodManagerAdmin.jsp").forward(req, resp);
            } else {
                Page<Goods> page = dao.queryGoodsByPage(pageNum, 15, Goods.SHELVE);
                req.setAttribute("page", page);
                req.getRequestDispatcher("main.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
