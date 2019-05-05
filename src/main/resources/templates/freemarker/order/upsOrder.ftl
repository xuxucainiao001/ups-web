<div class="panel panel-default">
	<div class="panel-heading"> 条件选项 </div>
	<div class="panel-body">
		<form id="queryUpsOrderForm">
			<div class="row">
				<div class="form-group col-md-3">
					<label>订单ID:</label>
					<input type="text" class="form-control" name="id">
				</div>
				<div class="form-group col-md-3">
					<label>订单编码:</label>
					<input type="text" class="form-control" name="upsOrderCode">
				</div>
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
					<label>支付类型:</label>
					<select class="form-control" name="orderType">
						<option value="">--全部--</option>
						<option value="pay">代付</option>
						<option value="collect">代扣</option>
						<option value="protocolCollect">协议代扣</option>
					</select>
				</div>
			</div>
			<br />
			<div class="row">
				<div class="form-group col-md-3">
					<label>用户编码:</label>
					<input type="text" class="form-control" name="userNo">
				</div>
				<div class="form-group col-md-3">
					<label>业务流水号:</label>
					<input type="text" class="form-control" name="businessFlowNum">
				</div>
				<div class="form-group col-md-3">
					<label>银行卡号:</label>
					<input type="text" class="form-control" name="bankCard">
				</div>
				<div class="form-group col-md-3">
					<label>订单状态:</label>
					<select class="form-control" name="orderStatus">
						<option value="">--全部--</option>
						<option value="new">新订单</option>
						<option value="dispose">受理中</option>
						<option value="error">发生异常</option>
						<option value="success">支付成功</option>
						<option value="fail">支付失败</option>
					</select>
				</div>
			</div>
			<br />
			<div class="row">
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
				<div class="form-group col-md-7">

				</div>
				<div class="form-group col-md-2">
					<button type="button" class="btn btn-primary " onclick="queryUpsOrder('1')">查询</button>
				</div>
			</div>
		</form>
	</div>
</div>

<br>

<div class="table-responsive" style="width:1200px;overflow-x:auto;">
	<table class="table table-hover" style="width: 3000px;">
		<thead>
			<tr>
				<th>序号</th>
				<th>商户（产品）</th>
				<th>订单类型</th>
				<th>订单ID</th>
				<th>订单编码</th>
				<th>业务流水号</th>
				<th>订单状态</th>
				<th>金额（元）</th>
				<th>支付渠道</th>
				<th>银行编码</th>
				<th>用户编码</th>
				<th>用户姓名</th>
				<th>用户手机</th>
				<th>用户身份证</th>
				<th>用户手机</th>
				<th>银行卡号</th>
				<th>渠道方返回编码</th>
				<th>渠道方返回消息</th>
				<th>订单创建时间</th>
				<th>备注信息</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="queryUpsOrderBody" style="font-size: 13px;">

		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-md-4">

	</div>
	<div class="col-md-8" style="text-align: right;">
		<ul class="pagination" id="queryUpsOrderPage">

		</ul>
	</div>
</div>

<!--订单推送状态弹框-->
<div class="modal fade" id="orderPushStatus" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">订单推送状态</h4>
			</div>
			<div class="modal-body">
				<form class="form-inline" id="orderPushStatusForm">

				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	//加载首次查询
	$(function() {
		queryUpsOrder(1);
	});

	//分页查询table
	function queryUpsOrder(page) {
		var elements = {
			pageNum: page,
			data: $("#queryUpsOrderForm").serialize(),
			paginationId: "queryUpsOrderPage",
			dataAreaId: "queryUpsOrderBody",
			pageSize: "10",
			action: "/ups-web/order/queryUpsOrderList"
		};
		$.queryPage(elements, page);
	}

	//订单推送状态
	function openOrderPushStatus(id) {
		$.ajax({
			url: "/ups-web/order/openOrderPushStatus?id=" + id,
			type: "post",
			async: false,
			dataType: "json",
			cache: false,
			error: function() {
				$alert('网络异常，刷新后重试！')
			},
			success: function(vo) {
				if(vo.resultCode != '00') {
					$alert(vo.message);
					return;
				}
				$('#orderPushStatusForm').html(vo.result.html);
				$('#orderPushStatus').modal('show');
			}
		});
	}

	//重新查询第三方渠道
	function requeryOrder(id) {
		$confirm("重推渠道会有延迟，确认操作吗？", function(flag) {
			if(flag) {
				$.ajax({
					url: "/ups-web/order/requeryOrder?id=" + id,
					type: "post",
					async: false,
					dataType: "json",
					cache: false,
					error: function() {
						$alert('网络异常，刷新后重试！')
					},
					success: function(vo) {
						$alert(vo.message);
						if(vo.resultCode != '00') {
							return;
						}
					}
				});
			}
		});
	}
    
    //订单在渠道方的状态
	function queryThirdpartResult(id) {
		$.ajax({
			url: "/ups-web/order/queryThirdpartResult?id=" + id,
			type: "post",
			async: false,
			dataType: "json",
			cache: false,
			error: function() {
				$alert('网络异常，刷新后重试！')
			},
			success: function(vo) {	
				$alert(vo.message);				
			}
		});
	}
	
	function pushOrder(id){
		$confirm("确认重推吗？", function(flag) {
			if(flag) {
				$.ajax({
					url: "/ups-web/order/pushOrder?id=" + id,
					type: "post",
					async: false,
					dataType: "json",
					cache: false,
					error: function() {
						$alert('网络异常，刷新后重试！')
					},
					success: function(vo) {
						$alert(vo.message);
						if(vo.resultCode != '00') {
							return;
						}
					}
				});
			}
		});
	}

	function refreshTable() {
		var currPage = $('.pagination .active').find('a').text();
		queryUpsOrder(currPage);
	}
</script>