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

@WebServlet("/Login")
public class Login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String checkCode = req.getParameter("checkCode");

        req.setAttribute("username", username);
        req.setAttribute("password", password);

        if (StringUtil.isEmpty(username)) {
            req.setAttribute("errMsg", "用户名不能为空");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        if (StringUtil.isEmpty(password)) {
            req.setAttribute("errMsg", "密码不能为空");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        if (!CheckCode.validateCode(req, checkCode)) {
            req.setAttribute("errMsg", "验证码错误");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        UserDao dao = new UserDao();
        try {
            User user = dao.login(username, password);
            if (user == null) {
                req.setAttribute("errMsg", "用户不存在或密码错误");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                return;
            }
            req.getSession().setAttribute("user", user);
            req.getRequestDispatcher("main.jsp").forward(req, resp);
            return;
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errMsg", "登录错误");
        }
        req.getRequestDispatcher("main.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
