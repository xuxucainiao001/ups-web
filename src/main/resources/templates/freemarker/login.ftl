
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>
        <meta charset="utf-8">
        <title>UPS后台管理中心-登录</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="stylesheet" href="static/css/login.css">
        <script src="static/js/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="static/js/public/public.js"></script> 

    </head>
    <body style="background:url(static/imge/backgrounds/3.jpg) no-repeat;background-size: cover;">

        <div class="page-container">
            <h1>UPS后台管理中心</h1>
            <div class="container">
                <input type="text" id="username" class="username" placeholder="Username">
                <input type="password" id="password" class="password" placeholder="Password">
                <button onclick="login()">登&nbsp;&nbsp;&nbsp;录</button>
            </div>
            <div class="connect">
                <!--<p>LINK TO</p>
                <p>
                    <a class="facebook" href=""></a>
                    <a class="twitter" href=""></a>
                </p>-->
            </div>
        </div>
        <br />
        <div align="center">杭州蒲公英数据科技有限公司</div>
    </body>
    <script type="text/javascript" src="static/js/public/juery-md5.js"></script>   	   
    <script type="text/javascript">
    		
    	function login(){
    		var userName=$("#username").val();
    		var userPassword=$("#password").val();
    		if($.trim(userName)==""||$.trim(userPassword)==""){
    			alert('账户或密码不能为空！');
    			return;
    		}
    		var user={};
    		user.userName=userName;
    		user.userPassword=userPassword;
    		$.ajax({
    			url:"/ups-web/loginOn",
    			type:"post",
    			async:true,
    			dataType:"json",
    			contentType:"application/json",
    			data:JSON.stringify(user),
    			success:function(data){
    				if(data.resultCode=='00'){
    					//防止缓存加时间戳
    					window.location.href="/ups-web/index";
    				}else{
    					if($.isNotEmpty(data.message)){
    						alert(data.message);
    					}else{
    						alert('登录失败！')
    					}
    				}
    			},
    			error:function(){
    				alert('网络异常！')
    			}  			
    		})
    	}
    </script>
</html>

