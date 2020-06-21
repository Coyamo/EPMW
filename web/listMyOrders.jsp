<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的订单</title>
    <style type="text/css">
        td {
            text-align: center;
        }
    </style>
    <c:if test="${!empty errMsg}">
        <script>
            window.onload = function () {
                mdui.alert('${errMsg}', '错误');
            }
        </script>
    </c:if>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="mdui-container">

    <br>
    <h2 style="text-align: center"> 我的订单 </h2>
    <div class="mdui-divider"></div>
    <br>
    <div class="mdui-table-fluid">
        <table class="mdui-table mdui-table-hoverable">
            <thead>
            <tr>
                <th>订单编号</th>
                <th>下单时间</th>
                <th>订单金额</th>
                <th>收货人</th>
                <th>订单状态</th>
                <th>查看订单详情</th>
                <th>操作</th>
            </tr>
            </thead>

            <c:set var="arrayvalue" value="未付款,待派送,正在派送,已签收"/>
            <c:set var="arrayvalue2" value="mdui-color-yellow,mdui-color-red,mdui-color-blue,mdui-color-green"/>
            <c:set var="delim" value=","/>
            <c:set var="array" value="${fn:split(arrayvalue, delim)}"/>
            <c:set var="array2" value="${fn:split(arrayvalue2, delim)}"/>
            <tbody>
            <c:forEach var="item" items="${requestScope.myOrders}">
                <tr>
                    <td>${item.id}</td>
                    <td>${item.time}</td>
                    <td>${item.price}</td>
                    <td>${item.name}</td>
                    <td>
                        <div class="mdui-chip">
                            <span id="state_color_${item.id}" class="mdui-chip-icon ${array2[item.state] }"></span>
                            <span id="state_${item.id}" class="mdui-chip-title">${array[item.state] }</span>
                        </div>
                    </td>
                    <td><a class="mdui-btn mdui-btn-dense mdui-btn-raised mdui-ripple"
                           href="OrderDetail?orderId=${item.id}">查看</a></td>
                    <td>
                        <c:if test="${item.state==0}">
                            <a class="mdui-btn mdui-btn-dense mdui-btn-raised mdui-ripple"
                               href="ChangeOrderState?orderId=${item.id}&state=1">付款</a>
                        </c:if>
                        <c:if test="${item.state==2}">
                            <a class="mdui-btn mdui-btn-dense mdui-btn-raised mdui-ripple"
                               href="ChangeOrderState?orderId=${item.id}&state=3">签收</a>
                        </c:if>

                    </td>
                </tr>
            </c:forEach>
            </tbody>


        </table>
    </div>
</div>
</body>
</html>
