<#if payChannelList??&&payChannelList?has_content>
	<#list payChannelList as payChannel>
		<tr>
			<td>${payChannel_index+1}</td>
			<td>${payChannel.companyName!''}</td>
			<td>${payChannel.companyCode!''}</td>
			<#if payChannel.active??&&payChannel.active==true>
				<td>生效</td>
			<#elseif payChannel.active??&&payChannel.active==false>
				<td>失效</td>
			</#if>
			<td>
				<#if payChannel.updateTime??>
					${payChannel.updateTime?string('yyyy-MM-dd hh:mm:ss')}
				</#if>
			</td>
			<td>
				<#if payChannel.active??&&payChannel.active==true>
					<a href="javascript:void(0)" class="btn btn-danger" onclick="disablePayChannel('${payChannel.id!''}')">关闭渠道</a>
				<#else>
					<a href="javascript:void(0)" class="btn btn-primary" onclick="enablePayChannel('${payChannel.id!''}')">开启渠道</a>	
				</#if>				
			</td>
		</tr>
	</#list>
</#if>