<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>结算中心</title>
</head>
<body>
<div class="mdui-container">
    <jsp:include page="header.jsp"/>

    <br>
    <h2 style="text-align: center"> 结算中心 </h2>
    <div class="mdui-divider"></div>
    <br>

    <div class="mdui-table-fluid">
        <table class="mdui-table mdui-table-hoverable">
            <thead>
            <tr>
                <th>序号</th>
                <th>菜品名称</th>
                <th>菜品价格</th>
                <th>数量</th>
                <th>小计</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${sessionScope.order.items}" varStatus="status">
                <tr>
                    <td>${status.index+1}</td>
                    <td>${item.goods.name}</td>
                    <td>${item.goods.price}</td>
                    <td> ${item.count}</td>
                    <td>${item.price}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <br>
    <div style="text-align: right">
        <div class="mdui-chip" style="margin-top: 20px;margin-bottom: 20px">
            <span class="mdui-chip-icon mdui-color-amber"><i class="mdui-icon material-icons">&#xe227;</i></span>
            <span id="total"
                  class="mdui-chip-title">合计:${sessionScope.order.price==null?0:sessionScope.order.price}元</span>
        </div>
    </div>
    <br>

    <div class="mdui-card">
        <div class="mdui-card-content">
            <form name="form1" action="CreateOrder" method="post">
                <div class="mdui-textfield mdui-textfield-floating-label">
                    <label class="mdui-textfield-label">收货地址</label>
                    <input value="${sessionScope.user.address}" class="mdui-textfield-input" type="text"
                           name="address"/>
                </div>

                <div class="mdui-textfield mdui-textfield-floating-label">
                    <label class="mdui-textfield-label">收货人</label>
                    <input class="mdui-textfield-input" value="${sessionScope.user.name}" type="text" name="name"/>
                </div>

                <div class="mdui-textfield mdui-textfield-floating-label">
                    <label class="mdui-textfield-label">联系方式</label>
                    <input class="mdui-textfield-input" value="${sessionScope.user.phoneNumber}" type="text"
                           name="phone"/>
                </div>

                <input class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-pink-accent" type="submit"
                       style='font-size:18px;font-weight:bold;color:red' value="  提交订单  "/>

            </form>
        </div>
    </div>
</div>

<c:if test="${!empty errMsg}">
    <script>
        window.onload = function () {
            mdui.alert('${errMsg}', '错误');
        }
    </script>
</c:if>


<c:if test="${requestScope.state==1}">
    <script>
        window.onload = function () {
            mdui.confirm('订单创建成功', '提示', function () {
                window.location.href = "ListMyOrders";
            }, null, {confirmText: '查看订单', cancelText: '确定', history: false});
        }
    </script>
</c:if>

<c:if test="${requestScope.state==2}">
    <script>

        window.onload = function () {
            mdui.confirm('您还没有选购菜品,请先添加菜品！', '提示', function () {
                window.location.href = 'main.jsp';
            }, null, {confirmText: '去选购', cancelText: '确定', history: false});
        }
    </script>
</c:if>

</body>
</html>
