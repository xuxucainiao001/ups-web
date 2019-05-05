<div class="panel panel-default">
	<div class="panel-heading"> 条件选项 </div>
	<div class="panel-body">
		<form id="queryPayChannelConfigForm" class="form-inline">
			<div class="row">
				<div class="form-group col-md-3">
					<label>渠道名称:</label>
					<input type="text" class="form-control" name="companyName">
				</div>
				<div class="form-group col-md-3">
					<label>渠道编码:</label>
					<input type="text" class="form-control" name="companyCode">
				</div>
				<div class="form-group col-md-2">
					
				</div>				
				<div class="col-md-4">
					<button type="button" class="btn btn-primary" onclick="queryPayChannelConfig('1')">查询</button>
				</div>
		
			</div>
			<br />

		</form>
	</div>
</div>
<br>

<div class="table-responsive">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>序号</th>
				<th>渠道名称</th>
				<th>渠道编码</th>
				<th>生效失效</th>
				<th>更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="payChannelConfigBody" style="font-size: 13px;">

		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-md-4">

	</div>
	<div class="col-md-8" style="text-align: right;">
		<ul class="pagination" id="payChannelConfigPage">

		</ul>
	</div>
</div>


<script type="text/javascript">
	//加载首次查询
	$(function() {
		queryPayChannelConfig(1);
	});

	//分页查询table
	function queryPayChannelConfig(page) {
		var elements = {
			pageNum: page,
			data: $("#queryPayChannelConfigForm").serialize(),
			paginationId: "payChannelConfigPage",
			dataAreaId: "payChannelConfigBody",
			pageSize: "10",
			action: "/ups-web/routeConfig/queryPayChannelList"
		};
		$.queryPage(elements, page);
	}

	//使失效
	function disablePayChannel(id) {
		$.ajax({
			url: "/ups-web/routeConfig/disablePayChannel?id=" + id,
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
				refreshTable();
			}
		});
	}
	
	//使生效
	function enablePayChannel(id) {
		$.ajax({
			url: "/ups-web/routeConfig/enablePayChannel?id=" + id,
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
				refreshTable();
			}
		});
	}

	function refreshTable() {
		var currPage = $('.pagination .active').find('a').text();
		queryPayChannelConfig(currPage);
	}
</script>