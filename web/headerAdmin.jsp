<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=no"/>
    <link rel="stylesheet" href="css/mdui.min.css">
    <script src="js/mdui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/default.css">
</head>

<body class="mdui-appbar-with-toolbar mdui-appbar-with-tab">
<div class="mdui-appbar mdui-appbar-fixed">
    <div class="mdui-toolbar mdui-color-indigo">
        <a href="javascript:void(0)" class="mdui-typo-title">伊品美味网络订餐管理系统</a>
        <div class="mdui-toolbar-spacer"></div>
        <c:if test="${!empty sessionScope.admin}">
            <a mdui-tooltip="{content: '注销'}" href="Logout?type=admin" class="mdui-btn mdui-btn-icon"><i
                    class="mdui-icon material-icons">&#xe879;</i></a>
        </c:if>
    </div>
    <c:if test="${!empty sessionScope.admin}">
        <div class="mdui-color-indigo" style="text-align: right">
            <a href="ShowAllGoods?type=admin" class="mdui-btn">菜品管理</a>
            <a href="ManageOrders" class="mdui-btn">订单管理</a>
            <a href="modifyAdmin.jsp" class="mdui-btn">修改密码</a>
        </div>
    </c:if>
</div>
</body>
</html>
