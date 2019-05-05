<#if proofreadSumList??&&proofreadSumList?size gt 0>
	<#list proofreadSumList as proofreadSum>		
		<tr>
			<td>
				${proofreadSum.createTime!''}
			</td>
			<td>
				${proofreadSum.businessNum!''}
			</td>
			<td>
				<#if proofreadSum.fromSystem??>
					<#if proofreadSum.fromSystem=='01'>
						美期
					<#elseif proofreadSum.fromSystem=='02'>
						米融
					<#elseif proofreadSum.fromSystem=='03'>
						秒呗
					</#if>
				</#if>
				-
				<#if proofreadSum.proofreadType??>
					<#if proofreadSum.proofreadType=='01'>
						借款
					<#elseif proofreadSum.proofreadType=='02'>
						还款
					</#if>
				</#if>
			</td>
			<td>
				<#if proofreadSum.channel??>
					<#if proofreadSum.channel=='01'>
						宝付
					<#elseif proofreadSum.proofreadType=='02'>
						其他
					</#if>
				</#if>
			</td>
			<td>
				${proofreadSum.proofreadDate!''}
			</td>
			<td>
				${proofreadSum.businessTotalMoney!''}元/${proofreadSum.businessTotal!''}笔
			</td>
			<td>
				${proofreadSum.channelTotalMoney!''}元/${proofreadSum.channelTotal!''}笔
			</td>
			<td>
				${proofreadSum.successTotalMoney!''}元/${proofreadSum.successTotal!''}笔
			</td>
			<td>
				${proofreadSum.channelFailTotalMoney!''}元/${proofreadSum.channelFailTotal!''}笔
			</td>
			<td>
				${proofreadSum.businessFailTotalMoney!''}元/${proofreadSum.businessFailTotal!''}笔
			</td>
			<td>
				<#if proofreadSum.proofreadStatus??>
					<#if proofreadSum.proofreadStatus=='01'>
						已对账
					<#elseif proofreadSum.proofreadStatus=='02'>
						有异常
					<#elseif proofreadSum.proofreadStatus=='03'>
						待对账
					</#if>
				</#if>		
			</td>
			<td>
				
			</td>
			<td>
				${proofreadSum.updateTime!''}
			</td>
			<td>
				${proofreadSum.updateUser!''}
			</td>
		</tr>
  </#list>
</#if>