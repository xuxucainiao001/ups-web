
<#if menus??&&menus?size gt 0>
	<#list menus?sort_by("menuOrder") as menu>
		<li  <#if (menu_index)==0>class="active"</#if> >
		   <a href="javascript:void(0)"  id="${menu.linkCode!''}" onclick="openSubMenus('${menu.linkCode!''}','${menu.menuName!''}')" >${menu.menuName!''}</a>
		</li>
	</#list>
</#if>
