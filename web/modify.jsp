<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改个人资料</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="mdui-container" style="text-align: center">
    <br>
    <h2 style="text-align: center"> 修改个人资料 </h2>
    <div class="mdui-divider"></div>
    <br>
    <div class="mdui-card" style="width: fit-content;padding: 25px;margin: 0 auto;">
        <form action="ModifyUserInfo" method="post">
            <div style="text-align: left">
                <div class="mdui-textfield">
                    <label for="username" class="mdui-textfield-label">用户名</label>
                    <input id="username" class="mdui-textfield-input" type="text" disabled
                           value="${sessionScope.user.username}"/>
                </div>
                <div class="mdui-textfield">
                    <label for="password" class="mdui-textfield-label">密码</label>
                    <input id="password" name="password" class="mdui-textfield-input" type="password"/>
                </div>
                <div class="mdui-textfield">
                    <label for="password2" class="mdui-textfield-label">确认密码</label>
                    <input id="password2" name="password2" class="mdui-textfield-input" type="text"/>
                </div>
                <div class="mdui-textfield">
                    <label for="name" class="mdui-textfield-label">姓名</label>
                    <input id="name" name="name" class="mdui-textfield-input" value="${sessionScope.user.name}"
                           type="text"/>
                </div>
                <div class="mdui-textfield">
                    <label for="address" class="mdui-textfield-label">地址</label>
                    <input id="address" name="address" class="mdui-textfield-input" value="${sessionScope.user.address}"
                           type="text"/>
                </div>
                <div class="mdui-textfield">
                    <label for="phoneNumber" class="mdui-textfield-label">电话号码</label>
                    <input id="phoneNumber" name="phoneNumber" class="mdui-textfield-input"
                           value="${sessionScope.user.phoneNumber}" type="text"/>
                </div>
            </div>
            <br>
            <input class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-pink-accent" type="submit" value="修改"/>
            <a class="mdui-btn mdui-btn-raised mdui-ripple" href="main.jsp">返回主界面</a>
        </form>
    </div>
    <c:if test="${!empty errMsg}">
        <script>
            window.onload = function () {
                mdui.alert('${errMsg}', '错误');
            }
        </script>
    </c:if>
</div>
</body>
</html>
