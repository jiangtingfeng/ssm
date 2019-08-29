<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: JGW
  Date: 2019/8/29
  Time: 17:33
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
    <title>${category.categoryName}</title>
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
        <c:if test="${! empty userOrder}">
            <a href="login">${userOrder.buyerName}</a>
        </c:if>
        <span>欢迎登入</span>
        <span class="pull-right">
			<a href="forebought">我的订单</a>
			<a href="forecart">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
			<c:if test="${! empty userOrder}">
                购物车<strong>${userOrder.productNumber}</strong>件</a>
            </c:if>
        </span>
    </div>
</nav>
<div >
    <a href="/index">
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

<div id="category">
    <div class="categoryPageDiv">
        <img src="image/${category.categoryPic}">

        <script>
            $(function(){
                $("input.sortBarPrice").keyup(function(){
                    var num= $(this).val();
                    if(num.length==0){
                        $("div.productUnit").show();
                        return;
                    }

                    num = parseInt(num);
                    if(isNaN(num))
                        num= 1;
                    if(num<=0)
                        num = 1;
                    $(this).val(num);


                    var begin = $("input.beginPrice").val();
                    var end = $("input.endPrice").val();
                    if(!isNaN(begin) && !isNaN(end)){
                        console.log(begin);
                        console.log(end);
                        $("div.productUnit").hide();
                        $("div.productUnit").each(function(){
                            var price = $(this).attr("price");
                            price = new Number(price);

                            if(price<=end && price>=begin)
                                $(this).show();
                        });
                    }

                });
            });
        </script>

        <div class="categorySortBar">
            <table class="categorySortBarTable categorySortTable">
                <tr>
                    <td class="grayColumn" ><a href="?cid=76&sort=all">综合<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                    <td  ><a href="?cid=76&sort=review">人气<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                    <td ><a href="?cid=76&sort=date">新品<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                    <td ><a href="?cid=76&sort=saleCount">销量<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                    <td ><a href="?cid=76&sort=price">价格<span class="glyphicon glyphicon-resize-vertical"></span></a></td>
                </tr>
            </table>

            <table class="categorySortBarTable">
                <tr>
                    <td><input class="sortBarPrice beginPrice" type="text" placeholder="请输入"></td>
                    <td class="grayColumn priceMiddleColumn">-</td>
                    <td><input class="sortBarPrice endPrice" type="text" placeholder="请输入"></td>
                </tr>
            </table>
        </div>

        <div class="categoryProducts">
            <c:if test="${! empty productList}">
                <c:forEach items="${productList}" var="product">
            <div class="productUnit" price="${product.price}">
                <div class="productUnitFrame">
                    <a href="foreproduct?pid=${product.id}">
                        <img class="productImage" src="image/${product.productPic}">
                    </a>
                    <span class="productPrice">¥${product.price}</span>
                    <a class="productLink" href="foreproduct?pid=${product.id}">
                        ${product.productName}
                    </a>
                    <a  class="tmallLink" href="foreproduct?pid=${product.id}">天猫专卖</a>
                    <div class="show1 productInfo">
                        <span class="monthDeal ">月成交 <span class="productDealNumber">243笔</span></span>
                        <span class="productReview">评价<span class="productReviewNumber">34</span></span>
                        <span class="wangwang">
					<a class="wangwanglink" href="#nowhere">
						<img src="image/wangwang.png">
					</a>

					</span>
                    </div>
                </div>
            </div>
                </c:forEach>
            </c:if>
        </div>
        <div style="clear:both"></div>
    </div>
</div>
<div class="modal " id="loginModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog loginDivInProductPageModalDiv">
        <div class="modal-content">
            <div class="loginDivInProductPage">
                <div class="loginErrorMessageDiv">
                    <div class="alert alert-danger" >
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                        <span class="errorMessage"></span>
                    </div>
                </div>

                <div class="login_acount_text">账户登录</div>
                <div class="loginInput " >
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-user"></span>
							</span>
                    <input id="name" name="name" placeholder="手机/会员名/邮箱" type="text">
                </div>

                <div class="loginInput " >
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-lock"></span>
							</span>
                    <input id="password" name="password"  type="password" placeholder="密码" type="text">
                </div>
                <span class="text-danger">不要输入真实的天猫账号密码</span><br><br>
                <div>
                    <a href="#nowhere">忘记登录密码</a>
                    <a href="registerPage" class="pull-right">免费注册</a>
                </div>
                <div style="margin-top:20px">
                    <button class="btn btn-block redButton loginSubmitButton" type="submit">登录</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="deleteConfirmModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog deleteConfirmModalDiv">
        <div class="modal-content">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">确认删除？</h4>
            </div>
            <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                <button class="btn btn-primary deleteConfirmButton" id="submit" type="button">确认</button>
            </div>
        </div>
    </div>
</div>
</div>

