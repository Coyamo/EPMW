<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>新用户注册</title>
    <style type="text/css">
        .bg {


        }

        .bg:after {
            transform: scale(1.2);
            content: "";
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            background-image: url("img/user_login_bg.jpg");
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-attachment: fixed;
            filter: blur(5px);
            z-index: -1;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<script>
    function clearForm() {
        const input1 = document.getElementById("username");
        input1.value = "";
        const input2 = document.getElementById("password");
        input2.value = "";
        const input3 = document.getElementById("password2");
        input3.value = "";
        const input4 = document.getElementById("name");
        input4.value = "";
        const input5 = document.getElementById("address");
        input5.value = "";
        const input6 = document.getElementById("phoneNumber");
        input6.value = "";
    }
</script>

<div class="bg">
    <div style="text-align: center">
        <div class="mdui-card" style="padding: 25px;width: fit-content;height: fit-content;margin: 0 auto">
            <div class="mdui-card-primary">
                <div class="mdui-card-primary-title">伊品美味</div>
                <div class="mdui-card-primary-subtitle">新用户注册</div>
            </div>
            <div class="mdui-card-content">
                <form id="form" action="Register" method="post" name="form1">
                    <div style="text-align: left">
                        <div class="mdui-textfield mdui-textfield-floating-label">
                            <label for="username" class="mdui-textfield-label">用户名</label>
                            <input id="username" class="mdui-textfield-input" type="text" name="username"
                                   value="${requestScope.username}"/>
                        </div>

                        <div class="mdui-textfield mdui-textfield-floating-label">
                            <label for="password" class="mdui-textfield-label">密码</label>
                            <input id="password" class="mdui-textfield-input" type="password" name="password"
                                   value="${requestScope.password}"/>
                        </div>

                        <div class="mdui-textfield mdui-textfield-floating-label">
                            <label for="password2" class="mdui-textfield-label">确认密码</label>
                            <input id="password2" class="mdui-textfield-input" type="password" name="password2"
                                   value="${requestScope.password2}"/>
                        </div>

                        <div class="mdui-textfield mdui-textfield-floating-label">
                            <label for="name" class="mdui-textfield-label">姓名</label>
                            <input id="name" class="mdui-textfield-input" type="text" name="name"
                                   value="${requestScope.name}"/>
                        </div>

                        <div class="mdui-textfield mdui-textfield-floating-label">
                            <label for="address" class="mdui-textfield-label">地址</label>
                            <input id="address" class="mdui-textfield-input" type="text" name="address"
                                   value="${requestScope.address}"/>
                        </div>

                        <div class="mdui-textfield mdui-textfield-floating-label">
                            <label for="phoneNumber" class="mdui-textfield-label">电话号码</label>
                            <input id="phoneNumber" class="mdui-textfield-input" type="text" name="phoneNumber"
                                   value="${requestScope.phoneNumber}"/>
                    </div>

                    <div class="mdui-textfield mdui-textfield-floating-label">
                        <label class="mdui-textfield-label">验证码</label>
                        <input class="mdui-textfield-input" type="text" name="checkCode"/>
                    </div>

                    <img name="checkImg" border="0" src="CheckCode"
                         onclick="form.checkImg.src='CheckCode?r='+Math.random()" alt="无法加载验证码">
                    <input class="mdui-btn mdui-ripple" type="button" value="换一张"
                           onclick="form.checkImg.src='CheckCode?aaa='+Math.random()"/>
                    </div>
                    <br>
                    <input class="mdui-btn mdui-btn-raised mdui-ripple mdui-color-pink-accent" type="submit"
                           value="注册"/>
                    <input class="mdui-btn mdui-btn-raised mdui-ripple" type="button" value="重置" onclick="clearForm()"/>
                    <a class="mdui-btn mdui-btn-raised mdui-ripple" href="login.jsp">返回</a>
                </form>
            </div>
        </div>
    </div>
</div>


<c:if test="requestScope.isSuccess eq 'true'">
    <script>
        window.onload = function () {
            mdui.confirm('注册成功！', '提示', function () {
                window.location.href = 'login.jsp';
            }, null, {confirmText: '去登录', cancelText: '确定', history: false});
        }
    </script>
    <h2>注册成功!<a href="login.jsp">登录</a></h2> <br>
</c:if>

</div></div>

<c:if test="${!empty errMsg}">
    <script>
        window.onload = function () {
            mdui.alert('${errMsg}', '错误');
        }
    </script>
</c:if>
</body>
</html>
