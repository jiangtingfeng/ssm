<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/11/011
  Time: 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/back/style.css" rel="stylesheet">
    <title>分类管理</title>
    <script>
        function checkEmpty(id, name){
            var value = $("#"+id).val();
            if(value.length==0){
                alert(name+ "不能为空");
                $("#"+id)[0].focus();
                return false;
            }
            return true;
        }
        function checkNumber(id, name){
            var value = $("#"+id).val();
            if(value.length==0){
                alert(name+ "不能为空");
                $("#"+id)[0].focus();
                return false;
            }
            if(isNaN(value)){
                alert(name+ "必须是数字");
                $("#"+id)[0].focus();
                return false;
            }

            return true;
        }
        function checkInt(id, name){
            var value = $("#"+id).val();
            if(value.length==0){
                alert(name+ "不能为空");
                $("#"+id)[0].focus();
                return false;
            }
            if(parseInt(value)!=value){
                alert(name+ "必须是整数");
                $("#"+id)[0].focus();
                return false;
            }

            return true;
        }


        $(function(){
            $("a").click(function(){
                var deleteLink = $(this).attr("deleteLink");
                console.log(deleteLink);
                if("true"==deleteLink){
                    var confirmDelete = confirm("确认要删除");
                    if(confirmDelete)
                        return true;
                    return false;

                }
            });
        })
    </script>
</head>
<body>

<div class="navitagorDiv">
    <nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
        <img style="margin-left:10px;margin-right:0px" class="pull-left" src="image/tmallbuy.png" height="45px">
        <a class="navbar-brand" href="#nowhere">天猫后台</a>
        <a class="navbar-brand" href="categoryList">分类管理</a>
        <a class="navbar-brand" href="admin_user_list">用户管理</a>
        <a class="navbar-brand" href="admin_order_list">订单管理</a>
    </nav>
</div>

<script>
    $(function(){

        $("#addForm").submit(function(){
            if(!checkEmpty("name","分类名称"))
                return false;
            if(!checkEmpty("categoryPic","分类图片"))
                return false;
            return true;
        });
    });

</script>

<title>分类管理</title>

<div class="workingArea">
    <h1 class="label label-info" >分类管理</h1>
    <br>
    <br>

    <div class="listDataTableDiv">
        ${message1}
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <thead>
            <tr class="success">
                <th>ID</th>
                <th>图片</th>
                <th>分类名称</th>
                <th>属性管理</th>
                <th>产品管理</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${!empty list.list}">
            <c:forEach items="${list.list}" var="category" >
            <tr>
                <td>${category.id}</td>
                <td><img id="images"  height="40" alt="" src="image/${category.categoryPic }"></td>
                <td>${category.categoryName}</td>
                <td><a href="category_property_list?cid=${category.id}"><span class="glyphicon glyphicon-th-list"></span></a></td>
                <td><a href="category_product_list?cid=${category.id}"><span class="glyphicon glyphicon-shopping-cart"></span></a></td>
                <td><a href="category_edit?id=${category.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                <td><a deleteLink="true" href="category_delete?id=${category.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
            </tr>
            </c:forEach>
            </c:if>
            </tbody>
        </table>
    </div>
    <div>
        当前${list.pageNum }页,总${list.pages}页，总${list.total}条记录
    </div>
    <div class="pageDiv">
        <script>
            $(function(){
                $("ul.pagination li.disabled a").click(function(){
                    return false;
                });
            });
        </script>
        <nav>
            <ul class="pagination">
                <li>
                    <a  href="admin_category_list?start=1" >
                        首页
                    </a>
                </li>

                <c:if test="${list.hasPreviousPage}">
                <li>
                    <a  href="admin_category_list?start=${list.pageNum-1}" aria-label="Previous" >
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                </c:if>
                <!--循环遍历所有页码并显示 -->
                <c:forEach items="${list.navigatepageNums}" var="page_num">
                    <c:if test="${page_num == list.pageNum}">
                        <li class="active">
                        <a
                                href="#"
                        >${page_num}</a>
                        </li>
                    </c:if>
                    <c:if test="${page_num != list.pageNum}">
                        <li >
                            <a
                                    href="admin_category_list?start=${page_num}">
                            >${page_num}</a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:if test="${list.hasNextPage}">
                    <li >
                        <a href="admin_category_list?start=${list.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
                <li><a href="admin_category_list?start=${list.pages}">末页</a> </li>
            </ul>
        </nav>
    </div>

    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增分类</div>
        <div class="panel-body">
            <form method="post" id="addForm" action="addCategory" enctype="multipart/form-data">
                <table class="addTable">
                    <tr>
                        <td>分类名称</td>
                        <td><input  id="name" name="categoryName" type="text" class="form-control"></td>
                    </tr>
                    <tr>
                        <td>分类图片</td>
                        <td>
                            <input id="categoryPic" accept="image/*" type="file" name="file" />
                        </td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <button type="submit" class="btn btn-success">提 交</button>
                        </td>
                        ${message}
                    </tr>
                </table>
            </form>
        </div>
    </div>

</div>

<div class="footer">
</div>

</body>
</html>