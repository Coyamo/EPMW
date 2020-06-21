package servlet.admin;

import dao.AdminDao;
import vo.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LoginAdmin")
public class LoginAdmin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String password = req.getParameter("password");

        AdminDao dao = new AdminDao();
        try {
            Admin admin = dao.login(name, password);
            if (admin == null) {
                req.setAttribute("errMsg", "管理员不存在或密码错误");
                req.getRequestDispatcher("admin.jsp").forward(req, resp);
                return;
            }

            req.getSession().setAttribute("admin", admin);
            req.getRequestDispatcher("ManageOrders").forward(req, resp);
            return;
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errMsg", "登录错误");
        }
        req.getRequestDispatcher("admin.jsp").forward(req, resp);
    }
}
