<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<link href="css/fore/style.css" rel="stylesheet">
<title>搜索</title>
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
	
		<a href="index.jsp">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-home redColor"></span>
			天猫首页
		</a>	
		<span>喵，欢迎来天猫</span>
			<a href="login.jsp">请登录</a>
			<a href="register.jsp">免费注册</a>		
		<span class="pull-right">
			<a href="forebought.jsp">我的订单</a>
			<a href="forecart.jsp">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
			购物车<strong>0</strong>件</a>		
		</span>
	</div>
</nav>

<div class="searchOutDiv">
	<a href="index">
		<img id="logo" src="image/logo.gif" class="logo">
	</a>
	<form action="foresearch" method="post" >	
		<div class="searchDiv">
			<input name="keyword" type="text" value="" placeholder="时尚男鞋  太阳镜 ">
			<button  type="submit" class="searchButton">搜索</button>
			<div class="searchBelow">
				<c:if test="${! empty categoryList.get(0)}">
						<span>
							<a href="forecategory?cid=${categoryList.get(0).id}">
									${categoryList.get(0).categoryName}
							</a>
								<span>|</span>
						</span>
				</c:if>
				<c:if test="${! empty categoryList.get(1)}">
                        <span>
							<a href="forecategory?cid=${categoryList.get(1).id}">
									${categoryList.get(1).categoryName}
							</a>
								<span>|</span>
						</span>
				</c:if>
				<c:if test="${! empty categoryList.get(2)}">
                    <span>
							<a href="forecategory?cid=${categoryList.get(2).id}">
									${categoryList.get(2).categoryName}
							</a>
								<span>|</span>
						</span>
				</c:if>
				<c:if test="${! empty categoryList.get(3)}">
                        <span>
							<a href="forecategory?cid=${categoryList.get(3).id}">
									${categoryList.get(3).categoryName}
							</a>
						</span>
				</c:if>
			</div>
		</div>
	</form>	
</div>

<div class="homepageDiv">

<script>
function showProductsAsideCategorys(cid){
	$("div.eachCategory[cid="+cid+"]").css("background-color","white");
	$("div.eachCategory[cid="+cid+"] a").css("color","#87CEFA");
	$("div.productsAsideCategorys[cid="+cid+"]").show();
}


function hideProductsAsideCategorys(cid){
	$("div.eachCategory[cid="+cid+"]").css("background-color","#e2e2e3");
	$("div.eachCategory[cid="+cid+"] a").css("color","#000");
	$("div.productsAsideCategorys[cid="+cid+"]").hide();
}
$(function(){
    $("div.eachCategory").mouseenter(function(){
        var cid = $(this).attr("cid");
        showProductsAsideCategorys(cid);
    });
    $("div.eachCategory").mouseleave(function(){
        var cid = $(this).attr("cid");
        hideProductsAsideCategorys(cid);
    });
    $("div.productsAsideCategorys").mouseenter(function(){
    	var cid = $(this).attr("cid");
    	showProductsAsideCategorys(cid);
    });
    $("div.productsAsideCategorys").mouseleave(function(){
    	var cid = $(this).attr("cid");
    	hideProductsAsideCategorys(cid);
    });
	
	$("div.rightMenu span").mouseenter(function(){
		var left = $(this).position().left;
		var top = $(this).position().top;
		var width = $(this).css("width");
		var destLeft = parseInt(left) + parseInt(width)/2;
		$("img#catear").css("left",destLeft);
		$("img#catear").css("top",top-20);
		$("img#catear").fadeIn(500);
				
	});
	$("div.rightMenu span").mouseleave(function(){
		$("img#catear").hide();
	});
	
	var left = $("div#carousel-of-product").offset().left;
	$("div.categoryMenu").css("left",left-20);
	$("div.categoryWithCarousel div.head").css("margin-left",left);
	$("div.productsAsideCategorys").css("left",left-20);
	
});
</script>
<div class="carouselBackgroundDiv">
</div>
</div>
	<div class="homepageCategoryProducts">
			<c:if test="${! empty productList}">
				<c:forEach items="${productList}" var="product">
						<div class="productItem">
							<a href="foreproduct?pid=${product.id}"><img width="100px" src="image/${product.productPic}"></a>
							<a class="productItemDescLink" href="foreproduct?pid=${product.id}">
								<span class="productItemDesc">[热销]
								${product.productName}
								</span>
							</a>
							<span class="productPrice">
									${product.price}
							</span>
						</div>
				</c:forEach>
			</c:if>
			<div style="clear:both"></div>
	</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>