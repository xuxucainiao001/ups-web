<div class="panel panel-default">
	<div class="panel-heading"> 条件选项 </div>
	<div class="panel-body">
		<form id="queryProofreadSuccessForm">
		<div class="row">
			<div class="form-group col-md-3">
				<label>对账日期</label>
				<input type="text" class="form-control date" name="proofreadDateStart">
			</div>
			<div class="form-group col-md-3">
				<label>至</label>
				<input type="text" class="form-control date" name="proofreadDateEnd">
			</div>
			<div class="form-group col-md-3">
				<label>对账渠道</label>
				<select class="form-control" name="channel">
					<option value="">全部</option>
					<option value="01">宝付</option>
				</select>
			</div>
			<div class="form-group col-md-3">
				<label>系统</label>
				<select class="form-control" name="fromSystem">
					<option value="">全部</option>
					<option value="01">美期</option>
				</select>
			</div>
			<div class="form-group col-md-3">
				<label>业务类型</label>
				<select class="form-control" name="proofreadType">
					<option value="">全部</option>
					<option value="01">借款</option>
					<option value="02">还款</option>
				</select>
			</div>
			<div class="form-group col-md-3">
				<label>商户订单号</label>
				<input type="text" class="form-control" name="businessOrderNum">
			</div>
			<div class="form-group col-md-3">
				<label>商户号</label>
				<input type="text" class="form-control" name="businessNum">
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="text-align: right;">
				<button type="button" class="btn btn-success" onclick="queryProofreadSuccess('1')">查询记录</button>
			</div>
		</div>
		</form>
	</div>
</div>
<br>
<div class="panel panel-default">
	<div class="panel-body">
		<div class="row">
			<div class="col-md-4">
				<b>交易总金额/总笔数：</b><span id='successSum'></span>
			</div>		
			<div class="col-md-8">

			</div>
		</div>
	</div>
</div>
<div class="table-responsive" style="width:1200px;overflow-x:auto;">
	<table class="table  table-hover" style="width: 1200px;">
		<thead>
			<tr>
				<th>商户订单号</th>
				<th>对账日期</th>
				<th>对账渠道</th>
				<th>商户号/账户号</th>
                <th style="width: 100px;">业务类型</th>
				<th>金额</th>
				<th>流水状态</th>
				<th>备注</th>
				<th>操作员</th>				
			</tr>
		</thead>
		<tbody id="proofreadSuccessBody" style="font-size: 13px;">

		</tbody>
	</table>
</div>
<div class="row">
	<div class="col-md-4">

	</div>
	<div class="col-md-8" style="text-align: right;">
		<ul class="pagination" id="proofreadSuccessPage">
		</ul>
	</div>
</div>
</div>
<script type="text/javascript">
	$(function() {
		queryProofreadSuccess(1);
	});
	//初始化日期控件 对账日期
	$(".date").datetimepicker({
		language: "zh-CN",
		format: 'yyyy-mm-dd', //显示格式
		todayHighlight: 1, //今天高亮
		minView: "month", //设置只显示到月份		
		autoclose: true,
		todayBtn: true
	});

	//初始化日期控件 创建日期
	$(".datetime").datetimepicker({
		language: "zh-CN",
		format: 'yyyy-mm-dd hh:ii:ss', //显示格式
		todayHighlight: 1, //今天高亮
		minView: "hour",
		autoclose: true,
		todayBtn: true
	});
	
	//查询汇总
	var queryProofreadSuccessSum = function() {
		$.ajax({
			type: "post",
			url: "/ups-web/proofreadSuccess/queryProofreadSuccessSum",
			async: true,
			data: $("#queryProofreadSuccessForm").serialize(),
			dataType: "json",
			success: function(vo) {
				if(vo.resultCode != '00') {
					$alert(vo.message);
					return;
				}
				$("#successSum").text(vo.result.proofreadTotalMoney + '元/' + vo.result.proofreadCount + '笔');
			},
			error: function() {
				$alert('网络异常，刷新后重试！')
			}
		});
	}

	function queryProofreadSuccess(page) {
		var elements = {
			pageNum: page,
			data: $("#queryProofreadSuccessForm").serialize(),
			paginationId: "proofreadSuccessPage",
			dataAreaId: "proofreadSuccessBody",
			pageSize: "10",
			action: "/ups-web/proofreadSuccess/queryProofreadSuccessList",
			callbackMethod: queryProofreadSuccessSum
		};
		$.queryPage(elements, page);
	}
</script>