<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改菜品</title>
</head>
<body>
<jsp:include page="headerAdmin.jsp"/>

<h2> 修改菜品 </h2>
<hr>
<c:choose>
    <c:when test="${requestScope.isServletMsg}">
        <c:set value="${name}" var="myName"/>
        <c:set value="${price}" var="myPrice"/>
        <c:set value="${description}" var="myDescription"/>
        <c:set value="${id}" var="myId"/>
    </c:when>
    <c:otherwise>
        <c:set value="${param.name}" var="myName"/>
        <c:set value="${param.id}" var="myId"/>
        <c:set value="${param.price}" var="myPrice"/>
        <c:set value="${param.description}" var="myDescription"/>
    </c:otherwise>
</c:choose>

<c:choose>
    <c:when test="${requestScope.isOk}">
        <h2>修改菜品成功!<a href="ShowAllGoods">返回</a></h2> <br>

    </c:when>
    <c:otherwise>
        <form action="UpdateGoods" method="post" enctype="multipart/form-data">
            <table border="0">
                <tr>
                    <td>菜品名称：</td>
                    <td><input type="text" name="name" value="${myName}"/></td>
                </tr>
                <tr>
                    <td>菜品价格：</td>
                    <td><input type="text" name="price" value="${myPrice}"/></td>
                </tr>
                <tr>
                    <td>菜品描述：</td>
                    <td><textarea name="description" rows="5" cols="24">${myDescription}</textarea></td>
                </tr>
                <tr>
                    <td>菜品图片：</td>
                    <td><input type="file" name="file1" contenteditable="false"/></td>
                </tr>
            </table>
            <br>
            <input type="hidden" value="${myId}" name="id"/>
            <input type="hidden" value="2" name="type"/>
            <input type="submit" value="修改"/>
            <input type="reset" value="重置"/> <a href="ShowAllGoods">返回</a>

        </form>

        <span style="color: red; ">${errMsg}</span>
    </c:otherwise>
</c:choose>


</body>
</html>
