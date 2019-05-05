<#if upsOrderList??&&upsOrderList?has_content>
	<#list upsOrderList as order>
		<tr>
			<td>${order_index+1}</td>
			<td>${order.merchantCode!''}</td>
			<td>
				<#if order.orderType=='Pay'>
					代付
				<#elseif order.orderType=='Collect'>
				    代扣
				<#elseif order.orderType=='ProtocolCollect'>
				    协议代扣
				</#if>
			</td>
			<td>${order.id!''}</td>
			<td>${order.upsOrderCode!''}</td>
			<td>${order.businessFlowNum!''}</td>
			<td>
				<#if order.orderStatus=='new'>
					新订单
				<#elseif order.orderStatus=='fail'>
				    支付失败
				<#elseif order.orderStatus=='success'>
				    支付成功
				<#elseif order.orderStatus=='error'>
					支付异常
				<#elseif order.orderStatus=='dispose'>
					受理中
				</#if>
			</td>
			<td>${order.amount!''}</td>
			<td>${order.payChannel!''}</td>
			<td>${order.bankCode!''}</td>
			<td>${order.userNo!''}</td>
			<td>${order.realName!''}</td>
			<td>${order.phoneNo!''}</td>
			<td>${order.identity!''}</td>
			<td>${order.phoneNo!''}</td>
			<td>${order.bankCard!''}</td>
			<td>${order.resultCode!''}</td>
			<td>${order.resultMessage!''}</td>
			<td>${order.createTime?string('yyyy-MM-dd')}</td>
			<td>${order.remark!''}</td>
			<td>
				  <a href="javascript:void(0)" class="btn btn-default" onclick="openOrderPushStatus('${order.id!''}')">查看详情</a>
          <a href="javascript:void(0)" class="btn btn-success" onclick="requeryOrder('${order.id!''}')">重推渠道</a>
          <a href="javascript:void(0)" class="btn btn-primary" onclick="pushOrder('${order.id!''}')">重推业务</a>
          <a href="javascript:void(0)" class="btn btn-danger"  onclick="queryThirdpartResult('${order.id!''}')">查看渠道</a>
			</td>
		</tr>
	</#list>
</#if>