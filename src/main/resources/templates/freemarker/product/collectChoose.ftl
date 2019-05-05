<div class="panel panel-default">
	<div class="panel-heading"> 条件选项 </div>
	<div class="panel-body">
		<form id="queryCollectChooseForm" class="form-inline">
			<div class="row">
				<div class="form-group col-md-3">
					<label>商户选择:</label>
					<select class="form-control" name="merchantCode">
						<option value="">--全部--</option>
						<#if merchantConfigList??&&merchantConfigList?has_content>
							<#list merchantConfigList as merchantConfig>
								<option value="${merchantConfig.merchantCode!''}">${merchantConfig.merchantCode!''}</option>
							</#list>
						</#if>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label>代扣类型：</label>
					<select class="form-control" name="collectType">
						<option value="">--全部--</option>
						<option value="Collect">代扣</option>
						<option value="ProtocolCollect">协议代扣</option>
					</select>
				</div>
				<div class="form-group col-md-6">
					<button type="button" class="btn btn-primary " onclick="queryCollectChoose('1')">查询</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-success" onclick="openAddCollectChoose()">添加</button>
				</div>

			</div>
		</form>
	</div>
</div>
<br>

<div class="table-responsive">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>序号</th>
				<th>商户名称</th>
				<th>代扣类型</th>
				<th>更新时间</th>
				<th>更新人员</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="collectChooseBody" style="font-size: 13px;">

		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-md-4">

	</div>
	<div class="col-md-8" style="text-align: right;">
		<ul class="pagination" id="collectChoosePage">

		</ul>
	</div>
</div>

<!--修改弹框-->
<div class="modal fade" id="mdifyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">修改代扣类型</h4>
			</div>
			<div class="modal-body">
				<form id="modifyCollectChooseForm">
					<input type="hidden" name="id" id="collectChooseId">
					<div class="row">
						<div class="form-group col-md-8">
							<label>商户编码:</label>
							<input type="text" class="form-control" id="midfyMerchantCode" readonly="readonly">
						</div>
					</div>
					<br />
					<div class="row">
						<div class="form-group col-md-3">
							<label>代扣类型：</label>
							<select class="form-control" name="collectType">
								<option value="Collect">代扣</option>
								<option value="ProtocolCollect">协议代扣</option>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="modifyCollectChoose()">修改</button>
			</div>
		</div>
	</div>
</div>

<!--添加弹框-->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">新增代扣类型</h4>
			</div>
			<div class="modal-body">
				<form id="addCollectChooseForm">
					<div class="row">
						<div class="form-group col-md-3">
							<label>商户选择:</label>
							<select class="form-control" name="merchantCode" id="addMerchantCode">
								<option value="">--请选择--</option>
								<#if merchantConfigList??&&merchantConfigList?has_content>
									<#list merchantConfigList as merchantConfig>
										<option value="${merchantConfig.merchantCode!''}">${merchantConfig.merchantCode!''}</option>
									</#list>
								</#if>
							</select>
						</div>
					</div>
					<br />
					<div class="row">
						<div class="form-group col-md-3">
							<label>代扣类型：</label>
							<select class="form-control" name="collectType" id="addCollectType">
								<option value="">--请选择--</option>
								<option value="Collect">代扣</option>
								<option value="ProtocolCollect">协议代扣</option>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="addCollectChoose()">添加</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	//加载首次查询
	$(function() {
		queryCollectChoose(1);
	});

	//分页查询table
	function queryCollectChoose(page) {
		var elements = {
			pageNum: page,
			data: $("#queryCollectChooseForm").serialize(),
			paginationId: "collectChoosePage",
			dataAreaId: "collectChooseBody",
			pageSize: "10",
			action: "/ups-web/collect/queryCollectChooseList"
		};
		$.queryPage(elements, page);
	}

	//删除
	function removeCollectChoose(id) {

		$confirm("确定删除代扣配置吗?", function(flag) {
			if(flag) {
				$.ajax({
					url: "/ups-web/collect/delteCollectChoose?id=" + id,
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
						$alert('删除成功！');
						refreshTable();
					}
				});
			}
		})
	}

	//添加银行
	function openModifyCollectChoose(id, merchantCode) {
		$('#collectChooseId').val(id);
		$('#midfyMerchantCode').val(merchantCode);
		$('#mdifyModal').modal('show');
	}

	function modifyCollectChoose() {
		$.ajax({
			url: "/ups-web/collect/modifyCollectChoose",
			type: "post",
			async: false,
			data: $("#modifyCollectChooseForm").serialize(),
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
				$alert('修改成功！');
				refreshTable();
				$('#mdifyModal').modal('hide');
			}
		});
	}

	function openAddCollectChoose() {
		$('#addMerchantCode').val("");
		$('#addCollectType').val("");
		$('#addModal').modal('show');
	}

	function addCollectChoose() {
		$.ajax({
			url: "/ups-web/collect/addCollectChoose",
			type: "post",
			async: false,
			data: $("#addCollectChooseForm").serialize(),
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
				$alert('修改成功！');
				refreshTable();
				$('#addModal').modal('hide');
			}
		});
	}

	function refreshTable() {
		var currPage = $('.pagination .active').find('a').text();
		queryCollectChoose(currPage);
	}
</script>