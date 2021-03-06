<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script src="js/jquery/2.0.0/jquery.min.js"></script>
	<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
	<link href="css/fore/style.css" rel="stylesheet">

<title>我的订单</title>

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


<script>
$(function(){
	$(".registerForm").submit(function(){
		if(0==$("#name").val().length){
			$("span.errorMessage").html("请输入用户名");
			$("div.registerErrorMessageDiv").css("visibility","visible");			
			return false;
		}		
		if(0==$("#password").val().length){
			$("span.errorMessage").html("请输入密码");
			$("div.registerErrorMessageDiv").css("visibility","visible");			
			return false;
		}		
		if(0==$("#repeatpassword").val().length){
			$("span.errorMessage").html("请输入重复密码");
			$("div.registerErrorMessageDiv").css("visibility","visible");			
			return false;
		}		
		if($("#password").val() !=$("#repeatpassword").val()){
			$("span.errorMessage").html("重复密码不一致");
			$("div.registerErrorMessageDiv").css("visibility","visible");			
			return false;
		}		

		return true;
	});
})
</script>

<script>
var deleteOrder = false;
var deleteOrderid = 0;

$(function(){
	$("a[orderStatus]").click(function(){
		var orderStatus = $(this).attr("orderStatus");
		if('all'==orderStatus){
			$("table[orderStatus]").show();	
		}
		else{
			$("table[orderStatus]").hide();
			$("table[orderStatus="+orderStatus+"]").show();			
		}
		
		$("div.orderType div").removeClass("selectedOrderType");
		$(this).parent("div").addClass("selectedOrderType");
	});
	
	$("a.deleteOrderLink").click(function(){
		deleteOrderid = $(this).attr("oid");
		deleteOrder = false;
		$("#deleteConfirmModal").modal("show");
	});
	
	$("button.deleteConfirmButton").click(function(){
		deleteOrder = true;
		$("#deleteConfirmModal").modal('hide');
	});	
	
	$('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
		if(deleteOrder){
			var page="foredeleteOrder";
			$.post(
				    page,
				    {"oid":deleteOrderid},
				    function(result){
						if("success"==result){
							$("table.orderListItemTable[oid="+deleteOrderid+"]").hide();
						}
						else{
							location.href="login.jsp";
						}
				    }
				);
			
		}
	})		
	
	$(".ask2delivery").click(function(){
		var link = $(this).attr("link");
		$(this).hide();
		page = link;
		$.ajax({
			   url: page,
			   success: function(result){
				alert("卖家已秒发，刷新当前页面，即可进行确认收货")
			   }
			});
		
	});
});
</script>
${message11}
<div class="boughtDiv">
	<div class="orderType">
		<div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
		<div><a  orderStatus="waitPay" href="#nowhere">待付款</a></div>
		<div><a  orderStatus="waitDelivery" href="#nowhere">待发货</a></div>
		<div><a  orderStatus="waitConfirm" href="#nowhere">待收货</a></div>
		<div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a></div>
		<div class="orderTypeLastOne"><a class="noRightborder">&nbsp;</a></div>
	</div>
	<div style="clear:both"></div>
	<div class="orderListTitle">
		<table class="orderListTitleTable">
			<tr>
				<td>宝贝</td>
				<td width="100px">单价</td>
				<td width="100px">数量</td>
				<td width="120px">实付款</td>
				<td width="100px">交易操作</td>
			</tr>
		</table>
	</div>
	<c:if test="${! empty productNumberVoList}">
		<c:forEach items="${productNumberVoList}" var="products">
	<div class="orderListItem">
		<table class="orderListItemTable" orderStatus="waitDelivery" oid="12377">
			<tr class="orderListItemFirstTR">
				<td colspan="2">
					<b><fmt:formatDate value="${userOrder.payTime}" pattern="yyyy-MM-dd HH:mm:dd"/></b>
					<span>订单号: ${userOrder.orderNumber}
					</span>
				</td>
				<td  colspan="2"><img width="13px" src="image/orderItemTmall.png">天猫商场</td>
				<td colspan="1">
					<a class="wangwanglink" href="#nowhere">
						<div class="orderItemWangWangGif"></div>
					</a>
				</td>
				<td class="orderItemDeleteTD">
					<a class="deleteOrderLink" oid="${userOrder.id}" href="#nowhere">
						<span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
					</a>
				</td>
			</tr>
			<tr class="orderItemProductInfoPartTR" >
				<td class="orderItemProductInfoPartTD"><img width="80" height="80" src="image/${products.product.productPic}"></td>
				<td class="orderItemProductInfoPartTD">
					<div class="orderListItemProductLinkOutDiv">
						<a href="foreproduct?pid=${products.product.id}">${products.product.productName}/${products.product.productTitle}</a>
						<div class="orderListItemProductLinkInnerDiv">
							<img src="image/creditcard.png" title="支持信用卡支付">
							<img src="image/7day.png" title="消费者保障服务,承诺7天退货">
							<img src="image/promise.png" title="消费者保障服务,承诺如实描述">
						</div>
					</div>
				</td>
				<td  class="orderItemProductInfoPartTD" width="100px">
					<div class="orderListItemProductPrice">￥${userOrder.totalMoney}</div>
				</td>
				<td valign="top" rowspan="1" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
					<span class="orderListItemNumber">${products.number}</span>
				</td>
				<td valign="top" rowspan="1" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
					<div class="orderListItemProductRealPrice">￥${userOrder.totalMoney}</div>
					<div class="orderListItemPriceWithTransport">￥${userOrder.totalMoney}(含运费：￥0.00)</div>
				</td>
				<td valign="top" rowspan="1" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
					<span>待发货</span>
					<c:if test="${userOrder.status == 2}">
					<button class="btn btn-info btn-sm ask2delivery" link="order_delivery?id=${userOrder.id}">催卖家发货</button>
					</c:if>
					<c:if test="${userOrder.status == 3}">
						<a href="foreconfirmPay?oid=${userOrder.id}">
							<button class="orderListItemConfirm">确认收货</button>
						</a>
					</c:if>
					<c:if test="${userOrder.status == 4}">
						<a href="forecomment?oid=${userOrder.id}">
							<button class="orderListItemConfirm">评论</button>
						</a>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
		</c:forEach>
	</c:if>
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>
