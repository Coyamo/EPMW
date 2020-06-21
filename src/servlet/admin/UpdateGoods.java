package servlet.admin;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;
import dao.GoodsDao;
import utils.StringUtil;
import vo.Goods;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/UpdateGoods")
public class UpdateGoods extends HttpServlet {

    @Override
    public void init() throws ServletException {
        Map<String, String> m1 = new HashMap<>();
        this.getServletContext().setAttribute("ipsno", m1);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String saveDirectory = getServletContext().getRealPath("images");
        File saveDir = new File(saveDirectory);
        if (!saveDir.exists()) {
            saveDir.mkdirs();
        }
        int maxPostSize = 3 * 1024 * 1024; // 总上传大小限制：3M
        FileRenamePolicy policy = new DefaultFileRenamePolicy();
        MultipartRequest multi = new MultipartRequest(req, saveDirectory, maxPostSize, "utf-8", policy);

        String type = multi.getParameter("type");
        switch (type) {
            case "1":
                doAddGoods(multi, req, resp);
                return;
            case "2":
                doModifyGoods(multi, req, resp);
        }


    }

    //ajax 请求
    private void doModifyGoods(MultipartRequest multi, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //req.setAttribute("isOk", false);
        //req.setAttribute("isServletMsg", true);
        String name = multi.getParameter("name");
        String priceStr = multi.getParameter("price");
        String description = multi.getParameter("description");
        String idStr = multi.getParameter("id");

        req.setAttribute("id", idStr);
        req.setAttribute("name", name);
        req.setAttribute("price", priceStr);
        req.setAttribute("description", description);

        if (StringUtil.isEmpty(name)) {
            resp.getWriter().write("名字不能为空");
            return;
        }

        if (StringUtil.isEmpty(description)) {
            resp.getWriter().write("描述不能为空");
            return;
        }


        int id;
        float price;
        try {
            id = Integer.parseInt(idStr);
            GoodsDao dao = new GoodsDao();
            Goods goods = dao.findGoodsById(id);
            if (goods != null) {
                try {
                    price = Float.parseFloat(priceStr);
                    goods.setName(name);
                    goods.setPrice(price);
                    goods.setDescription(description);

                    Enumeration<String> files = multi.getFileNames();
                    String filename = files.nextElement();
                    File file = multi.getFile(filename);

                    if (file != null) {
                        goods.setImage(file.getName());
                        dao.clearOldImg(getServletContext(), id);
                    }
                    dao.update(goods);
                    resp.getWriter().write("ok");
                    return;
                } catch (Exception e) {
                    resp.getWriter().write("请输入正确的价格");
                    return;
                }

            } else {
                resp.getWriter().write("修改信息失败：错误的id");
                return;
            }
        } catch (Exception e) {
            resp.getWriter().write("修改信息失败：获取id失败");
            return;
        }
    }

    //ajax 请求
    private void doAddGoods(MultipartRequest multi, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = multi.getParameter("name");
        String priceStr = multi.getParameter("price");
        String description = multi.getParameter("description");

        req.setAttribute("name", name);
        req.setAttribute("price", priceStr);
        req.setAttribute("description", description);

        float price;

        req.setAttribute("isOk", false);
        if (StringUtil.isEmpty(name)) {
            resp.getWriter().write("名字不能为空");
            return;
        }

        try {
            price = Float.parseFloat(priceStr);
        } catch (Exception e) {
            resp.getWriter().write("请输入正确的价格");
            return;
        }

        if (StringUtil.isEmpty(description)) {
            resp.getWriter().write("描述不能为空");
            return;
        }

        Goods goods = new Goods();
        goods.setState(Goods.SHELVE);
        goods.setDescription(description);
        goods.setPrice(price);
        goods.setName(name);

        Enumeration<String> files = multi.getFileNames();

        String filename = files.nextElement();
        File file = multi.getFile(filename);
        if (file != null) {
            goods.setImage(file.getName());
        }
        GoodsDao dao = new GoodsDao();
        try {
            dao.addGoods(goods);
        } catch (Exception e) {
            resp.getWriter().write("添加失败:" + e);
            e.printStackTrace();
            return;
        }

        resp.getWriter().write("ok");
    }

