package dao;

import utils.JdbcUtil;
import vo.Goods;
import vo.Page;

import javax.servlet.ServletContext;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GoodsDao {
    public void addGoods(Goods goods) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "insert into goods(name,price,description,image,state) values (?,?,?,?,?) ";
            ps = conn.prepareStatement(sql);
            ps.setString(1, goods.getName());
            ps.setFloat(2, goods.getPrice());
            ps.setString(3, goods.getDescription());
            ps.setString(4, goods.getImage());
            ps.setInt(5, goods.getState());
            ps.executeUpdate();
        } finally {
            JdbcUtil.free(null, ps, conn);
        }
    }

    public void changeState(int id, int state) throws Exception {
        Goods goods = findGoodsById(id);
        goods.setState(state);
        update(goods);
    }

    public void update(Goods goods) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "update goods set name=?,price=?,description=?,image=?,state=? where id=? ";
            ps = conn.prepareStatement(sql);
            ps.setString(1, goods.getName());
            ps.setFloat(2, goods.getPrice());
            ps.setString(3, goods.getDescription());
            ps.setString(4, goods.getImage());
            ps.setInt(5, goods.getState());
            ps.setInt(6, goods.getId());
            ps.executeUpdate();
        } finally {
            JdbcUtil.free(null, ps, conn);
        }
    }

    public void clearOldImg(ServletContext ctx, int id) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String image = null;
        try {
            String sql = "select image from goods where id=?";
            conn = JdbcUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                image = rs.getString(1);
            }

        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        String path = ctx.getRealPath("images");
        if (image != null && !"default.jpg".equalsIgnoreCase(image)) {
            File f = new File(path, image);
            if (f.exists()) {
                f.delete();
            }
        }

    }

    public void delete(int id) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "delete from goods where id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } finally {
            JdbcUtil.free(null, ps, conn);
        }
    }

    public Page<Goods> queryGoodsByPage(int pageNum, int count, int state) throws Exception {
        Page<Goods> page = new Page<>();
        page.setCount(count);
        int allPageNum = (int) Math.ceil(getGoodsCount(state) / (float) count);
        if (allPageNum == 0) allPageNum = 1;
        page.setAllPageNum(allPageNum);
        if (pageNum > page.getAllPageNum()) pageNum = page.getAllPageNum();
        if (pageNum <= 0) pageNum = 1;
        page.setCurrentPageNum(pageNum);

        int start = (pageNum - 1) * count;
        String sql;
        if (state != 2) {
            sql = "select * from goods where state=? limit ?,?";
        } else {
            sql = "select * from goods limit ?,?";
        }


        List<Goods> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Goods goods;
        try {
            conn = JdbcUtil.getConnection();
            ps = conn.prepareStatement(sql);
            if (state != 2) {
                ps.setInt(1, state);
                ps.setInt(2, start);
                ps.setInt(3, count);
            } else {
                ps.setInt(1, start);
                ps.setInt(2, count);
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                goods = new Goods();
                goods.setId(rs.getInt(1));
                goods.setName(rs.getString(2));
                goods.setPrice(rs.getFloat(3));
                goods.setDescription(rs.getString(4));
                goods.setImage(rs.getString(5));
                goods.setState(rs.getInt(6));
                list.add(goods);
            }

        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        page.setList(list);
        return page;
    }

    public int getGoodsCount(int state) throws Exception {
        int count = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql;
            if (state != 2) {
                sql = "select count(*) from goods where state=?";
            } else {
                sql = "select count(*) from goods";
            }

            ps = conn.prepareStatement(sql);
            if (state != 2) {
                ps.setInt(1, state);
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        return count;
    }

    /*
        public List<Goods> queryAllGoods() throws Exception {
            List<Goods> list = new ArrayList<>();
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            Goods goods;
            try {
                conn = JdbcUtil.getConnection();
                String sql = "select * from goods";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    goods = new Goods();
                    goods.setId(rs.getInt(1));
                    goods.setName(rs.getString(2));
                    goods.setPrice(rs.getFloat(3));
                    goods.setDescription(rs.getString(4));
                    goods.setImage(rs.getString(5));
                    goods.setState(rs.getInt(6));
                    list.add(goods);
                }

            } finally {
                JdbcUtil.free(rs, ps, conn);
            }
            return list;
        }
    */
    public Goods findGoodsById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Goods goods = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "select * from goods where id=? ";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                goods = new Goods();
                goods.setId(rs.getInt(1));
                goods.setName(rs.getString(2));
                goods.setPrice(rs.getFloat(3));
                goods.setDescription(rs.getString(4));
                goods.setImage(rs.getString(5));
                goods.setState(rs.getInt(6));
            }
        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        return goods;
    }


}
