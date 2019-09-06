<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/6/006
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/fore/style.css" rel="stylesheet">
    <title>评论显示</title>
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
<body>
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

<div class="reviewStasticsDiv">
    <div class="reviewStasticsLeft">
        <div class="reviewStasticsLeftTop"></div>
        <div class="reviewStasticsLeftContent">累计评价 <span class="reviewStasticsNumber"><c:if test="${! empty commentList}">${commentList.size()}</c:if></span></div>
        <div class="reviewStasticsLeftFoot"></div>
    </div>
    <div class="reviewStasticsRight">
        <div class="reviewStasticsRightEmpty"></div>
        <div class="reviewStasticsFoot"></div>
    </div>
</div>
<c:if test="${! empty commentList}">
<c:forEach items="${commentList}" var="comments">
    <div class="reviewDivlistReviews">
    <div class="reviewDivlistReviewsEach">
        <div class="reviewDate"><fmt:formatDate value="${comments.updateDate}" pattern="yyyy-MM-dd HH:mm:dd"/></div>
        <div class="reviewContent">${comments.message} </div>
        <div class="reviewUserInfo pull-right">${comments.userName}<span class="reviewUserInfoAnonymous">(匿名)</span></div>
    </div>
</div>
</c:forEach>
</c:if>

</body>
</html>
