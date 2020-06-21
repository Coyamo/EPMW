<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的购物车</title>

    <script type="text/javascript">
        //解决进度丢失的问题
        Math.formatFloat = function (f, digit) {
            var m = Math.pow(10, digit);
            return parseInt(f * m, 10) / m;
        };

        function del() {
            var msg = "您真的确定要删除吗？";
            return confirm(msg);
        }

        function changeProductNum(id, op, price) {
            var x = Number(document.getElementById(id).value);

            if (op == "-" && x <= 1)
                return;
            var count = 0;
            if (op == "-")
                count = x - 1;
            else
                count = x + 1;
            var url = "ChangeCart?id=" + id + "&count=" + count;
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    document.getElementById(id).value = count;  //更新数量
                    var idTotal = "total" + id;
                    document.getElementById(idTotal).innerHTML = Math.formatFloat(price * count, 1); //更新小计
                    var y = document.getElementById("sum");
                    y.innerHTML = Math.formatFloat(xmlhttp.responseText, 1); //更新总计
                }
            };
            xmlhttp.open("post", url, true);
            xmlhttp.send();
        }

        window.onload = function () {
            var element = document.getElementById("sum");
            element.innerHTML = Math.formatFloat(${sessionScope.order.price==null?0:sessionScope.order.price}, 1); //更新总计
        }
    </script>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="mdui-container">
    <br>
    <h2 style="text-align: center"> 购物车详情 </h2>
    <div class="mdui-divider"></div>
    <br>
    <div class="mdui-table-fluid">
        <table class="mdui-table mdui-table-hoverable">
            <thead>
            <tr>
                <th width="10%">序号</th>
                <th width="30%">菜品名称</th>
                <th width="10%">菜品价格</th>
                <th width="30%">数量</th>
                <th width="10%">小计</th>
                <th width="10%">删除</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${sessionScope.order.items}" varStatus="status">
                <tr>
                    <td>${status.index+1}</td>
                    <td>${item.goods.name}</td>
                    <td>${item.goods.price}</td>
                    <td><input type="button" value="-" style="width:20px"
                               onclick="changeProductNum('${item.goods.id}','-','${item.goods.price}')">
                        <input type="text" id="${item.goods.id}" name="count" value="${item.count}"
                               style="width:40px;text-align:center" disabled>
                        <input type="button" value="+" style="width:20px"
                               onclick="changeProductNum('${item.goods.id}','+','${item.goods.price}')"></td>
                    <td><span id="total${item.goods.id}">${item.price}</span></td>
                    <td><a class="mdui-btn mdui-btn-dense mdui-btn-raised mdui-ripple"
                           href="ChangeCart?id=${item.goods.id}&count=0"
                           onclick="return del()">删除</a></td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>
    <div style="text-align: right">
        <div class="mdui-chip" style="margin-top: 20px;margin-bottom: 20px">
            <span class="mdui-chip-icon mdui-color-amber"><i class="mdui-icon material-icons">&#xe227;</i></span>
            <span id="total" class="mdui-chip-title">合计:<span id="sum">0</span>元</span>
        </div>
        <br>
        <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-pink-accent" href="main.jsp">继续购物</a> &nbsp;&nbsp;
        &nbsp;
        <a class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-pink-accent" href="createOrder.jsp">去结算</a>
    </div>

</div>
</body>
</html>
