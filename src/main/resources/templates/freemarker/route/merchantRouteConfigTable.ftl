<#if merchantRouteConfigList??&&merchantRouteConfigList?has_content>
	<#list merchantRouteConfigList as mrc>
		<tr>
			<td>${mrc_index+1}</td>
			<td>${mrc.merchantConfigEntity.merchantCode!''}</td>
			<td>${mrc.merchantConfigEntity.merchantName!''}</td>
			<td>${mrc.upsOrderTypeEntity.orderTypeName!''}</td>
			<#if mrc.routeStatus??&&mrc.routeStatus=='0'>
				<td>开启默认</td>
				<#elseif mrc.routeStatus??&&mrc.routeStatus=='1'>
					<td>开启路由</td>
			</#if>
			<td>${mrc.defaultPayChannel!''}</td>
			<td>
				<#if mrc.updateTime??>
					${mrc.updateTime?string('yyyy-MM-dd hh:mm:ss')}
				</#if>
			</td>
			<td>
				<a href="javascript:void(0)" class="btn btn-default" onclick="openMerchantRouteConfig('${mrc.id!''}','${mrc.defaultPayChannel!''}')">配置</a>
				<#if mrc.routeStatus??&&mrc.routeStatus=='0'>
					<a href="javascript:void(0)" class="btn btn-danger" onclick="openRoute('${mrc.id!''}')">开启路由</a>
				<#else>
					<a href="javascript:void(0)" class="btn btn-primary" onclick="openDefault('${mrc.id!''}')">开启默认</a>	
				</#if>				
			</td>
		</tr>
	</#list>
</#if>