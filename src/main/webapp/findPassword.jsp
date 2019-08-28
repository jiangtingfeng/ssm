<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/jquery/2.0.0/jquery.min.js"></script>
<link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
<link href="css/fore/style.css" rel="stylesheet">

<title>找回密码</title>
	<script>
		function send(){
			var name = document.getElementById("name");
			var phone= document.getElementById("phoneNumber");
			var str = name.value;
			var phoneNumber= phone.value;
			window.location.href="<%=path%>/sendme.action?name="+str+"&phoneNumber="+phoneNumber;
		}
	</script>

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

<!--后期对链接进行修改。            ##################################################################################-->
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
			<a href="forebought">我的订单</a>
			<a href="forecart">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
			购物车<strong>0</strong>件</a>		
		</span>
	</div>
</nav>

<div class="simpleSearchOutDiv">
	<a href="index.jsp">
		<img id="simpleLogo" class="simpleLogo" src="image/simpleLogo.png">	
	</a>
	
	<form action="foresearch" method="post" >	
	<div class="simpleSearchDiv pull-right">
		<input type="text" placeholder="平衡车 原汁机"  value="" name="keyword">
		<button class="searchButton" type="submit">搜天猫</button>
		<div class="searchBelow">
					<span>
						<a href="forecategory?cid=76">
							冰箱
						</a>		
							<span>|</span>			
					</span>			
					<span>
						<a href="forecategory?cid=75">
							空调
						</a>		
							<span>|</span>		
					</span>			
					<span>
						<a href="forecategory?cid=74">
							女表
						</a>
							<span>|</span>	
					</span>			
					<span>
						<a href="forecategory?cid=73">
							男表
						</a>
					</span>	
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
		if(0==$("#phoneNumber").val().length){
			$("span.errorMessage").html("请输入手机号码");
			$("div.registerErrorMessageDiv").css("visibility","visible");
			return false;
		}
		if(0==$("#code").val().length){
			$("span.errorMessage").html("请输入验证码");
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




<form method="post" action="findPassword" class="registerForm">


<div class="registerDiv">
	<div class="registerErrorMessageDiv">
		<div class="alert alert-danger" role="alert">
		  <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
		  	<span class="errorMessage"></span>
		</div>		
	</div>

	
	<table class="registerTable" align="center">
		<tr>
			<td  class="registerTip registerTableLeftTD">找回密码</td>
			<td></td>
		</tr>
		<tr>
			<td class="registerTableLeftTD">用户名</td>
			<td  class="registerTableRightTD"><input id="name" name="name" placeholder="请输入用户名" > </td>
		</tr>
		<tr>
			<td class="registerTableLeftTD">手机号码</td>
			<td class="registerTableRightTD">
				<input id="phoneNumber" name="phoneNumber" type="text"  placeholder="输入手机号码" >
				<input type="button" value="发送验证码" id="button" onclick="send()"/>
				${flag}${flag}
			</td>
		</tr>
		<tr>
			<td  class="registerTip registerTableLeftTD">输入验证码</td>
			<td  class="registerTip registerTableRightTD">
				<input type="text" id="code" name="code" placeholder="输入验证码"/>
			</td>
		</tr>		
		<tr>
			<td class="registerTableLeftTD">新密码</td>
			<td class="registerTableRightTD"><input id="password" name="password" type="password"  placeholder="设置你的登陆密码" > </td>
		</tr>
		<tr>
			<td class="registerTableLeftTD">密码确认</td>
			<td class="registerTableRightTD"><input id="repeatpassword" type="password"   placeholder="请再次输入你的密码" > </td>
		</tr>
				
		<tr>
			<td colspan="2" class="registerButtonTD">
				<a href="registerSuccess.jsp"><button>提   交</button></a>
			</td>
			<td class="registerTableRightTD" style="color: red;">${result}</td>
		</tr>				
	</table>
</div>
</form>

<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>
