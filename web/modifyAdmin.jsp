<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
</head>
<body>
<jsp:include page="headerAdmin.jsp"/>
<div class="mdui-container" style="text-align: center">
    <br>
    <h2 style="text-align: center"> 修改密码 </h2>
    <div class="mdui-divider"></div>
    <br>
    <div class="mdui-card" style="width: fit-content;padding: 25px;margin: 0 auto;">
        <form style="text-align: center" action="ModifyAdminInfo" method="post">

            <div style="text-align: left">
                <div class="mdui-textfield">
                    <label for="name" class="mdui-textfield-label">用户名</label>
                    <input id="name" class="mdui-textfield-input" type="text" disabled
                           value="${sessionScope.admin.name}"/>
                </div>
                <div class="mdui-textfield">
                    <label for="password" class="mdui-textfield-label">新密码</label>
                    <input id="password" class="mdui-textfield-input" name="password" type="password"/>
                </div>
                <div class="mdui-textfield">
                    <label for="password2" class="mdui-textfield-label">确认新密码</label>
                    <input id="password2" class="mdui-textfield-input" name="password2" type="password"/>
                </div>
            </div>
            <input class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-pink-accent" type="submit" value="修改"/>
        </form>
    </div>
</div>
<c:if test="${!empty errMsg}">
    <script>
        window.onload = function () {
            mdui.alert('${errMsg}', '错误');
        }
    </script>
</c:if>
</body>
</html>
