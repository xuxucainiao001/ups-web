<#if upsSignList??&&upsSignList?has_content>
	<#list upsSignList as sign>
		<tr>
			<td>${sign_index+1}</td>
			<td>${sign.merchantCode!''}</td>
			<td>${sign.tradeNo!''}</td>
			<td>${sign.payChannel!''}</td>
			<td>
				<#if sign.signType??>
					<#if sign.signType=='auth'>
						认证签约
						<#elseif sign.signType=='protocol'>
							协议签约
					</#if>
				</#if>
			</td>
			<td>${sign.businessFlowNum!''}</td>
			<td>${sign.bankCode!''}</td>
			<td>${sign.userNo!''}</td>
			<td>${sign.realName!''}</td>
			<td>${sign.bankCard!''}</td>
			<td>${sign.phoneNo!''}</td>
			<td>${sign.identity!''}</td>
			<td>
				<#if sign.status??>
					<#if sign.status==10>
						正常
						<#elseif sign.status==11>
							待确认
							<#elseif sign.status==12>
								绑卡待查询
								<#elseif sign.status==20>
									无效
									<#elseif sign.status==30>
										过期
					</#if>
				</#if>
			</td>
			<td>${sign.tppSignNo!''}</td>
			<td>
				<#if sign.createTime??>
					${sign.createTime?string('yyyy-MM-dd HH:mm:ss')}
				</#if>
			</td>
			<td>
				<#if sign.signDate??>
					${sign.signDate?string('yyyy-MM-dd HH:mm:ss')}
				</#if>
			</td>
			<td>${sign.remark!''}</td>
			<td></td>
		</tr>
	</#list>
</#if>