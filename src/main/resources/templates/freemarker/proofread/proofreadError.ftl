<div class="panel panel-default">
	<div class="panel-heading"> 条件选项 </div>
	<div class="panel-body">
		<form id="queryProofreadErrorForm">
			<div class="row">
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
					<label>异常状态</label>
					<select class="form-control" name="errorType">
						<option value="">全部</option>
						<option value="01">金额不一致</option>
						<option value="02">渠道有业务没有</option>
						<option value="03">业务有渠道没有</option>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-3">
					<label>流水状态</label>
					<select class="form-control" name="flowStatus">
						<option value="">全部</option>
						<option value="01">待处理</option>
						<option value="02">已预留</option>
						<option value="03">已归档</option>
						<option value="04">已失效</option>
						<option value="05">预留已处理</option>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label>商户订单号</label>
					<input type="text" class="form-control" name="businessOrderNum">
				</div>
				<div class="form-group col-md-3">
					<label>选择对账日期</label>
					<input type="text" class="form-control date" name="proofreadDateStart">
				</div>
				<div class="form-group col-md-3">
					<label>至：</label>
					<input type="text" class="form-control date" name="proofreadDateEnd">
				</div>
			</div>
			<div class="row">
				<div class="form-group col-md-3">
					<label>借款编号</label>
					<input type="text" class="form-control" name="borrowNum">
				</div>
			</div>
			<div class="row">
				<div class="col-md-12" style="text-align: right;">
					<button type="button" class="btn btn-success" onclick="queryProofreadError('1')">查询记录</button>
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
				<b>待处理业务交易总金额/总笔数：</b><span id='businessSum'></span>
			</div>
			<div class="col-md-4">
				<b>待处理渠道交易总金额/总笔数：</b><span id='channelSum'></span>
			</div>
			<div class="col-md-4">

			</div>
		</div>
	</div>
</div>
<div class="table-responsive" style="width:1200px;overflow-x:auto;">
	<table class="table table-hover" style="width: 1800px;">
		<thead>
			<tr>
				<th>对账日期</th>
				<th style="width: 100px">业务类型</th>
				<th>商户订单号</th>
				<th>借款编号</th>
				<th>业务交易金额</th>
				<th>业务状态</th>
				<th>业务申请时间</th>
				<th>渠道交易金额</th>
				<th>渠道订单状态</th>
				<th>渠道交易时间</th>
				<th>异常类型</th>
				<th>流水状态</th>
				<th>处理时间</th>
				<th>操作</th>
				<th>备注</th>
				<th>操作员</th>
			</tr>
		</thead>
		<tbody id="proofreadErrorBody" style="font-size: 13px;">

		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-md-4">

	</div>
	<div class="col-md-8" style="text-align: right;">
		<ul class="pagination" id="proofreadErrorPage">

		</ul>
	</div>
</div>

<!--作废提示弹框-->
<div class="modal fade" id="remarkModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">备注</h4>
			</div>
			<input type="hidden" id="errorId" value="" />
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<textarea id="remark" rows="5" cols="60" value="" placeholder="不可超过50个字"></textarea>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-danger" onclick="discard()">作废</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<script type="text/javascript">
	$(function() {
		queryProofreadError(1);
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
		autoclose: true,
		todayBtn: true
	});
    
    //查询汇总
	var queryProofreadErrorSum = function() {
		$.ajax({
			type: "post",
			url: "/ups-web/proofreadError/queryProofreadErrorSum",
			async: true,
			data: $("#queryProofreadErrorForm").serialize(),
			dataType: "json",
			success: function(vo) {
				if(vo.resultCode != '00') {
					$alert(vo.message);
					return;
				}
				$("#businessSum").text(vo.result.businessExchangeTotalMoney + '元/' + vo.result.businessExchangeCount + '笔');
				$("#channelSum").text(vo.result.channelExchangeTotalMoney + '元/' + vo.result.channelExchangeTotalCount + '笔');
			},
			error: function() {
				$alert('网络异常，刷新后重试！')
			}
		});
	}
    
    //分页查询table
	function queryProofreadError(page) {
		var elements = {
			pageNum: page,
			data: $("#queryProofreadErrorForm").serialize(),
			paginationId: "proofreadErrorPage",
			dataAreaId: "proofreadErrorBody",
			pageSize: "10",
			action: "/ups-web/proofreadError/queryProofreadErrorList",
			callbackMethod: queryProofreadErrorSum
		};
		$.queryPage(elements, page);
	}

	//废弃条目
	function openDiscardModal(id) {
		$("#errorId").val(id);
		$("#remark").val("");
		$('#remarkModal').modal('show');
	}

	function discard() {
		var id = $("#errorId").val();
		var remark = $("#remark").val();
		$confirm("确定进行作废操作吗？该操作不可恢复！", function(flag) {
			if(flag) {
				$.ajax({
					url: "/ups-web/proofreadError/discard?id=" + id + "&remark=" + remark,
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
						$alert('废弃成功！');
						refreshTable();
					}
				});
			}
		})
		$('#remarkModal').modal('hide');
	}

	//预留条目
	function reserver(id) {
		$confirm("确定预留到下一次对账吗?", function(flag) {
			if(flag) {
				$.ajax({
					url: "/ups-web/proofreadError/reserver?id=" + id,
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
						$alert('预留成功！');
						refreshTable();
					}
				});
			}
		})
	}

	function refreshTable() {
		var currPage = $('.pagination .active').find('a').text();
		queryProofreadError(currPage);
	}
</script>