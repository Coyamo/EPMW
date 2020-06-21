<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript">
        function addCart(goodsId) {
            var url = "AddCart?id=" + goodsId;
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if (xmlhttp.responseText == "ok")
                        window.alert("该商品成功加入购物车！");
                    else
                        window.alert("加入购物车失败，请联系管理员！");
                }
            };
            xmlhttp.open("post", url, true);
            xmlhttp.send();
        }
    </script>

    <style type="text/css">
        td {
            text-align: center;
        }

        img {
            height: 158px;
            width: 210px;
        }
    </style>
    <title>商品浏览</title>
</head>
<body>
<jsp:include page="header.jsp"/>

<c:if test="${empty requestScope.page}">
    <jsp:forward page="ShowAllGoods?type=user"/>
</c:if>
<div class="mdui-container">
    <br>
    <div class="mdui-card" style="text-align: center;width: fit-content;margin: 0 auto;padding: 5px">
        <c:choose>
            <c:when test="${requestScope.page.currentPageNum!=1}">
                <a class="mdui-btn" href="ShowAllGoods?type=user&pageNum=1">第一页</a>
            </c:when>
            <c:otherwise>
                <a class="mdui-btn" href="ShowAllGoods?type=user&pageNum=1" disabled>第一页</a>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${requestScope.page.currentPageNum!=1}">
                <a class="mdui-btn" href="ShowAllGoods?type=user&pageNum=${requestScope.page.currentPageNum-1}">上一页</a>
            </c:when>
            <c:otherwise>
                <a class="mdui-btn" href="ShowAllGoods?type=user&pageNum=${requestScope.page.currentPageNum-1}"
                   disabled>上一页</a>
            </c:otherwise>
        </c:choose>
        <a href="javascript:void(0)"
           class="mdui-btn">${requestScope.page.currentPageNum}/${requestScope.page.allPageNum}页</a>
        <c:choose>
            <c:when test="${requestScope.page.currentPageNum != requestScope.page.allPageNum}">
                <a class="mdui-btn"
                   href="ShowAllGoods?type=user&pageNum=${requestScope.page.currentPageNum+1}">下一页</a>
            </c:when>
            <c:otherwise>
                <a class="mdui-btn" href="ShowAllGoods?type=user&pageNum=${requestScope.page.currentPageNum+1}"
                   disabled>下一页</a>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${requestScope.page.currentPageNum != requestScope.page.allPageNum}">
                <a class="mdui-btn" href="ShowAllGoods?type=user&pageNum=${requestScope.page.allPageNum}">最后一页</a>
            </c:when>
            <c:otherwise>
                <a class="mdui-btn" href="ShowAllGoods?type=user&pageNum=${requestScope.page.allPageNum}"
                   disabled>最后一页</a>
            </c:otherwise>
        </c:choose>


    </div>
    <br>
    <div class="mdui-row-xs-1 mdui-row-sm-2 mdui-row-xs-3 mdui-row-sm-4 mdui-row-md-5 mdui-grid-list">
        <c:forEach var="goods" items="${requestScope.page.list}" varStatus="status">

            <div class="mdui-col" style="padding: 5px">
                <div class="mdui-card mdui-color-grey-50 ">
                    <div class="mdui-card-media">
                        <img src="images/${goods.image}"/>
                    </div>
                    <div class="mdui-card-actions mdui-card-actions-stacked">
                        <div class="mdui-typo-title-opacity mdui-list-item-one-line">${goods.name}</div>
                        <div style="padding-top: 5px"
                             class="mdui-typo-subheading mdui-list-item-three-line">${goods.description}</div>
                        <div class="mdui-chip">
                            <span class="mdui-chip-icon mdui-color-yellow"><i
                                    class="mdui-icon material-icons">&#xe227;</i></span>
                            <span class="mdui-chip-title">${goods.price}元</span>
                        </div>

                        <button class="mdui-btn mdui-ripple mdui-btn-block" onclick="addCart('${goods.id}')"><i
                                class="mdui-icon material-icons">&#xe854;</i>加入购物车
                        </button>


                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

</div>
</div>
</body>
</html>
