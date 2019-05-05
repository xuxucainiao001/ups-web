<!DOCTYPE html>
<html>

	<head>
		<!-- Required meta tags -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="static/plugin/bootstrap3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="static/plugin/bootstrap3.3.7/css/bootstrap-datetimepicker.min.css">
		<title>UPS后台管理中心</title>
	</head>
	<script src="static/js/jquery-3.2.1.min.js"></script>
	<script src="static/plugin/bootstrap3.3.7/js/bootstrap.min.js"></script>
	<script src="static/plugin/bootstrap3.3.7/js/bootstrap-datetimepicker.min.js"></script>
	<script src="static/plugin/bootstrap3.3.7/js/bootbox.min.js"></script>
	<script type="text/javascript" src="static/js/public/public.js"></script>
	<script type="text/javascript" src="static/js/public/table-page.js"></script>
	<body>
		<nav class="navbar navbar-inverse" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header"> <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#example-navbar-collapse"> <span class="sr-only">切换导航</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
					<a class="navbar-brand" href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;UPS&nbsp;后台管理中心&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
				</div>
				<div class="collapse navbar-collapse" id="example-navbar-collapse">
					
					<ul class="nav navbar-nav" id="menus">
					<!--系统菜单列表 根据权限加载-->
					<#include "/index/menu.ftl" />
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a>欢迎您,${userName!''}</a>
						</li>
						<li>
							<a href="javascript:void(0)" onclick="refreshCache()">刷新缓存</a>
						</li>
						<li>
							<a href="javascript:void(0)" onclick="loginOut()">退出登录</a>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<div class="container-fluid">
			<div class="row">
				<!--子菜单栏-->	
				<div class="col-sm-2" id="subMenus">					
						
				</div>
				
				<div class="col-sm-10">
					<!--左边导航栏-->
					<ol class="breadcrumb alert-info">
						<li class="active menuName"> </li>
						<li class="active subMenuName"> </li>
					</ol>
					<!--内容部分-->
					<div id="content" style="height: 800px;width: 1200px;">
					
				    </div>
			    </div>
		    </div>
		</div>
		<!-- 底部页脚部分 -->
		<br>
		<br>
		<div class="footer">
			<p class="text-center"><b>Copyright 蒲公英数据科技有限公司&copy;2017-2020</b> </p>
		</div>
	   
	</body>
	
	<script type="text/javascript">
		//页面加载完成后加载第一个主菜单内容
		$(function(){
			$("#menus a").first().click();
		});
		
		//主菜单点击选中的样式
		$(".nav li").click(function() {
			$(".active").removeClass('active');
			$(this).addClass("active");
		});
		
		//登出
		function loginOut() {
			window.location.href = "/ups-web/loginOut";
		}

		//打开子菜单
		function openSubMenus(linkCode,menuName) {
			
			$.ajax({
				url: "/ups-web/index/querySubMenu/" + linkCode,
				type: "post",
				async: false,
				dataType: "json",
				cache: false,
				error: function() {
					$alert('网络异常，刷新后重试！')
				},
				success: function(vo) {
					if(vo.resultCode!='00'){
						$alert(vo.message);
						return;
					}
					$("#subMenus").empty().html(vo.result.html);
				}
			});
			$(".menuName").text(menuName);
		}

		//点击子菜单，加载数据
		function requestUrl(linkUrl,subMenuName) {
			$(".subMenuName").text(subMenuName);
			$.ajax({
				url: linkUrl,
				type: "post",
				async: false,
				dataType: "json",
				error: function() {
					$alert('网络异常，刷新后重试！')
				},
				success: function(vo) {
					if(vo.resultCode!='00'){
						$alert(vo.message);
						return;
					}
					$("#content").empty().html(vo.result.html);
				}
			});
		}
		
		function refreshCache(){
			$.ajax({
				url: "/ups-web/cache/refresh",
				type: "get",
				async: false,
				dataType: "json",
				error: function() {
					$alert('网络异常，刷新后重试！')
				},
				success: function(vo) {
					
					$alert(vo.message);
					
				}
			});
		}
	</script>

</html>