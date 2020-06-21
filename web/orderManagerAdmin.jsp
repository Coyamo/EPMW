<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单管理</title>
    <script type="text/javascript">
        function send(orderId) {
            var s = document.getElementById("action_" + orderId);
            var url = "ChangeOrderStateAdmin?orderId=" + orderId + "&state=2";
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if (xmlhttp.responseText == "ok") {
                        document.getElementById('state_' + orderId).innerHTML = "正在派送";
                        s.style.display = "none";
                        document.getElementById('state_color_' + orderId).className = 'mdui-chip-icon mdui-color-blue'
                    } else
                        window.alert("修改失败，请联系管理员！");
                }
            };
            xmlhttp.open("post", url, true);
            xmlhttp.send();
        }
    </script>
</head>
<body>
<jsp:include page="headerAdmin.jsp"/>
<div class="mdui-container">
    <br>
    <h2 style="text-align: center"> 订单管理 </h2>
    <div class="mdui-divider"></div>
    <br>

    <div class="mdui-card" style="text-align: center;width: fit-content;margin: 0 auto;padding: 5px">
        <c:choose>
            <c:when test="${requestScope.page.currentPageNum!=1}">
                <a class="mdui-btn" href="ManageOrders?pageNum=1">第一页</a>
            </c:when>
            <c:otherwise>
                <a class="mdui-btn" disabled>第一页</a>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${requestScope.page.currentPageNum!=1}">
                <a class="mdui-btn" href="ManageOrders?pageNum=${requestScope.page.currentPageNum-1}">上一页</a>
            </c:when>
            <c:otherwise>
                <a class="mdui-btn" disabled>上一页</a>
            </c:otherwise>
        </c:choose>
        <a href="javascript:void(0)"
           class="mdui-btn">${requestScope.page.currentPageNum}/${requestScope.page.allPageNum}页</a>
        <c:choose>
            <c:when test="${requestScope.page.currentPageNum != requestScope.page.allPageNum}">
                <a class="mdui-btn"
                   href="ManageOrders?pageNum=${requestScope.page.currentPageNum+1}">下一页</a>
            </c:when>
            <c:otherwise>
                <a class="mdui-btn" disabled>下一页</a>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${requestScope.page.currentPageNum != requestScope.page.allPageNum}">
                <a class="mdui-btn" href="ManageOrders?pageNum=${requestScope.page.allPageNum}">最后一页</a>
            </c:when>
            <c:otherwise>
                <a class="mdui-btn" disabled>最后一页</a>
            </c:otherwise>
        </c:choose>


    </div>
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
            <c:forEach var="item" items="${requestScope.page.list}">

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
                    <td>
                        <a class="mdui-btn mdui-btn-dense mdui-btn-raised mdui-ripple"
                           href="OrderDetailAdmin?orderId=${item.id}">查看</a>
                    </td>
                    <td>
                        <c:if test="${item.state==1}">
                            <a class="mdui-btn mdui-btn-dense mdui-btn-raised mdui-ripple" id="action_${item.id}"
                               href="javascript:send(${item.id})">派送</a>
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
