<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/21/021
  Time: 13:43
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
    <link href="css/fore/style.css" rel="stylesheet">
    <title>${product.productName}</title>

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
        <a href="login">${user.name}</a>
        <span>欢迎登入</span>
        <span class="pull-right">
			<a href="forebought">我的订单</a>
			<a href="forecart">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
			购物车<strong>0</strong>件</a>
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
                <c:if test="${! empty categorylist}">
                    <c:forEach items="${categorylist}" var="category">
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

<title>${product.productName}</title>
<div class="categoryPictureInProductPageDiv">
    <img class="categoryPictureInProductPage" width="900" height="100" src="image/${categoryPic.categoryPic}">
</div>

<div class="productPageDiv">
    <script>
/*
* 控制购买数量的多少ajax
* */
        $(function(){
            var stock = 64;
            $(".productNumberSetting").keyup(function(){
                var num= $(".productNumberSetting").val();
                num = parseInt(num);
                if(isNaN(num))
                    num= 1;
                if(num<=0)
                    num = 1;
                if(num>stock)
                    num = stock;
                $(".productNumberSetting").val(num);
            });

            $(".increaseNumber").click(function(){
                var num= $(".productNumberSetting").val();
                num++;
                if(num>stock)
                    num = stock;
                $(".productNumberSetting").val(num);
            });
            $(".decreaseNumber").click(function(){
                var num= $(".productNumberSetting").val();
                --num;
                if(num<=0)
                    num=1;
                $(".productNumberSetting").val(num);
            });

            /*
            * 弹出登入对话框
            * */
            $(".addCartButton").removeAttr("disabled");
            $(".addCartLink").click(function(){
                var page = "forecheckLogin";
                $.get(
                    page,
                    function(result){
                        if("success"==result){
                            var pid = ${product.id};
                            var num= $(".productNumberSetting").val();
                            var addCartpage = "foreaddCart";
                            $.get(
                                addCartpage,
                                {"pid":pid,"num":num},
                                function(result){
                                    if("success"==result){
                                        $(".addCartButton").html("已加入购物车");
                                        $(".addCartButton").attr("disabled","disabled");
                                        $(".addCartButton").css("background-color","lightgray")
                                        $(".addCartButton").css("border-color","lightgray")
                                        $(".addCartButton").css("color","black")
                                    }
                                    else{

                                    }
                                }
                            );
                        }
                        else{
                            $("#loginModal").modal('show');
                        }
                    }
                );
                return false;
            });
            $(".buyLink").click(function(){
                var page = "forecheckLogin";
                $.get(
                    page,
                    function(result){
                        if("success"==result){
                            var num = $(".productNumberSetting").val();
                            location.href= $(".buyLink").attr("href")+"&num="+num;
                        }
                        else{
                            $("#loginModal").modal('show');
                        }
                    }
                );
                return false;
            });

            $("button.loginSubmitButton").click(function(){
                var name = $("#name").val();
                var password = $("#password").val();

                if(0==name.length||0==password.length){
                    $("span.errorMessage").html("请输入账号密码");
                    $("div.loginErrorMessageDiv").show();
                    return false;
                }
                var page = "foreloginAjax";
                $.get(
                    page,
                    {"name":name,"password":password},
                    function(result){
                        if("success"==result){
                            location.reload();
                        }
                        else{
                            $("span.errorMessage").html("账号密码错误");
                            $("div.loginErrorMessageDiv").show();
                        }
                    }
                );
                return true;
            });

            $("img.smallImage").mouseenter(function(){
                var bigImageURL = $(this).attr("bigImageURL");
                $("img.bigImg").attr("src",bigImageURL);
            });

            $("img.bigImg").load(
                function(){
                    $("img.smallImage").each(function(){
                        var bigImageURL = $(this).attr("bigImageURL");
                        img = new Image();
                        img.src = bigImageURL;
                        img.onload = function(){
                            $("div.img4load").append($(img));
                        };
                    });
                }
            );
        });
    </script>

    <div class="imgAndInfo">
        <div class="imgInimgAndInfo">
            <img src="image/${product.productPic}" class="bigImg">
            <div class="smallImageDiv">
                <c:if test="${! empty productPicList}">
                    <c:forEach items="${productPicList}" var="productPicList">
                    <img src="image/${productPicList.productPic}" bigImageURL="image/${productPicList.productPic}" class="smallImage">
                    </c:forEach>
                </c:if>
            </div>
            <div class="img4load hidden" ></div>
        </div>

        <div class="infoInimgAndInfo">
            <div class="productTitle">
                ${product.productName}
            </div>
            <div class="productSubTitle">
                ${product.productTitle}
            </div>

            <div class="productPrice">
                <div class="juhuasuan">
                    <span class="juhuasuanBig" >聚划算</span>
                    <span>此商品即将参加聚划算，<span class="juhuasuanTime">1天19小时</span>后开始，</span>
                </div>


                <div class="productPriceDiv">
                    <div class="gouwujuanDiv"><img height="16px" src="image/gouwujuan.png">
                        <span> 全天猫实物商品通用</span>

                    </div>
                    <div class="originalDiv">
                        <span class="originalPriceDesc">价格</span>
                        <span class="originalPriceYuan">¥</span>
                        <span class="originalPrice">
                        ${product.price}
                    </span>
                    </div>

                    <div class="promotionDiv">
                        <span class="promotionPriceDesc">促销价 </span>
                        <span class="promotionPriceYuan">¥</span>
                        <span class="promotionPrice">
                        ${product.lowerPrice}
                    </span>
                    </div>
                </div>
            </div>

            <div class="productSaleAndReviewNumber">
                <div>销量 <span class="redColor boldWord"> 0</span></div>
                <div>累计评价 <span class="redColor boldWord"> 0</span></div>
            </div>
            <div class="productNumber">
                <span>数量</span>
                <span>
                <span class="productNumberSettingSpan">
                <input class="productNumberSetting" type="text" value="1">
                </span>
                <span class="arrow">
                    <a href="#nowhere" class="increaseNumber">
                    <span class="updown">
                            <img src="image/increase.png">
                    </span>
                    </a>
                    <span class="updownMiddle"> </span>
                    <a href="#nowhere"  class="decreaseNumber">
                    <span class="updown">
                            <img src="image/decrease.png">
                    </span>
                    </a>
                </span>

            件</span>
                <span>库存${product.number}件</span>
            </div>
            <div class="serviceCommitment">
                <span class="serviceCommitmentDesc">服务承诺</span>
                <span class="serviceCommitmentLink">
                <a href="#nowhere">正品保证</a>
                <a href="#nowhere">极速退款</a>
                <a href="#nowhere">赠运费险</a>
                <a href="#nowhere">七天无理由退换</a>
            </span>
            </div>

            <div class="buyDiv">
                <a class="buyLink" href="forebuyone?pid=${product.id}"><button class="buyButton">立即购买</button></a>
                <a href="#nowhere" class="addCartLink"><button class="addCartButton"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button></a>
            </div>
        </div>

        <div style="clear:both"></div>

    </div>

    <div class="productReviewDiv" >
        <div class="productReviewTopPart">
            <a  href="#nowhere" class="productReviewTopPartSelectedLink">商品详情</a>
            <a  href="#nowhere" class="selected">累计评价 <span class="productReviewTopReviewLinkNumber">0</span> </a>
        </div>
        <div class="productReviewContentPart">
        </div>
    </div>


    <div class="productDetailDiv" >
        <div class="productDetailTopPart">
            <a href="#nowhere" class="productDetailTopPartSelectedLink selected">商品详情</a>
            <a href="#nowhere" class="productDetailTopReviewLink">累计评价 <span class="productDetailTopReviewLinkNumber">0</span> </a>
        </div>


        <div class="productParamterPart">
            <div class="productParamter">产品参数：</div>

            <div class="productParamterList">

                <span>同城服务:  同城物流送货上门 </span>

                <span>坐便冲水量:  3/6L </span>

                <span>颜色分类:  【箭牌头牌 收藏送原 </span>

                <span>承重:  70kg及以上 </span>

                <span>最小坑距:  305mm 400m </span>

                <span>材质:  PP板 </span>

                <span>排水方式:  地排水 </span>

                <span>坐便器冲水方式:  喷射虹吸式 </span>

                <span>型号:  AB1116 </span>

                <span>盖板是否缓冲:  缓冲 </span>

                <span>坐便器类型:  连体式 </span>

                <span>冲水按键类型:  上按两端式 </span>

                <span>品牌:  ARROW/箭牌 </span>

            </div>
            <div style="clear:both"></div>
        </div>

        <div class="productDetailImagesPart">
            <c:if test="${! empty productPicList}">
                <c:forEach items="${productPicList}" var="productPic">
                <img src="img/${productPic.productPic}">
                </c:forEach>
            </c:if>
        </div>
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
                <div class="loginInput" >
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-user"></span>
							</span>
                    <input id="name" name="name" placeholder="手机/会员名/邮箱" type="text">
                </div>

                <div class="loginInput" >
							<span class="loginInputIcon ">
								<span class=" glyphicon glyphicon-lock"></span>
							</span>
                    <input id="password" name="password"  type="password" placeholder="密码" type="text">
                </div>
                <span class="text-danger">不要输入真实的天猫账号密码</span><br><br>
                <div>
                    <a href="#nowhere">忘记登录密码</a>
                    <a href="register" class="pull-right">免费注册</a>
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
