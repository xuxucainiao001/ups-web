<#if proofreadErrorList??&&proofreadErrorList?size gt 0>
	<#list proofreadErrorList as proofreadError>		
		<tr>
			<td>
				${proofreadError.proofreadDate!''}
			</td>	
			<td>
				<#if proofreadError.fromSystem??>
					<#if proofreadError.fromSystem=='01'>
						美期
					<#elseif proofreadError.fromSystem=='02'>
						米融
					<#elseif proofreadError.fromSystem=='03'>
						秒呗
					</#if>
				</#if>
				-
				<#if proofreadError.proofreadType??>
					<#if proofreadError.proofreadType=='01'>
						借款
					<#elseif proofreadError.proofreadType=='02'>
						还款
					</#if>
				</#if>
			</td>
			<td>
				${proofreadError.businessOrderNum!''}
			</td>
			<td>
				${proofreadError.borrowNum!''}
			</td>
			<td>
				${proofreadError.businessExchangeMoney!''}
			</td>
			<td>
				<#if proofreadError.proofreadType??&&proofreadError.businessOrderStatuts??>
					<#if proofreadError.proofreadType=='01'>
						<#if proofreadError.businessOrderStatuts=='0'>
							申请/未审核
						<#elseif proofreadError.businessOrderStatuts=='1'>
							已结清
						<#elseif proofreadError.businessOrderStatuts=='2'>
							打款中
						<#elseif proofreadError.businessOrderStatuts=='3'>
							打款失败
						<#elseif proofreadError.businessOrderStatuts=='4'>
							关闭
						<#elseif proofreadError.businessOrderStatuts=='5'>
							已经打款/待还款
						</#if>
					<#elseif proofreadError.proofreadType=='02'>
						<#if proofreadError.businessOrderStatuts=='0'>
							新建状态
						<#elseif proofreadError.businessOrderStatuts=='1'>
							还款成功
						<#elseif proofreadError.businessOrderStatuts=='2'>
							处理中
						<#elseif proofreadError.businessOrderStatuts=='-1'>
							还款失败
	                    </#if>							
					</#if>
				</#if>
		<!--		${proofreadError.businessOrderStatuts!''}-->
			</td>
			<td>
				${proofreadError.businessOrderCreateTime!''}
			</td>
			<td>
				${proofreadError.channelExchangeMoney!''}
			</td>
			<td>
				${proofreadError.channelOrderStatus!''}
			</td>
			<td>
				${proofreadError.channelOrderCreateTime!''}
			</td>
			<td>
				<#if proofreadError.errorType??>
					<#if proofreadError.errorType=='01'>
						金额不一致
					<#elseif proofreadError.errorType=='02'>
						渠道有业务没有
					<#elseif proofreadError.errorType=='03'>
						业务有渠道没有
					</#if>
				</#if>
			</td>
			<td>
				<#if proofreadError.flowStatus??>
					<#if proofreadError.flowStatus=='01'>
						待处理
					<#elseif proofreadError.flowStatus=='02'>
						已预留
					<#elseif proofreadError.flowStatus=='03'>
						已归档
					<#elseif proofreadError.flowStatus=='04'>
						已失效
					<#elseif proofreadError.flowStatus=='05'>
						预留已处理
					</#if>
				</#if>
			</td>
			<td>
				${proofreadError.disposeTime!''}
			</td>
			<td>
				<#if proofreadError.flowStatus=='01'>
					<div class="btn-group">	
						<#if proofreadError.errorType!='01'>
							<!--金额不一致无需预留按钮-->
					      <a href="javascript:void(0)" class="btn btn-info" onclick="reserver('${proofreadError.id!''}')">预留</a>		
					    </#if>
						<a href="javascript:void(0)" class="btn btn-warning" onclick="openDiscardModal('${proofreadError.id!''}')">作废</a>					
					</div>
			    </#if>
			</td>
			<td>
			   ${proofreadError.remark!''}
			</td>
			<td>
				${proofreadError.updateUser!''}
			</td>
		</tr>
  </#list>
</#if>