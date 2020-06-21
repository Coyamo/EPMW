package dao;

import utils.JdbcUtil;
import vo.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDao {

    public void changePassword(Admin admin, String pwd) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "update admin set password=? where name=? ";
            ps = conn.prepareStatement(sql);
            ps.setString(1, pwd);
            ps.setString(2, admin.getName());
            ps.executeUpdate();
        } finally {
            JdbcUtil.free(null, ps, conn);
        }
    }

    public Admin findAdminByName(String name) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Admin admin = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "select * from admin where name=? ";
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            rs = ps.executeQuery();
            if (rs.next()) {
                admin = new Admin();
                admin.setName(rs.getString(1));
                admin.setPassword(rs.getString(2));
            }
        } finally {
            JdbcUtil.free(rs, ps, conn);
        }
        return admin;
    }

    public Admin login(String name, String password) throws Exception {
        Admin admin = findAdminByName(name);
        if (admin == null) return null;
        if (admin.getPassword().equals(password)) {
            return admin;
        }
        return null;
    }
}
