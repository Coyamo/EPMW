<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单详情</title>
</head>
<body>
<jsp:include page="headerAdmin.jsp"/>
<div class="mdui-container">
    <br>
    <h2 style="text-align: center"> 订单详情 </h2>
    <div class="mdui-divider"></div>
    <br>
    <span style="color: red; ">${errMsg}</span>
    <div class="mdui-table-fluid">
        <table class="mdui-table mdui-table-hoverable">
            <thead class="mdui-color-blue-200">
            <tr>
                <th>订单编号：</th>
                <th>下单时间</th>
                <th>订单金额</th>
                <th>收货人</th>
                <th>收货地址</th>
                <th>联系电话</th>
                <th>订单状态</th>
            </tr>
            </thead>
            <c:set var="arrayvalue" value="未付款,待派送,正在派送,已签收"/>
            <c:set var="arrayvalue2" value="mdui-color-yellow,mdui-color-red,mdui-color-blue,mdui-color-green"/>
            <c:set var="delim" value=","/>
            <c:set var="array" value="${fn:split(arrayvalue, delim)}"/>
            <c:set var="array2" value="${fn:split(arrayvalue2, delim)}"/>
            <tbody>
            <tr>
                <td>${requestScope.order.id}</td>
                <td>${requestScope.order.time}</td>
                <td id="order_price" align="center">${requestScope.order.price}</td>
                <td>${requestScope.order.name}</td>
                <td>${requestScope.order.address}</td>
                <td>${requestScope.order.phone}</td>
                <td>
                    <div class="mdui-chip">
                        <span class="mdui-chip-icon ${array2[requestScope.order.state] }"></span>
                        <span class="mdui-chip-title">${array[requestScope.order.state] }</span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <br>
        <table class="mdui-table mdui-table-hoverable">
            <thead class="mdui-color-blue-200">
            <tr>
                <th>序号</th>
                <th>菜品名称</th>
                <th>菜品价格</th>
                <th>数量</th>
                <th>小计</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${requestScope.order.items}">
                <tr>
                    <td>${item.goods.id}</td>
                    <td>${item.goods.name}</td>
                    <td>${item.goods.price}</td>
                    <td>${item.count}</td>
                    <td>${item.price}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        //解决进度丢失的问题
        Math.formatFloat = function (f, digit) {
            var m = Math.pow(10, digit);
            return parseInt(f * m, 10) / m;
        };
        //没有设置的位置还是会丢失精度 懒得搞了
        window.onload = function () {
            var element = document.getElementById("total");
            element.innerHTML = "合计： &nbsp;&nbsp;" + Math.formatFloat(${requestScope.order.price}, 1) + "元"; //更新总计
            var element2 = document.getElementById("order_price");
            element2.innerHTML = Math.formatFloat(${requestScope.order.price}, 1);

        }
    </script>
    <br>
    <div style="text-align: right">
        <div class="mdui-chip">
            <span class="mdui-chip-icon mdui-color-amber"><i class="mdui-icon material-icons">&#xe227;</i></span>
            <span id="total" class="mdui-chip-title">0</span>
        </div>
    </div>
    <a mdui-tooltip="{content: '返回'}" href="ManageOrders"
       class="mdui-fab mdui-fab-fixed  mdui-ripple mdui-color-pink-accent"><i
            class="mdui-icon material-icons">&#xe5c4;</i></a>


</div>
</body>
</html>
