<div class="row">
	<div class="form-group col-md-8">
		<label>订单ID:</label>
		<input type="text" class="form-control" name="orderId" value="${orderId!''}" readonly="readonly">
	</div>
</div>
<br />
<div class="row">
	<div class="form-group col-md-8">
		<label>订单类型:</label>
		<#if orderType??>
			<#if orderType=='Pay'>
				<input type="text" class="form-control" name="bankCode" value="代付" readonly="readonly">
			<#elseif orderType=='Collect'>
				<input type="text" class="form-control" name="bankCode" value="代扣" readonly="readonly">
			<#elseif orderType=='PotocolCollect'>
				<input type="text" class="form-control" name="bankCode" value="协议代扣" readonly="readonly">
			</#if>
		</#if>
	</div>
</div>
<br />
<div class="row">
	<div class="form-group col-md-8">
		<label>商户（产品）:</label>
		<input type="text" class="form-control" name="merchantCode" value="${merchantCode!''}" readonly="readonly">
	</div>
</div>
<br />
<div class="row">
	<div class="form-group col-md-8">
		<label>订单状态:</label>
		<#if orderStatus??>
			<#if orderStatus=='new'>
				<input type="text" class="form-control" name="orderStatus" value="新订单" readonly="readonly" />
			<#elseif orderStatus=='fail'>
				<input type="text" class="form-control" name="orderStatus" value="支付失败" readonly="readonly" />
			<#elseif orderStatus=='success'>
				<input type="text" class="form-control" name="orderStatus" value="支付成功" readonly="readonly" />
			<#elseif orderStatus=='error'>
				<input type="text" class="form-control" name="orderStatus" value="支付异常" readonly="readonly" />			
			<#elseif orderStatus=='dispose'>
				<input type="text" class="form-control" name="orderStatus" value="受理中" readonly="readonly" />						
			</#if>
		</#if>		
	</div>
</div>
<br />
<div class="row">
	<div class="form-group col-md-8">
		<label>推送状态:</label>
		<#if pushStatus??>
			<#if pushStatus=='0'>
				<input type="text" class="form-control" name="pushStatus" value="待查询" readonly="readonly" />
			<#elseif pushStatus=='1'>
				<input type="text" class="form-control" name="pushStatus" value="待推送" readonly="readonly" />
			<#elseif pushStatus=='2'>
				<input type="text" class="form-control" name="pushStatus" value="推送中" readonly="readonly" />
			<#elseif pushStatus=='3'>
				<input type="text" class="form-control" name="pushStatus" value="完成推送" readonly="readonly" />
			</#if>
		</#if>		
	</div>
</div>
<br />
<div class="row">
	<div class="form-group col-md-8">
		<label>推送业务次数:</label>
		<input type="text" class="form-control" name="pushCount" value="${pushCount!''}" readonly="readonly" />
	</div>
</div>
<br />
<div class="row">
	<div class="form-group col-md-8">
		<label>查询渠道次数:</label>
		<input type="text" class="form-control" name="queryCount" value="${queryCount!''}" readonly="readonly" />
	</div>
</div>
<br />
<div class="row">
	<div class="form-group col-md-8">
		<label>下一次查询时间:</label>
		<#if nextQueryTime??>
		  <input type="text" class="form-control" name="nextQueryTime" value="${nextQueryTime?string('yyyy-MM-dd HH:mm:ss')}" readonly="readonly">
		<#else>
		  <input type="text" class="form-control" name="nextQueryTime" value="" readonly="readonly">
		</#if>
	</div>
</div>