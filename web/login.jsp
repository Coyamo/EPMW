<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登录</title>
    <style type="text/css">
        .bg {
            width: 100%;
            height: 100%;
            transform: scale(1.2);
            background-image: url("img/user_login_bg.jpg");
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
<jsp:include page="header.jsp"/>


<div class="bg"></div>
<div class="center-div-out">
    <div class="center-div-in ">
        <div class="mdui-card" style="padding: 25px">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">伊品美味</div>
                <div class="mdui-card-primary-subtitle">登录</div>
            </div>
            <div class="mdui-card-content">
                <form name="form1" action="Login" method="post">
                    <table>
                        <tr>
                            <td>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">用户名</label>
                                    <input class="mdui-textfield-input" type="text" name="username"
                                           value="${username}"/>
                                </div>
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">密码</label>
                                    <input class="mdui-textfield-input" type="password" name="password"
                                           value="${password}"/>
                                </div>
                            </td>

                        </tr>
                        <tr>
                            <td>
                                <div class="mdui-textfield mdui-textfield-floating-label">
                                    <label class="mdui-textfield-label">验证码</label>
                                    <input class="mdui-textfield-input" name="checkCode" type="text"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><img name="checkImg" border="0" src="CheckCode"
                                     onclick="form1.checkImg.src='CheckCode?r='+Math.random()">
                                <input class="mdui-btn mdui-ripple" type="button" value="换一张"
                                       onclick="form1.checkImg.src='CheckCode?aaa='+Math.random()"/>
                            </td>
                        </tr>
                    </table>
                    <br>
                    <input class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-pink-accent" type="submit"
                           value="登录"/>
                    <a class="mdui-btn mdui-btn-raised mdui-ripple" href="register.jsp">注册</a>
                </form>
            </div>

        </div>
    </div>
</div>
</body>
</html>
