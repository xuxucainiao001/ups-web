<#if proofreadResultList??&&proofreadResultList?size gt 0>
	<#list proofreadResultList as proofreadResult>		
		<tr>
			<td>
				${proofreadResult.proofreadDate!''}
			</td>
			<td>
				${proofreadResult.businessNum!''}
			</td>
			<td>
				<#if proofreadResult.fromSystem??>
					<#if proofreadResult.fromSystem=='01'>
						美期
					<#elseif proofreadResult.fromSystem=='02'>
						米融
					<#elseif proofreadResult.fromSystem=='03'>
						秒呗
					</#if>
				</#if>
				-
				<#if proofreadResult.proofreadType??>
					<#if proofreadResult.proofreadType=='01'>
						借款
					<#elseif proofreadResult.proofreadType=='02'>
						还款
					</#if>
				</#if>
			</td>
			<td>
				<a href="javascript:void(0)" onclick="businessDownload('${proofreadResult.channel!''}','${proofreadResult.fromSystem!''}','${proofreadResult.proofreadType!''}','${proofreadResult.proofreadDate!''}',this)">
				<#if proofreadResult.fromSystem??>
					<#if proofreadResult.fromSystem=='01'>
						美期
					<#elseif proofreadResult.fromSystem=='02'>
						米融
					<#elseif proofreadResult.fromSystem=='03'>
						秒呗
					</#if>
				</#if>				
				<#if proofreadResult.proofreadType??>
					<#if proofreadResult.proofreadType=='01'>
						借款
					<#elseif proofreadResult.proofreadType=='02'>
						还款
					</#if>
				</#if>
				-
				${proofreadResult.proofreadDate!''}
				</a>
			</td>
			<td>
				<#if proofreadResult.channel??>
					<#if proofreadResult.channel=='01'>
						宝付
					<#elseif proofreadResult.proofreadType=='02'>
						其他
					</#if>
				</#if>
			</td>
			<td>
				<a href="javascript:void(0)" onclick="channelDownload('${proofreadResult.channel!''}','${proofreadResult.fromSystem!''}','${proofreadResult.proofreadType!''}','${proofreadResult.proofreadDate!''}',this)">
				<#if proofreadResult.channel??>
					<#if proofreadResult.channel=='01'>
						宝付
					<#elseif proofreadResult.proofreadType=='02'>
						其他
					</#if>
				</#if>
				<#if proofreadResult.proofreadType??>
					<#if proofreadResult.proofreadType=='01'>
						借款
					<#elseif proofreadResult.proofreadType=='02'>
						还款
					</#if>
				</#if>
				-
				${proofreadResult.proofreadDate!''}
			    </a>
			</td>
			<td>
				${proofreadResult.proofreadDate!''}
			</td>
			<td>
				<#if proofreadResult.success??&&proofreadResult.success==true>
					对账成功
				<#else>
					对账失败
				</#if>
			</td>
			<td>
				${proofreadResult.failReason!''}
			</td>
			<td>
				<a href="javascript:void(0)" onclick="successDownLoad('${proofreadResult.channel!''}','${proofreadResult.fromSystem!''}','${proofreadResult.proofreadType!''}','${proofreadResult.proofreadDate!''}',this)">
				<#if proofreadResult.fromSystem??>
					<#if proofreadResult.fromSystem=='01'>
						美期
					<#elseif proofreadResult.fromSystem=='02'>
						米融
					<#elseif proofreadResult.fromSystem=='03'>
						秒呗
					</#if>
				</#if>	
				-
				<#if proofreadResult.channel??>
					<#if proofreadResult.channel=='01'>
						宝付
					<#elseif proofreadResult.proofreadType=='02'>
						其他
					</#if>
				</#if>
				<#if proofreadResult.proofreadType??>
					<#if proofreadResult.proofreadType=='01'>
						借款对账结果
					<#elseif proofreadResult.proofreadType=='02'>
						还款对账结果
					</#if>
				</#if>				
				-
				${proofreadResult.proofreadDate!''}
				</a>
			</td>
			<td>
				
			</td>
			<td>
			
			</td>
		</tr>
  </#list>
</#if>