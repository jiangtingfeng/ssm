<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/16/016
  Time: 16:24
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
    <title>产品分类修改</title>
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



<title>编辑分类</title>


<script>
    $(function(){

        $("#editForm").submit(function(){
            if(!checkEmpty("name","分类名称"))
                return false;

            return true;
        });
    });

</script>

<div class="workingArea">

    <ol class="breadcrumb">
        <li><a href="admin_category_list">所有分类</a></li>
        <li class="active">编辑分类</li>
    </ol>

    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑分类</div>
        <div class="panel-body">
            <form method="post" id="editForm" action="admin_category_update"  enctype="multipart/form-data">
                <table class="editTable">
                    <tr>
                        <td>分类名称</td>
                        <td><input  id="name" name="categoryName" value="${category.categoryName}" type="text" class="form-control"></td>
                    </tr>
                    <tr>
                        <td>分类圖片</td>
                        <td>
                            <input id="categoryPic" accept="image/*" type="file" name="file" />
                        </td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="id" value="${category.id}">
                            <button type="submit" class="btn btn-success">提 交</button>
                        </td>
                    </tr>
                    ${message}
                </table>
            </form>
        </div>
    </div>
</div>
</body>
</html>