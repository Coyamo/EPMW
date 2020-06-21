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

@WebServlet("/Register")
public class Register extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String name = req.getParameter("name");
        String password = req.getParameter("password");
        String password2 = req.getParameter("password2");
        String address = req.getParameter("address");
        String phoneNumber = req.getParameter("phoneNumber");
        String checkCode = req.getParameter("checkCode");

        req.setAttribute("username", username);
        req.setAttribute("name", name);
        req.setAttribute("password", password);
        req.setAttribute("password2", password2);
        req.setAttribute("address", address);
        req.setAttribute("phoneNumber", phoneNumber);

        UserDao dao = new UserDao();

        try {
            if (StringUtil.isEmpty(username)) {
                req.setAttribute("errMsg", "用户名不能为空");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }

            if (dao.findUserByUsername(username) != null) {
                req.setAttribute("errMsg", "用户名已经被注册");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }
            if (StringUtil.hasEmpty(password, password2)) {
                req.setAttribute("errMsg", "密码不能为空");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }
            if (!password.equals(password2)) {
                req.setAttribute("errMsg", "密码不一致");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }

            if (!CheckCode.validateCode(req, checkCode)) {
                req.setAttribute("errMsg", "验证码错误");
                req.getRequestDispatcher("register.jsp").forward(req, resp);
                return;
            }


            User user = new User();
            user.setUsername(username);
            user.setName(name);
            user.setPassword(password);
            user.setAddress(address);
            user.setPhoneNumber(phoneNumber);

            dao.register(user);
            req.setAttribute("isSuccess", "true");
        } catch (Exception e) {
            req.setAttribute("errMsg", "出现错误");
            e.printStackTrace();
        }
        req.getRequestDispatcher("register.jsp").forward(req, resp);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
