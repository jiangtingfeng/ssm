<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/6/006
  Time: 11:24
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/fore/style.css" rel="stylesheet">
    <title>货到付款</title>
    <script>
        function formatMoney(num){
            num = num.toString().replace(/\$|\,/g,'');
            if(isNaN(num))
                num = "0";
            sign = (num == (num = Math.abs(num)));
            num = Math.floor(num*100+0.50000000001);
            cents = num%100;
            num = Math.floor(num/100).toString();
            if(cents<10)
                cents = "0" + cents;
            for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
                num = num.substring(0,num.length-(4*i+3))+','+
                    num.substring(num.length-(4*i+3));
            return (((sign)?'':'-') + num + '.' + cents);
        }
        function checkEmpty(id, name){
            var value = $("#"+id).val();
            if(value.length==0){
                $("#"+id)[0].focus();
                return false;
            }
            return true;
        }
        $(function(){

            $("a.productDetailTopReviewLink").click(function(){
                $("div.productReviewDiv").show();
                $("div.productDetailDiv").hide();
            });
            $("a.productReviewTopPartSelectedLink").click(function(){
                $("div.productReviewDiv").hide();
                $("div.productDetailDiv").show();
            });
            $("span.leaveMessageTextareaSpan").hide();
            $("img.leaveMessageImg").click(function(){
                $(this).hide();
                $("span.leaveMessageTextareaSpan").show();
                $("div.orderItemSumDiv").css("height","100px");
            });
            $("div#footer a[href$=#nowhere]").click(function(){
                alert("模仿天猫的连接，并没有跳转到实际的页面");
            });
            $("a.wangwanglink").click(function(){
                alert("模仿旺旺的图标，并不会打开旺旺");
            });
            $("a.notImplementLink").click(function(){
                alert("这个功能没做，蛤蛤~");
            });
        });
    </script>
</head>
</body>

<nav class="top ">
    <div class="top_middle">
        <a href="indexLogined">
            <span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-home redColor"></span>
            天猫首页
        </a>
        <span>喵，欢迎来天猫</span>
        <a href="login"><c:if test="${! empty user}">${user.name}</c:if></a>
        <a href="forelogout">退出</a>
        <span class="pull-right">
			<a href="forebought">我的订单</a>
			<a href="forecart">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
				购物车<strong><c:if test="${! empty size}">${size}</c:if></strong>件</a>
		</span>
    </div>
</nav>

<div class="simpleSearchOutDiv">
    <a href="indexLogined">
        <img id="simpleLogo" class="simpleLogo" src="image/simpleLogo.png">
    </a>

    <form action="foresearch" method="post" >
        <div class="simpleSearchDiv pull-right">
            <input type="text" placeholder="平衡车 原汁机"  value="" name="keyword">
            <button class="searchButton" type="submit">搜天猫</button>
            <div class="searchBelow">
                <c:if test="${! empty categoryList}">
                    <c:forEach items="${categoryList}" var="category">
					<span>
						<span>|</span>
						<a href="forecategory?cid=${category.id}">
                                ${category.categoryName}
                        </a>
					</span>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </form>
    <div style="clear:both"></div>
</div>

<div class="confirmPayPageDiv">
    <div class="confirmPayImageDiv">
        <img src="image/comformPayFlow.png">
        <c:if test="${! empty userOrder}">
        <div  class="confirmPayTime1">
            <fmt:formatDate value="${userOrder.setTime}" pattern="yyyy-MM-hh HH:mm:ss"></fmt:formatDate>
        </div>
        <div  class="confirmPayTime2">
            <fmt:formatDate value="${userOrder.payTime}" pattern="yyyy-MM-hh HH:mm:ss"></fmt:formatDate>
        </div>
        <div class="confirmPayTime3">
            <fmt:formatDate value="${userOrder.sendTime}" pattern="yyyy-MM-hh HH:mm:ss"></fmt:formatDate>
        </div>
        <div class="confirmPayTime3">
            <fmt:formatDate value="${userOrder.confirmTime}" pattern="yyyy-MM-hh HH:mm:ss"></fmt:formatDate>
        </div>
        </c:if>
    </div>
    <div class="confirmPayOrderInfoDiv">
        <div class="confirmPayOrderInfoText">我已收到货，同意支付宝付款</div>
    </div>
    <div class="confirmPayOrderItemDiv">
        <div class="confirmPayOrderItemText">订单信息</div>
        <table class="confirmPayOrderItemTable">
            <thead>
            <th colspan="2">宝贝</th>
            <th width="120px">单价</th>
            <th width="120px">数量</th>
            <th width="120px">商品总价 </th>
            <th width="120px">运费</th>
            </thead>
            <c:if test="${! empty productNumberVoList}">
                <c:forEach items="${productNumberVoList}" var="products">
            <tr>
                <td><img width="50px" src="image/${products.product.productPic}"></td>
                <td class="confirmPayOrderItemProductLink">
                    <a href="#nowhere">${products.product.productName}/${products.product.productTitle}</a>
                </td>
                <td>￥${products.product.price}</td>
                <td>${products.number}</td>
                <td><span class="conformPayProductPrice">￥${products.product.lowerPrice}</span></td>
                <td><span>快递 ： 0.00 </span></td>
            </tr>

        </table>
             </c:forEach>
        </c:if>
        <div class="confirmPayOrderItemText pull-right">
            实付款： <span class="confirmPayOrderItemSumPrice">￥${userOrder.totalMoney}</span>
        </div>
    </div>

    <div class="confirmPayOrderDetailDiv">
        <table class="confirmPayOrderDetailTable">
            <tr>
                <td>订单编号：</td>
                <td>${userOrder.orderNumber} <img width="23px" src="image/confirmOrderTmall.png"></td>
            </tr>
            <tr>
                <td>卖家昵称：</td>
                <td>天猫商铺 <span class="confirmPayOrderDetailWangWangGif"></span></td>
            </tr>
            <tr>
                <td>收货信息： </td>
                <td>，， ， </td>
            </tr>
            <tr>
                <td>成交时间：</td>
                <td><fmt:formatDate value="${userOrder.confirmTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate> </td>
            </tr>
        </table>
    </div>
    <div class="confirmPayButtonDiv">
        <div class="confirmPayWarning">请收到货后，再确认收货！否则您可能钱货两空！</div>
        <a href="foreorderConfirmed?oid=${userOrder.id}"><button class="confirmPayButton">确认支付</button></a>
    </div>
</div>

<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>
