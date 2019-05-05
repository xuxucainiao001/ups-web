<div class="panel panel-default">
	<div class="panel-heading"> 条件选项 </div>
	<div class="panel-body">
		<form id="queryProofreadResultForm">
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
					<label>选择对账日期</label>
					<input type="text" class="form-control date" name="proofreadDate">
				</div>
			</div>

			<div class="row">
				<div class="col-md-12" style="text-align: right;">
					<button type="button" class="btn btn-success" onclick="queryProofreadResult('1')">查询记录</button>
				</div>
			</div>
		</form>
	</div>
</div>
<br>
<div class="table-responsive" style="width:1200px;overflow-x:auto;">
	<table class="table  table-hover" style="width: 1800px;">
		<thead>
			<tr>
				<th>创建时间</th>
				<th>商户号/账户号</th>
				<th>业务类型</th>
				<th>业务账单文件</th>
				<th>对账渠道</th>
				<th>渠道资金文件</th>
				<th>对账日期</th>
				<th>对账状态</th>
				<th>失败原因</th>
				<th>结果文件</th>
				<th>最后修改时间</th>
				<th>操作员</th>
			</tr>
		</thead>
		<tbody id="proofreadResultBody" style="font-size: 13px;">

		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-md-4">

	</div>
	<div class="col-md-8" style="text-align: right;">
		<ul class="pagination" id="proofreadResultPage">

		</ul>
	</div>
</div>


<script type="text/javascript">
	$(function() {
		queryProofreadResult(1);
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

	function queryProofreadResult(page) {
		var elements = {
			pageNum: page,
			data: $("#queryProofreadResultForm").serialize(),
			paginationId: "proofreadResultPage",
			dataAreaId: "proofreadResultBody",
			pageSize: "10",
			action: "/ups-web/proofreadResult/queryProofreadResultList"
		};
		$.queryPage(elements, page);
	}

	//业务数据下载
	function businessDownload(channel, fromSystem, proofreadType, proofreadDate, e) {
		var fileName = $(e).text().trim();
	}

	//渠道数据下载
	function channelDownload(channel, fromSystem, proofreadType, proofreadDate, e) {
		var $win = $popDownloadWin();
		var closeWin = function() {
			$win.modal('hide');
		}
		window.setTimeout(closeWin, 4000);
		var fileName = $(e).text().trim();
		window.location.href = "/ups-web/proofreadResult/channelDownload/" + channel + "/" + fromSystem + "/" + proofreadType + "/" + proofreadDate + "/" + fileName;

	}

	//对账成功数据下载
	function successDownLoad(channel, fromSystem, proofreadType, proofreadDate, e) {
		var $win = $popDownloadWin();
		var closeWin = function() {
			$win.modal('hide');
		}
		window.setTimeout(closeWin, 4000);
		var fileName = $(e).text().trim();
		window.location.href = "/ups-web/proofreadResult/successDownload/" + channel + "/" + fromSystem + "/" + proofreadType + "/" + proofreadDate + "/" + fileName;
	}
</script>