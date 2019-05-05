<#if proofreadSuccessList??&&proofreadSuccessList?size gt 0>
	<#list proofreadSuccessList as proofreadSuccess>		
		<tr>
			<td>
				${proofreadSuccess.businessOrderNum!''}
			</td>
			<td>
				${proofreadSuccess.proofreadDate!''}
			</td>
			<td>
				<#if proofreadSuccess.channel??>
					<#if proofreadSuccess.channel=='01'>
						宝付
					<#elseif proofreadSuccess.proofreadType=='02'>
						其他
					</#if>
				</#if>
			</td>
			<td>
				${proofreadSuccess.businessNum!''}
			</td>	
			<td>
				${proofreadSuccess.fromSystem!''}-${proofreadSuccess.proofreadType!''}
			</td>
			<td>
				${proofreadSuccess.channelExchangeMoney!''}
			</td>
			<td>
				系统归档
			</td>
			<td>
				
			</td>
			<td>
				
			</td>
			
		</tr>
  </#list>
</#if>