    /*
    private void doModifyGoods(MultipartRequest multi, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("isOk", false);
        req.setAttribute("isServletMsg", true);
        String name = multi.getParameter("name");
        String priceStr = multi.getParameter("price");
        String description = multi.getParameter("description");
        String idStr = multi.getParameter("id");

        req.setAttribute("id", idStr);
        req.setAttribute("name", name);
        req.setAttribute("price", priceStr);
        req.setAttribute("description", description);

        if (StringUtil.isEmpty(name)) {
            req.setAttribute("errMsg", "名字不能为空");
            req.getRequestDispatcher("modifyGoods.jsp").forward(req, resp);
            return;
        }

        if (StringUtil.isEmpty(description)) {
            req.setAttribute("errMsg", "描述不能为空");
            req.getRequestDispatcher("modifyGoods.jsp").forward(req, resp);
            return;
        }


        int id;
        float price;
        try {
            id = Integer.parseInt(idStr);
            GoodsDao dao = new GoodsDao();
            Goods goods = dao.findGoodsById(id);
            if (goods != null) {
                try {
                    price = Float.parseFloat(priceStr);
                    goods.setName(name);
                    goods.setPrice(price);
                    goods.setDescription(description);

                    Enumeration<String> files = multi.getFileNames();
                    String filename = files.nextElement();
                    File file = multi.getFile(filename);

                    if (file != null) {
                        goods.setImage(file.getName());
                        dao.clearOldImg(getServletContext(), id);
                    }
                    dao.update(goods);
                    req.setAttribute("isOk", true);
                    req.getRequestDispatcher("modifyGoods.jsp").forward(req, resp);
                    return;
                } catch (Exception e) {
                    req.setAttribute("errMsg", "请输入正确的价格");
                    req.getRequestDispatcher("modifyGoods.jsp").forward(req, resp);
                    return;
                }

            } else {
                req.setAttribute("errMsg", "修改信息失败：错误的id");
                req.getRequestDispatcher("ShowAllGoods").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("errMsg", "修改信息失败：获取id失败");
            req.getRequestDispatcher("ShowAllGoods").forward(req, resp);
            return;
        }
        return;
    }


        private void doAddGoods(MultipartRequest multi, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = multi.getParameter("name");
        String priceStr = multi.getParameter("price");
        String description = multi.getParameter("description");

        req.setAttribute("name", name);
        req.setAttribute("price", priceStr);
        req.setAttribute("description", description);

        float price;

        req.setAttribute("isOk", false);
        if (StringUtil.isEmpty(name)) {
            req.setAttribute("errMsg", "名字不能为空");
            req.getRequestDispatcher("addGoods.jsp").forward(req, resp);
            return;
        }

        try {
            price = Float.parseFloat(priceStr);
        } catch (Exception e) {
            req.setAttribute("errMsg", "请输入正确的价格");
            req.getRequestDispatcher("addGoods.jsp").forward(req, resp);
            return;
        }

        if (StringUtil.isEmpty(description)) {
            req.setAttribute("errMsg", "描述不能为空");
            req.getRequestDispatcher("addGoods.jsp").forward(req, resp);
            return;
        }

        Goods goods = new Goods();
        goods.setState(Goods.SHELVE);
        goods.setDescription(description);
        goods.setPrice(price);
        goods.setName(name);

        Enumeration<String> files = multi.getFileNames();

        String filename = files.nextElement();
        File file = multi.getFile(filename);
        if (file != null) {
            goods.setImage(file.getName());
        }
        GoodsDao dao = new GoodsDao();
        try {
            dao.addGoods(goods);
        } catch (Exception e) {
            req.setAttribute("errMsg", "添加失败");
            req.getRequestDispatcher("addGoods.jsp").forward(req, resp);
            e.printStackTrace();
            return;
        }

        req.setAttribute("isOk", true);
        req.getRequestDispatcher("addGoods.jsp").forward(req, resp);
    }

    */
}
