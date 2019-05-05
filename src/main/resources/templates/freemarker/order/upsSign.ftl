<div class="panel panel-default">
	<div class="panel-heading"> 条件选项 </div>
	<div class="panel-body">
		<form id="queryUpsSignForm">
			<div class="row">
				<div class="form-group col-md-3">
					<label>商户(产品):</label>
					<select class="form-control" name="merchantCode">
						<#if merchantConfigList??&&merchantConfigList?has_content>
						  <#list merchantConfigList as merchantConfig>
								<option value="${merchantConfig.merchantCode!''}" <#if merchantConfig_index==0>selected="selected"</#if>>${merchantConfig.merchantName!''}</option>
						  </#list>
						</#if>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label>签约类型:</label>
					<select class="form-control" name="signType">
						<option value="">--全部--</option>
						<option value="auth">认证签约</option>
						<option value="protocol">协议签约</option>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label>支付渠道:</label>
					<select class="form-control" name="payChannel">
						<option value="">--全部--</option>
						<#if payChannelList??&&payChannelList?has_content>
							<#list payChannelList as payChannel>
								<option value="${payChannel.companyCode!''}">${payChannel.companyName!''}</option>
							</#list>
						</#if>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label>签约状态:</label>
					<select class="form-control" name="status">
						<option value="">--全部--</option>
						<option value="10">正常</option>
						<option value="11">待确认</option>
						<option value="12">绑卡待查询</option>
						<option value="20">无效</option>
						<option value="30">过期</option>
					</select>
				</div>
			</div>
			<br />
			<div class="row">
				<div class="form-group col-md-3">
					<label>手机号:</label>
					<input type="text" class="form-control" name="phoneNo">
				</div>
				<div class="form-group col-md-3">
					<label>用户编码:</label>
					<input type="text" class="form-control" name="userNo">
				</div>
				<div class="form-group col-md-3">
					<label>银行卡号:</label>
					<input type="text" class="form-control" name="bankCard">
				</div>
				<div class="form-group col-md-3">
					<label>真实姓名:</label>
					<input type="text" class="form-control" name="realName">
				</div>
			</div>
			<br />
			<div class="row">
				<div class="form-group col-md-3">
					<label>业务流水号:</label>
					<input type="text" class="form-control" name="businessFlowNum">
				</div>
				<div class="form-group col-md-7">

				</div>
				<div class="form-group col-md-2">
					<button type="button" class="btn btn-primary " onclick="queryUpsSign('1')">查询</button>
				</div>
			</div>
		</form>
	</div>
</div>

<br>

<div class="table-responsive" style="width:1200px;overflow-x:auto;">
	<table class="table table-hover" style="width: 2600px;">
		<thead>
			<tr>
				<th>序号</th>
				<th>商户（产品）</th>
				<th>签约订单号</th>
				<th>支付渠道</th>
				<th>签约方式</th>
				<th>业务流水号</th>
				<th>银行编码</th>
				<th>用户编码</th>
				<th>真实姓名</th>
				<th>银行卡号</th>
				<th>手机号</th>
				<th>证件号码</th>
				<th>签约状态</th>
				<th>渠道签约标识</th>
				<th>创建时间</th>
				<th>完成签约时间</th>
				<th>备注</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="queryUpsSignBody" style="font-size: 13px;">

		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-md-4">

	</div>
	<div class="col-md-8" style="text-align: right;">
		<ul class="pagination" id="queryUpsSignPage">

		</ul>
	</div>
</div>


<script type="text/javascript">
	//加载首次查询
	$(function() {
		queryUpsSign(1);
	});

	//分页查询table
	function queryUpsSign(page) {
		var elements = {
			pageNum: page,
			data: $("#queryUpsSignForm").serialize(),
			paginationId: "queryUpsSignPage",
			dataAreaId: "queryUpsSignBody",
			pageSize: "10",
			action: "/ups-web/order/queryUpsSignList"
		};
		$.queryPage(elements, page);
	}

	

	function refreshTable() {
		var currPage = $('.pagination .active').find('a').text();
		queryUpsSign(currPage);
	}
</script>