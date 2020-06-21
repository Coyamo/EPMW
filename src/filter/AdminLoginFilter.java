package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebFilter(
        urlPatterns = {"/goodManagerAdmin.jsp",
                "/UpdateGoods",
                "/ShowAllGoods",
                "/orderManagerAdmin.jsp",
                "/modifyAdmin.jsp",
                "/ModifyAdminInfo",
                "/ManageOrders",
                "/manageOrdersAdmin.jsp",
                "/OrderDetailAdmin",
                "/ChangeOrderStateAdmin",
                "/orderDetailAdmin.jsp",
        })
public class AdminLoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;

        if ("/ShowAllGoods".equals(httpServletRequest.getServletPath())) {
            if (!"admin".equals(httpServletRequest.getParameter("type"))) {
                filterChain.doFilter(servletRequest, servletResponse);
                return;
            }
        }
        if (httpServletRequest.getSession().getAttribute("admin") == null) {
            httpServletResponse.sendRedirect("admin.jsp");
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }

    }
}
