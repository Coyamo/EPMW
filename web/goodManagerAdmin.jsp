<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style type="text/css">
        td {
            text-align: center;
        }

        img {
            height: 158px;
            width: 210px;
        }
    </style>
    <c:if test="${!empty errMsg}">
        <script>
            window.onload = function () {
                mdui.alert('${errMsg}', '错误');
            }
        </script>
    </c:if>
    <title>菜品管理</title>
</head>
<body>
<jsp:include page="headerAdmin.jsp"/>
<div class="mdui-container">
    <script type="text/javascript">
        function changeState(goodsId) {
            var s = document.getElementById(goodsId).innerHTML;
            var state = "1";
            var newState = "下架";
            if (s == "下架") {
                state = "0";
                newState = "上架"
            }
            var url = "ChangeGoodsState?id=" + goodsId + "&state=" + state;
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                    if (xmlhttp.responseText === "ok") {
                        document.getElementById(goodsId).innerHTML = newState;
                        mdui.alert('修改成功！', '提示');
                    } else
                        mdui.alert('修改失败，请联系管理员！', '错误');
                }
            };
            xmlhttp.open("GET", url, true);
            xmlhttp.send();
        }

        function addGoods(nameId, priceId, descriptionId, fileId) {
            var name = document.getElementById(nameId).value;
            var price = document.getElementById(priceId).value;
            var description = document.getElementById(descriptionId).value;
            var url = "UpdateGoods";
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                    if (xmlhttp.responseText === "ok") {
                        alert('添加成功！');
                        window.location.reload();
                        //mdui.alert("添加成功！","提示") ;
                    } else {
                        alert(xmlhttp.responseText);
                        //mdui.alert(xmlhttp.responseText,"错误");
                    }

                }
            };

            var file = document.getElementById(fileId);
            var files = file.files[0];
            var formData = new FormData();
            xmlhttp.overrideMimeType("multipart/form-data");
            //空文件时要设置 否则cos会报错
            if (files == undefined) files = new File([], "", {type: 'application/octet-stream'});
            formData.append('file', files);
            formData.append('name', name);
            formData.append('price', price);
            formData.append('type', 1);
            formData.append('description', description);
            xmlhttp.open("post", url, true);

            xmlhttp.send(formData);
        }

        function showModifyGoodsDialog(goodId, oldName, oldPrice, oldDescription) {
            modifyGoodId = goodId;
            var name = document.getElementById('name_modify');
            var price = document.getElementById('price_modify');
            var description = document.getElementById('description_modify');

            name.value = oldName;
            price.value = oldPrice;
            description.value = oldDescription;

            dialog.open();

        }

        function modifyGoods() {
            var name = document.getElementById('name_modify').value;
            var price = document.getElementById('price_modify').value;
            var description = document.getElementById('description_modify').value;

            var url = "UpdateGoods";
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            } else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                    if (xmlhttp.responseText === "ok") {
                        alert('修改成功！');
                        //mdui.alert("添加成功！","提示",{history: false}) ;
                        window.location.reload();

                    } else {
                        alert(xmlhttp.responseText);
                        //mdui.alert(xmlhttp.responseText,"错误",{history: false});
                    }

                }
            };

            var file = document.getElementById('file_modify');
            var files = file.files[0];
            var formData = new FormData();
            xmlhttp.overrideMimeType("multipart/form-data");
            //空文件时要设置 否则cos会报错
            if (files == undefined) files = new File([], "", {type: 'application/octet-stream'});
            formData.append('file', files);
            formData.append('id', modifyGoodId);
            formData.append('name', name);
            formData.append('price', price);
            formData.append('type', 2);
            formData.append('description', description);
            xmlhttp.open("post", url, true);

            xmlhttp.send(formData);
        }
    </script>
    <br>
    <h2 style="text-align: center"> 菜品管理 </h2>
    <div class="mdui-divider"></div>
    <br>
    <div style="text-align: center">

        <div class="mdui-card" style="text-align: center;width: fit-content;margin: 0 auto;padding: 5px">
            <c:choose>
                <c:when test="${requestScope.page.currentPageNum!=1}">
                    <a class="mdui-btn" href="ShowAllGoods?type=admin&pageNum=1">第一页</a>
                </c:when>
                <c:otherwise>
                    <a class="mdui-btn" href="ShowAllGoods?type=admin&pageNum=1" disabled>第一页</a>
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${requestScope.page.currentPageNum!=1}">
                    <a class="mdui-btn"
                       href="ShowAllGoods?type=admin&pageNum=${requestScope.page.currentPageNum-1}">上一页</a>
                </c:when>
                <c:otherwise>
                    <a class="mdui-btn" href="ShowAllGoods?type=admin&pageNum=${requestScope.page.currentPageNum-1}"
                       disabled>上一页</a>
                </c:otherwise>
            </c:choose>
            <a href="javascript:void(0)"
               class="mdui-btn">${requestScope.page.currentPageNum}/${requestScope.page.allPageNum}页</a>
            <c:choose>
                <c:when test="${requestScope.page.currentPageNum != requestScope.page.allPageNum}">
                    <a class="mdui-btn"
                       href="ShowAllGoods?type=admin&pageNum=${requestScope.page.currentPageNum+1}">下一页</a>
                </c:when>
                <c:otherwise>
                    <a class="mdui-btn" href="ShowAllGoods?type=admin&pageNum=${requestScope.page.currentPageNum+1}"
                       disabled>下一页</a>
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${requestScope.page.currentPageNum != requestScope.page.allPageNum}">
                    <a class="mdui-btn" href="ShowAllGoods?type=admin&pageNum=${requestScope.page.allPageNum}">最后一页</a>
                </c:when>
                <c:otherwise>
                    <a class="mdui-btn" href="ShowAllGoods?type=admin&pageNum=${requestScope.page.allPageNum}"
                       disabled>最后一页</a>
                </c:otherwise>
            </c:choose>


        </div>
        <br>
        <div class="mdui-table-fluid">
            <table class="mdui-table mdui-table-hoverable">
                <thead>
                <tr>
                    <th>封面</th>
                    <th>菜名</th>
                    <th>价格</th>
                    <th>简介</th>
                    <th>编辑</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="goods" items="${requestScope.page.list}">
                    <tr>
                        <td><img src="images/${goods.image}" alt="${goods.image}"></td>
                        <td>${goods.name}</td>
                        <td>${goods.price}</td>
                        <td>${goods.description}</td>
                        <td>
                            <a class="mdui-btn mdui-btn-dense mdui-btn-raised mdui-ripple" href="javascript:void(0)"
                               onclick="showModifyGoodsDialog(${goods.id},'${goods.name}','${goods.price}','${goods.description}')">修改信息</a>
                        </td>


                        <td><a class="mdui-btn mdui-btn-dense mdui-btn-raised mdui-ripple" href="javascript:void(0)"
                               onclick="changeState('${goods.id}')">
                            <c:if test="${goods.state==0}">
                                <span id='${goods.id}'>上架</span>
                            </c:if>
                            <c:if test="${goods.state==1}">
                                <span id='${goods.id}'>下架</span>
                            </c:if>
                        </a>
                        </td>
                    </tr>

                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <button mdui-tooltip="{content: '添加菜品'}" mdui-dialog="{target: '#addGoods'}"
            class="mdui-fab mdui-fab-fixed  mdui-ripple mdui-color-pink-accent"><i
            class="mdui-icon material-icons">add</i></button>
    <div class="mdui-dialog" id="addGoods" style="width:fit-content;height: fit-content">
        <div class="mdui-dialog-title">添加菜品</div>
        <div class="mdui-dialog-content">


            <div class="mdui-textfield">
                <label for="name" class="mdui-textfield-label">菜品名称</label>
                <input id="name" name="name" class="mdui-textfield-input" type="text"/>
            </div>
            <div class="mdui-textfield">
                <label for="price" class="mdui-textfield-label">菜品价格</label>
                <input id="price" name="price" class="mdui-textfield-input" type="text"/>
            </div>
            <div class="mdui-textfield">
                <label for="description" class="mdui-textfield-label">菜品描述</label>
                <input id="description" name="description" class="mdui-textfield-input" type="text"/>
            </div>
            <div class="mdui-textfield">
                <label class="mdui-textfield-label">菜品图片</label>
                <input accept="image/gif, image/jpeg, image/png" id="file" contenteditable="false" name="file1"
                       class="mdui-textfield-input" type="file"/>
            </div>
        </div>
        <div class="mdui-dialog-actions">
            <button class="mdui-btn mdui-ripple" mdui-dialog-close>取消</button>
            <button class="mdui-btn mdui-ripple"
                    onclick="addGoods('name','price','description','file')" mdui-dialog-confirm>添加
            </button>
        </div>
    </div>
    <div class="mdui-dialog" id="modifyGoods" style="width:fit-content;height: fit-content">
        <div class="mdui-dialog-title">修改菜品</div>
        <div class="mdui-dialog-content">


            <div class="mdui-textfield">
                <label for="name_modify" class="mdui-textfield-label">菜品名称</label>
                <input id="name_modify" name="name" class="mdui-textfield-input" type="text"/>
            </div>
            <div class="mdui-textfield">
                <label for="price_modify" class="mdui-textfield-label">菜品价格</label>
                <input id="price_modify" name="price" class="mdui-textfield-input" type="text"/>
            </div>
            <div class="mdui-textfield">
                <label for="description_modify" class="mdui-textfield-label">菜品描述</label>
                <input id="description_modify" name="description" class="mdui-textfield-input" type="text"/>
            </div>
            <div class="mdui-textfield">
                <label class="mdui-textfield-label">菜品图片</label>
                <input accept="image/gif, image/jpeg, image/png" id="file_modify" contenteditable="false" name="file1"
                       class="mdui-textfield-input" type="file"/>
            </div>
        </div>
        <div class="mdui-dialog-actions">
            <button class="mdui-btn mdui-ripple" mdui-dialog-close>取消</button>
            <button class="mdui-btn mdui-ripple" mdui-dialog-confirm>修改
            </button>
        </div>
    </div>

    <script>
        var dialog = new mdui.Dialog('#modifyGoods');
        var modifyGoodId;
        document.getElementById('modifyGoods').addEventListener('confirm.mdui.dialog', function () {
            modifyGoods()
        });
    </script>
</div>
</body>
</html>
