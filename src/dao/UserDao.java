package dao;

import utils.JdbcUtil;
import vo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {
    public void register(User user) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "insert into user values (?,?,?,?,?) ";
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getName());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPhoneNumber());
            ps.executeUpdate();
        } finally {
            JdbcUtil.free(null, ps, conn);
        }
    }

    public void update(User user) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "update user set name=?,password=?,address=?,phoneNumber=? where username=? ";
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getPhoneNumber());
            ps.setString(5, user.getUsername());
            ps.executeUpdate();
        } finally {
            JdbcUtil.free(null, ps, conn);
        }
    }

    /*
    public void delete(String username) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "delete from user where username=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.executeUpdate();
        } finally {
            JdbcUtil.free(null, ps, conn);
        }
    }*/

    public User findUserByUsername(String username) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        User user = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "select * from user where username=? ";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString(1));
                user.setName(rs.getString(2));
                user.setPassword(rs.getString(3));
                user.setAddress(rs.getString(4));
                user.setPhoneNumber(rs.getString(5));

            }
        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        return user;
    }

    public User login(String username, String password) throws Exception {
        User user = findUserByUsername(username);
        if (user == null) return null;
        if (user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
