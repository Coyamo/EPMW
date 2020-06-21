package servlet;

import dao.UserDao;
import utils.StringUtil;
import vo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ModifyUserInfo")
public class ModifyUserInfo extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String password2 = req.getParameter("password2");
        String address = req.getParameter("address");
        String phoneNumber = req.getParameter("phoneNumber");

        if (StringUtil.hasEmpty(password, password2)) {
            req.setAttribute("errMsg", "密码不能为空");
            req.getRequestDispatcher("modify.jsp").forward(req, resp);
            return;
        }
        if (!password.equals(password2)) {
            req.setAttribute("errMsg", "密码不一致");
            req.getRequestDispatcher("modify.jsp").forward(req, resp);
            return;
        }

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            req.setAttribute("errMsg", "请重新登录");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        user.setPhoneNumber(phoneNumber);
        user.setPassword(password);
        user.setAddress(address);
        user.setName(name);

        UserDao dao = new UserDao();

        try {
            dao.update(user);
            req.setAttribute("errMsg", "个人信息修改成功，请重新登录!");
            req.getSession().setAttribute("user", null);
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        } catch (Exception e) {
            req.setAttribute("errMsg", "修改失败");
            e.printStackTrace();
        }
        req.getRequestDispatcher("modify.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
