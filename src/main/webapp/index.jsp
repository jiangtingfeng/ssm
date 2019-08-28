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
<title>模仿天猫官网</title>
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
	<a href="index.jsp">
		<img id="logo" src="image/logo.gif" class="logo">
	</a>
	<form action="foresearch" method="post" >	
		<div class="searchDiv">
			<input name="keyword" type="text" value="" placeholder="时尚男鞋  太阳镜 ">
			<button  type="submit" class="searchButton">搜索</button>
			<div class="searchBelow">
						<span>
							<a href="forecategory?cid=79">
								平衡车
							</a>		
								<span>|</span>
						</span>			
						<span>
							<a href="forecategory?cid=78">
								扫地机器人 
							</a>
								<span>|</span>	
						</span>		
						<span>
							<a href="forecategory?cid=77">
								原汁机
							</a>		
								<span>|</span>		
						</span>			
						<span>
							<a href="forecategory?cid=76">
								冰箱
							</a>
						</span>		
			</div>
		</div>
	</form>	
</div>

<title>模仿天猫官网</title>

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

<img src="image/catear.png" id="catear" class="catear"/>
	
<div class="categoryWithCarousel">


<div class="headbar show1">
	<div class="head ">
	
		<span style="margin-left:10px" class="glyphicon glyphicon-th-list"></span>
		<span style="margin-left:10px" >商品分类</span>
		
	</div>
	
	<div class="rightMenu">
		<span><a href=""><img src="image/chaoshi.png"/></a></span>
		<span><a href=""><img src="image/guoji.png"/></a></span>
        


				<span>
				<a href="forecategory?cid=83">
					平板电视
				</a></span>			
			
				<span>
				<a href="forecategory?cid=82">
					马桶
				</a></span>			
			
				<span>
				<a href="forecategory?cid=81">
					沙发
				</a></span>		
				<span>
				<a href="forecategory?cid=80">
					电热水器
				</a></span>		
	</div>
	
</div>


<div style="position: relative">

<div class="categoryMenu">
		
			<div cid="83" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=83">
					平板电视
				</a>
			</div>
		
			<div cid="82" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=82">
					马桶
				</a>
			</div>
		
			<div cid="81" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=81">
					沙发
				</a>
			</div>
		
			<div cid="80" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=80">
					电热水器
				</a>
			</div>
		
			<div cid="79" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=79">
					平衡车
				</a>
			</div>
		
			<div cid="78" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=78">
					扫地机器人 
				</a>
			</div>
		
			<div cid="77" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=77">
					原汁机
				</a>
			</div>
		
			<div cid="76" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=76">
					冰箱
				</a>
			</div>
		
			<div cid="75" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=75">
					空调
				</a>
			</div>
		
			<div cid="74" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=74">
					女表
				</a>
			</div>
		
			<div cid="73" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=73">
					男表
				</a>
			</div>
		
			<div cid="72" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=72">
					男士手拿包 
				</a>
			</div>
		
			<div cid="71" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=71">
					男士西服
				</a>
			</div>
		
			<div cid="69" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=69">
					时尚男鞋
				</a>
			</div>
		
			<div cid="68" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=68">
					品牌女装
				</a>
			</div>
		
			<div cid="64" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=64">
					太阳镜
				</a>
			</div>
		
			<div cid="60" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=60">
					安全座椅
				</a>
			</div>
		
	</div>  
</div>

<div id="carousel-of-product"  class="carousel-of-product carousel slide1" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-of-product" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-of-product" data-slide-to="1"></li>
    <li data-target="#carousel-of-product" data-slide-to="2"></li>
    <li data-target="#carousel-of-product" data-slide-to="3"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img class="carousel carouselImage" src="image/1.jpg" >
    </div>
    <div class="item">
      <img  class="carouselImage" src="image/2.jpg" >
    </div>
    <div class="item">
		<img  class="carouselImage" src="image/3.jpg" >
    </div>

    <div class="item">
        <img  class="carouselImage" src="image/4.jpg" >
    </div>

  </div>

  <!-- Controls -->
<!--   <a class="left carousel-control" href="#carousel-of-product" role="button" data-slide="prev"> -->
<!--     <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> -->

<!--   </a> -->
<!--   <a class="right carousel-control" href="#carousel-of-product" role="button" data-slide="next"> -->
<!--     <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> -->

<!--   </a> -->

</div>	

<div class="carouselBackgroundDiv">
</div>
</div>
<jsp:include page="productList.jsp"></jsp:include>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>