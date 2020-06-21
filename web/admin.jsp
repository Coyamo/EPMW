<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员登录</title>
    <style type="text/css">
        .bg {
            width: 100%;
            height: 100%;
            transform: scale(1.2);
            background-image: url("img/admin_login_bg.jpg");
            filter: blur(5px);
            background-repeat: no-repeat;
            background-size: 100%;
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
<jsp:include page="headerAdmin.jsp"/>
<div class="bg"></div>
<div class="center-div-out">
    <div class="center-div-in ">
        <div class="mdui-card" style="padding: 25px">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">后台管理</div>
                <div class="mdui-card-primary-subtitle">登录</div>
            </div>
            <div class="mdui-card-content">
                <form action="LoginAdmin" method="post">
                    <table>
                        <tr>
                            <td>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">用户名</label>
                                    <input class="mdui-textfield-input" type="text" name="name"/>
                                </div>
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">密码</label>
                                    <input class="mdui-textfield-input" type="password" name="password"/>
                                </div>
                            </td>

                        </tr>
                    </table>
                    <br>
                    <input class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-pink-accent" type="submit"
                           value="登录"/>
                </form>
            </div>

        </div>
    </div>
</div>
</body>
</html>
