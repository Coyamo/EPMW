package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(
        urlPatterns = {"/modify.jsp",
                "/ModifyUserInfo",
                "/ListMyOrders",
                "/listMyOrders.jsp",
                "/createOrder.jsp",
                "/CreateOrder",
                "/OrderDetail",
                "/orderDetail.jsp",
                "/ChangeOrderStatus"
        })
public class UserLoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;

        if (httpServletRequest.getSession().getAttribute("user") == null) {
            httpServletResponse.sendRedirect("login.jsp");
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }

    }
}
