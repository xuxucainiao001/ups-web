<!--子菜单列表-->
<a href="#" class="list-group-item">
	&nbsp;&nbsp;
	<span class="glyphicon glyphicon-home"></span>
	&nbsp;&nbsp;
	<span class="menuName"></span>
</a> 
<#if subMenus?? && subMenus?size gt 0>
	<#list subMenus?sort_by("menuOrder") as subMenu>
          <a href="#${subMenu.linkCode!''}" class="list-group-item"  onclick="requestUrl('${subMenu.linkUrl!''}','${subMenu.menuName!''}')"> 
          	&nbsp;&nbsp;
	        <span class="glyphicon glyphicon-align-justify"></span>
           	&nbsp;&nbsp;${subMenu.menuName!''}
          </a>
    </#list>	
</#if>

<script type="text/javascript">
	//加载完后默认点击第一个选项卡
	$(function(){
		//父菜单设为蓝色
		$(".list-group-item").first().addClass("active");
		//默认加载第一个子菜单模块
		$(".list-group-item").first().next().click();
	})	
</script>

