<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/18/018
  Time: 11:49
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
    <title>订单管理</title>

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


<!-- 模仿天猫整站ssm 教程 为how2j.cn 版权所有-->
<!-- 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关-->
<!-- 供购买者学习，请勿私自传播，否则自行承担相关法律责任-->



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
        $("button.orderPageCheckOrderItems").click(function(){
            var oid = $(this).attr("oid");
            $("tr.orderPageOrderItemTR[oid="+oid+"]").toggle();
        });
    });
</script>

<title>订单管理</title>


<div class="workingArea">
    <h1 class="label label-info" >订单管理</h1>
    <br>
    <br>
${message_order}
    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover1  table-condensed">
            <thead>
            <tr class="success">
                <th>ID</th>
                <th>状态</th>
                <th>金额</th>
                <th width="100px">商品数量</th>
                <th width="100px">买家名称</th>
                <th>创建时间</th>
                <th>支付时间</th>
                <th>货到时间</th>
                <th>确认收货时间</th>
                <th width="120px">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${! empty list.list}">
                <c:forEach items="${list.list}" var="order">
            <tr>
                <td>${order.order.id}</td>
                <c:if test="${order.order.status == 1}">
                    <td>待付款</td>
                </c:if>
                <c:if test="${order.order.status == 2}">
                    <td>已付款</td>
                </c:if>
                <c:if test="${order.order.status == 3}">
                    <td>待发货</td>
                </c:if>
                <c:if test="${order.order.status == 3}">
                    <td>已发货</td>
                </c:if>
                <c:if test="${order.order.status == 3}">
                    <td>确认收货</td>
                </c:if>
                <td>￥${order.order.totalMoney}</td>
                <td align="center">${order.order.productNumber}</td>
                <td align="center">${order.order.buyerName}</td>

                <td><fmt:formatDate value="${order.order.setTime}" pattern="yyyy-MM-dd HH:mm:dd"/></td>
                <td><fmt:formatDate value="${order.order.payTime}" pattern="yyyy-MM-dd HH:mm:dd"/></td>
                <td><fmt:formatDate value="${order.order.sendTime}" pattern="yyyy-MM-dd HH:mm:dd"/></td>
                <td><fmt:formatDate value="${order.order.confirmTime}" pattern="yyyy-MM-dd HH:mm:dd"/></td>
                <td>
                    <button oid=${order.order.id} class="orderPageCheckOrderItems btn btn-primary btn-xs"> 查看详情</button>
                    <c:if test="${order.order.status == 3}">
                    <a href="admin_order_delivery?id=${order.order.id}">
                        <button class="btn btn-primary btn-xs">发货</button>
                    </a>
                    </c:if>
                </td>
            </tr>
            <tr class="orderPageOrderItemTR"  oid=${order.order.id}>
                <td colspan="10" align="center">

                    <div  class="orderPageOrderItem">
                        <table width="800px" align="center" class="orderPageOrderItemTable">
                            <c:if test="${! empty order.productAndNumbers}">
                                <c:forEach items="${order.productAndNumbers}" var="product">
                                <tr>
                                <td align="left">
                                    <img width="40px" height="40px" src="image/${product.productPic}">
                                </td>
                                <td>
                                    <a href="foreproduct?pid=${product.id}">
                                        <span>${product.productName}</span>
                                    </a>
                                </td>
                                <td align="right">
                                    <span class="text-muted">${product.numberOfBuy}</span>
                                </td>
                                <td align="right">
                                    <span class="text-muted">单价：￥${product.lowerPrice}</span>
                                </td>
                                </tr>
                                </c:forEach>
                            </c:if>
                        </table>
                    </div>

                </td>
            </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>
    </div>
    当前${list.pageNum }页,总${list.pages}页，总${list.total}条记录
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
                    <a  href="?start=1" >
                        首页
                    </a>
                </li>

                <c:if test="${list.hasPreviousPage}">
                    <li>
                        <a  href="?start=${list.pageNum-1}" aria-label="Previous" >
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
                                    href="?start=${page_num}">
                                >${page_num}</a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:if test="${list.hasNextPage}">
                    <li >
                        <a href="?start=${list.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
                <li><a href="?start=${list.pages}">末页</a> </li>
            </ul>
        </nav>

    </div>


</div>
<div class="footer">
</div>


</body>
</html>
