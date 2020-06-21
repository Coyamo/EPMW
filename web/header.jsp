<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" type="text/css" href="css/default.css">
<!--
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=no"/>
-->
<link rel="stylesheet" href="css/mdui.min.css">
<script src="js/mdui.min.js"></script>


<body class="mdui-appbar-with-toolbar">
<div class="mdui-appbar mdui-appbar-fixed mdui-shadow-0">
    <div class="mdui-toolbar " style="background-color:rgba(245,245,245,0.8)">
        <a href="javascript:void(0)" class="mdui-typo-title">伊品美味</a>
        <div class="mdui-toolbar-spacer"></div>

        <c:choose>
            <c:when test="${!empty sessionScope.user}">

                <div class="mdui-btn">
                    <span class="mdui-chip-icon mdui-color-blue"><i class="mdui-icon material-icons">&#xe87c;</i></span>
                    <span class="mdui-chip-title">${sessionScope.user.username}</span>
                </div>
                <a class="mdui-btn mdui-ripple" href="ListMyOrders">我的订单</a>
                <a class="mdui-btn mdui-ripple" href="modify.jsp">修改个人资料</a>
                <a class="mdui-btn mdui-ripple" href="Logout?type=user">退出登录</a>
            </c:when>
            <c:otherwise>
                <a class="mdui-btn mdui-ripple" href="login.jsp">登录</a>
                <a class="mdui-btn mdui-ripple" href="register.jsp">注册</a>
            </c:otherwise>
        </c:choose>
        <a class="mdui-btn mdui-ripple" href="ShowAllGoods?type=user">商品浏览</a>
        <a class="mdui-btn mdui-ripple" href="showCart.jsp">我的购物车</a>
    </div>
</div>
</body>