<div id="footer"  class="footer" style="display: block;">

    <div id="footer_ensure" class="footer_ensure">
        <a href="#nowhere">
            <img src="image/ensure.png">
        </a>
    </div>

    <div class="horizontal_line">
    </div>

    <div id="footer_desc" class="footer_desc">
        <div class="descColumn">
            <span class="descColumnTitle">购物指南</span>
            <a href="#nowhere" >免费注册</a>
            <a href="#nowhere" >开通支付宝</a>
            <a href="#nowhere" >支付宝充值</a>
        </div>
        <div class="descColumn">
            <span class="descColumnTitle">天猫保障</span>
            <a href="#nowhere" >发票保障</a>
            <a href="#nowhere" >售后规则</a>
            <a href="#nowhere" >缺货赔付</a>
        </div>
        <div class="descColumn">
            <span class="descColumnTitle">支付方式</span>
            <a href="#nowhere" >快捷支付</a>
            <a href="#nowhere" >信用卡</a>
            <a href="#nowhere" >蚂蚁花呗</a>
            <a href="#nowhere" >货到付款</a>
        </div>
        <div class="descColumn">
            <span class="descColumnTitle">商家服务</span>
            <a href="#nowhere" >商家入驻</a>
            <a href="#nowhere" >商家中心</a>
            <a href="#nowhere" >天猫智库</a>
            <a href="#nowhere" >天猫规则</a>
            <a href="#nowhere" >物流服务</a>
            <a href="#nowhere" >喵言喵语</a>
            <a href="#nowhere" >运营服务</a>
        </div>
        <div class="descColumn">
            <span class="descColumnTitle">手机天猫</span>
            <a href="#nowhere" ><img src="image/ma.png"></a>
        </div>

    </div>

    <div style="clear:both">

    </div>




    <div id="copyright" class="copyright">
        <div class="coptyrightMiddle">
            <img id="cateye" class="cateye" src="image/cateye.png">
            <div class="white_link" >
                <a href="#nowhere" style="padding-left:0px" >关于天猫</a>
                <a href="#nowhere" > 帮助中心</a>
                <a href="#nowhere" >开放平台</a>
                <a href="#nowhere" >  诚聘英才</a>
                <a href="#nowhere" >联系我们</a>
                <a href="#nowhere" >网站合作</a>
                <a href="#nowhere" >法律声明</a>
                <a href="#nowhere" >知识产权</a>
                <a href="#nowhere" >  廉正举报	</a>
            </div>
            <div class="white_link" >
                <a href="#nowhere"  style="padding-left:0px" > 阿里巴巴集团</a><span class="slash">|</span>
                <a href="#nowhere" > 淘宝网</a><span class="slash">|</span>
                <a href="#nowhere" >天猫 </a><span class="slash">|</span>
                <a href="#nowhere" >  聚划算</a><span class="slash">|</span>
                <a href="#nowhere" >全球速卖通</a><span class="slash">|</span>
                <a href="#nowhere" >阿里巴巴国际交易市场</a><span class="slash">|</span>
                <a href="#nowhere" >1688</a><span class="slash">|</span>
                <a href="#nowhere" >阿里妈妈</a><span class="slash">|</span>
                <a href="#nowhere" >  阿里旅行·去啊	</a><span class="slash">|</span>
                <a href="#nowhere" >  阿里云计算	</a><span class="slash">|</span>
                <a href="#nowhere" >  阿里通信 	</a><span class="slash">|</span>
                <a href="#nowhere" >  YunOS	</a><span class="slash">|</span>
                <a href="#nowhere" >  阿里旅行·去啊	</a><span class="slash">|</span>
                <a href="#nowhere" >   万网	</a><span class="slash">|</span>
                <a href="#nowhere" >  高德	</a><span class="slash">|</span>
                <a href="#nowhere" > 优视 	</a><span class="slash">|</span>
                <a href="#nowhere" >  友盟	</a><span class="slash">|</span>
                <a href="#nowhere" >  虾米	</a><span class="slash">|</span>
                <a href="#nowhere" >  天天动听	</a><span class="slash">|</span>
                <a href="#nowhere" >  来往	</a><span class="slash">|</span>
                <a href="#nowhere" >  钉钉	</a><span class="slash">|</span>
                <a href="#nowhere" >  支付宝 		</a>
            </div>

            <div class="license">
                <span>增值电信业务经营许可证： 浙B2-20110446</span>
                <span>网络文化经营许可证：浙网文[2015]0295-065号</span>
                <span>互联网医疗保健信息服务 审核同意书 浙卫网审【2014】6号 </span>
                <span>互联网药品信息服务资质证书编号：浙-（经营性）-2012-0005</span>
                <div class="copyRightYear">&copy; 2003-2016 TMALL.COM 版权所有</div>
                <div>
                    <img src="image/copyRight1.jpg">
                    <img src="image/copyRight2.jpg">
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
