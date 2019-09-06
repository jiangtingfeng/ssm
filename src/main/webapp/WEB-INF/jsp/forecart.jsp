<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script src="js/jquery/2.0.0/jquery.min.js"></script>
	<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
	<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
	<link href="css/fore/style.css" rel="stylesheet">
<title>购物车</title>

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
						<a href="forecategory?cid=${category.id}">
								${category.categoryName}
						</a>
							<span>|</span>
					</span>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</form>
	<div style="clear:both"></div>
</div>


<script>
var deleteOrderItem = false;
var deleteOrderItemid = 0;
$(function(){

	$("a.deleteOrderItem").click(function(){
		deleteOrderItem = false;
		var oiid = $(this).attr("oiid")
		deleteOrderItemid = oiid;
		$("#deleteConfirmModal").modal('show');	   
	});
	$("button.deleteConfirmButton").click(function(){
		deleteOrderItem = true;
		$("#deleteConfirmModal").modal('hide');
	});
	
	$('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
		if(deleteOrderItem){
			var page="foredeleteOrderItem";
			$.post(
				    page,
				    {"oiid":deleteOrderItemid},
				    function(result){
						if("success"==result){
							$("tr.cartProductItemTR[oiid="+deleteOrderItemid+"]").hide();
						}
						else{
							location.href="login.jsp";
						}
				    }
				);
			
		}
	})	
	
	$("img.cartProductItemIfSelected").click(function(){
		var selectit = $(this).attr("selectit")
		if("selectit"==selectit){
			$(this).attr("src","image/cartNotSelected.png");
			$(this).attr("selectit","false")
			$(this).parents("tr.cartProductItemTR").css("background-color","#fff");
		}
		else{
			$(this).attr("src","image/cartSelected.png");
			$(this).attr("selectit","selectit")
			$(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
		}
		syncSelect();
		syncCreateOrderButton();
		calcCartSumPriceAndNumber();
	});
	$("img.selectAllItem").click(function(){
		var selectit = $(this).attr("selectit")
		if("selectit"==selectit){
			$("img.selectAllItem").attr("src","image/cartNotSelected.png");
			$("img.selectAllItem").attr("selectit","false")
			$(".cartProductItemIfSelected").each(function(){
				$(this).attr("src","image/cartNotSelected.png");
				$(this).attr("selectit","false");
				$(this).parents("tr.cartProductItemTR").css("background-color","#fff");
			});			
		}
		else{
			$("img.selectAllItem").attr("src","image/cartSelected.png");
			$("img.selectAllItem").attr("selectit","selectit")
			$(".cartProductItemIfSelected").each(function(){
				$(this).attr("src","image/cartSelected.png");
				$(this).attr("selectit","selectit");
				$(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
			});				
		}
		syncCreateOrderButton();
		calcCartSumPriceAndNumber();
		

	});
	
	$(".orderItemNumberSetting").keyup(function(){
		var pid=$(this).attr("pid");
		var stock= $("span.orderItemStock[pid="+pid+"]").text();
		var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
		
		var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
		num = parseInt(num);
		if(isNaN(num))
			num= 1;
		if(num<=0)
			num = 1;
		if(num>stock)
			num = stock;
		
		syncPrice(pid,num,price);
	});

	$(".numberPlus").click(function(){
		
		var pid=$(this).attr("pid");
		var stock= $("span.orderItemStock[pid="+pid+"]").text();
		var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
		var num= $(".orderItemNumberSetting[pid="+pid+"]").val();

		num++;
		if(num>stock)
			num = stock;
		syncPrice(pid,num,price);
	});
	$(".numberMinus").click(function(){
		var pid=$(this).attr("pid");
		var stock= $("span.orderItemStock[pid="+pid+"]").text();
		var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
		
		var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
		--num;
		if(num<=0)
			num=1;
		syncPrice(pid,num,price);
	});	
	
	$("button.createOrderButton").click(function(){
		var params = "";
		$(".cartProductItemIfSelected").each(function(){
			if("selectit"==$(this).attr("selectit")){
				var oiid = $(this).attr("oiid");
				params += "&oiid="+oiid;
			}
		});
		params = params.substring(1);
		location.href="forebuy?"+params;
	});
	
	
	
})

function syncCreateOrderButton(){
	var selectAny = false;
	$(".cartProductItemIfSelected").each(function(){
		if("selectit"==$(this).attr("selectit")){
			selectAny = true;
		}
	});
	
	if(selectAny){
		$("button.createOrderButton").css("background-color","#C40000");
		$("button.createOrderButton").removeAttr("disabled");
	}
	else{
		$("button.createOrderButton").css("background-color","#AAAAAA");
		$("button.createOrderButton").attr("disabled","disabled");		
	}
		
}
function syncSelect(){
	var selectAll = true;
	$(".cartProductItemIfSelected").each(function(){
		if("false"==$(this).attr("selectit")){
			selectAll = false;
		}
	});
	
	if(selectAll)
		$("img.selectAllItem").attr("src","image/cartSelected.png");
	else
		$("img.selectAllItem").attr("src","image/cartNotSelected.png");
	
	
	
}
function calcCartSumPriceAndNumber(){
	var sum = 0;
	var totalNumber = 0;
	$("img.cartProductItemIfSelected[selectit='selectit']").each(function(){
		var oiid = $(this).attr("oiid");
		var price =$(".cartProductItemSmallSumPrice[oiid="+oiid+"]").text();
		price = price.replace(/,/g, "");
		price = price.replace(/￥/g, "");
		sum += new Number(price);	
		
		var num =$(".orderItemNumberSetting[oiid="+oiid+"]").val();
		totalNumber += new Number(num);	
		
	});
	
	$("span.cartSumPrice").html("￥"+formatMoney(sum));
	$("span.cartTitlePrice").html("￥"+formatMoney(sum));
	$("span.cartSumNumber").html(totalNumber);
}
function syncPrice(pid,num,price){
	$(".orderItemNumberSetting[pid="+pid+"]").val(num);
	var cartProductItemSmallSumPrice = formatMoney(num*price); 
	$(".cartProductItemSmallSumPrice[pid="+pid+"]").html("￥"+cartProductItemSmallSumPrice);
	calcCartSumPriceAndNumber();
	
	var page = "forechangeOrderItem";
	$.post(
		    page,
		    {"pid":pid,"number":num},
		    function(result){
				if("success"!=result){
					location.href="login";
				}
		    }
		);
}
</script>

<title>购物车</title>
<div class="cartDiv">
	<div class="cartTitle pull-right">
		<span>已选商品  (不含运费)</span>
		<span class="cartTitlePrice">￥0.00</span>
		<button class="createOrderButton" disabled="disabled">结 算</button>
	</div>


	<div class="cartProductList">
		<table class="cartProductTable">
			<thead>
			<tr>
				<th class="selectAndImage">
					<img selectit="false" class="selectAllItem" src="img/site/cartNotSelected.png">
					全选
				</th>
				<th>商品信息</th>
				<th>单价</th>
				<th>数量</th>
				<th width="120px">金额</th>
				<th class="operation">操作</th>
			</tr>
			</thead>
			<tbody>
			<c:if test="${! empty productNumberVoList}">
				<c:forEach items="${productNumberVoList}" var="productNumberVo">
			<tr oiid="17015" class="cartProductItemTR">
				<td>
					<img selectit="false" oiid="${userOrder.id}" class="cartProductItemIfSelected" src="image/cartNotSelected.png">
					<a style="display:none" href="#nowhere"><img src="image/cartSelected.png"></a>
					<img class="cartProductImg"  src="image/${productNumberVo.product.productPic} ">
				</td>
				<td>
					<div class="cartProductLinkOutDiv">
						<a href="foreproduct?pid=149" class="cartProductLink">${productNumberVo.product.productName}</a>
						<div class="cartProductLinkInnerDiv">
							<img src="image/creditcard.png" title="支持信用卡支付">
							<img src="image/7day.png" title="消费者保障服务,承诺7天退货">
							<img src="image/promise.png" title="消费者保障服务,承诺如实描述">
						</div>
					</div>

				</td>
				<td>
					<span  class="cartProductItemPromotionPrice">￥${productNumberVo.product.lowerPrice}</span>
				</td>
				<td>

					<div class="cartProductChangeNumberDiv">
						<span class="hidden orderItemStock " pid="${productNumberVo.product.id}">${productNumberVo.product.number}</span>
						<span class="hidden orderItemPromotePrice " pid="${productNumberVo.product.id}">${productNumberVo.product.lowerPrice}</span>
						<a  pid="${productNumberVo.product.id}" class="numberMinus" href="#nowhere">-</a>
						<input pid="${productNumberVo.product.id}" oiid="${userOrder.id}" class="orderItemNumberSetting" autocomplete="off" value="1">
						<a  stock="${productNumberVo.product.number}" pid="${productNumberVo.product.id}" class="numberPlus" href="#nowhere">+</a>
					</div>

				</td>
				<td >
							<span class="cartProductItemSmallSumPrice" oiid="${userOrder.id}" pid="${productNumberVo.product.id}" >
							￥ ${userOrder.totalMoney}
							</span>

				</td>
				<td>
					<a class="deleteOrderItem" oiid="${userOrder.id}"  href="#nowhere">删除</a>
				</td>
			</tr>
				</c:forEach>
			</c:if>
			</tbody>
		</table>
	</div>

	<div class="cartFoot">
		<img selectit="false" class="selectAllItem" src="img/site/cartNotSelected.png">
		<span>全选</span>
		<!-- 		<a href="#">删除</a> -->

		<div class="pull-right">
			<span>已选商品 <span class="cartSumNumber" >0</span> 件</span>

			<span>合计 (不含运费): </span>
			<span class="cartSumPrice" >￥0.00</span>
			<button class="createOrderButton" disabled="disabled" >结  算</button>
		</div>

	</div>

</div>


<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>