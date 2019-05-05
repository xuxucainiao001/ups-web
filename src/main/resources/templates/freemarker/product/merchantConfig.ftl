<div class="panel panel-default">
	<div class="panel-heading"> 条件选项 </div>
	<div class="panel-body">
		<form id="queryMerchantForm" class="form-inline">
			<div class="row">
				<div class="form-group col-md-3">
					<label>产品名称:</label>
					<input type="text" class="form-control" name="merchantName">
				</div>
				<div class="form-group col-md-3">
					<label>产品编码:</label>
					<input type="text" class="form-control" name="merchantCode">
				</div>
				<div class="form-group col-md-3">
					<label>产品描述:</label>
					<input type="text" class="form-control" name="description">
				</div>
				<div class="form-group col-md-3">
					<button type="button" class="btn btn-primary" onclick="queryMerchantConfig('1')">查询</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-success" onclick="openAddMerchantConfig()">新增商户</button>
				</div>

			</div>
		</form>
	</div>
</div>
<br>

<div class="table-responsive" style="width:1200px;overflow-x:auto;">
	<table class="table table-hover" style="width: 1800px;">
		<thead>
			<tr>
				<th>序号</th>
				<th>产品编码</th>
				<th>产品名称</th>
				<th>产品描述</th>
				<th>支付产品</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="merchantConfigBody" style="font-size: 13px;">

		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-md-4">

	</div>
	<div class="col-md-8" style="text-align: right;">
		<ul class="pagination" id="merchantConfigPage">

		</ul>
	</div>
</div>

<!--新增商户弹框-->
<div class="modal fade" id="addMerchantConfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 700px;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">新增商户</h4>
			</div>
			<div class="modal-body" style="height: 500px;overflow-y:scroll">
				<form id="addMerchantConfigForm">
					<div class="row">
						<div class="form-group col-md-8">
							<label>产品编码:</label>
							<input type="text" class="form-control" name="merchantCode" id="merchantCode">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-8">
							<label>产品名称:</label>
							<input type="text" class="form-control" name="merchantName" id="merchantName">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-8">
							<label>产品描述:</label>
							<input type="text" class="form-control" name="description" id="description">
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-8">
							<label>公钥:</label>
							<textarea id="remark" rows="5" cols="60" name="merchantPublicKey"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-md-8">
							<label>私钥:</label>
							<textarea id="remark" rows="5" cols="60" name="upsPrivateKey">${upsPrivateKey!''}</textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="addMerchantConfig()">添加</button>
			</div>
		</div>
	</div>
</div>

<!--配置商户弹框-->
<div class="modal fade" id="merchantConfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 700px;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">商户配置</h4>
			</div>
			<div class="modal-body" style="height: 500px;overflow-y:scroll">
				<form id="configForm">
					<!-- 列表详情-->
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="updateMerchantConfig()">修改</button>
			</div>
		</div>
	</div>
</div>

<!--新增支付产品弹框-->
<div class="modal fade" id="addMerchantOrderType" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 300px;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">添加支付产品</h4>
			</div>
			<div class="modal-body" style="height: 300px;">
				<form id="addMerchantOrderTypeForm" class="form-inline">
					<input type="hidden" name="merchantId" value="" id="merchantId">
					<div class="row">
						<div class="form-group col-md-8">
							<label>支付产品:</label>
							<select class="form-control" name="orderTypeId">
								<option value="">--请选择--</option>
								<#if orderTypeList??&&orderTypeList?has_content>
									<#list orderTypeList as orderType>
										<option value="${orderType.id!''}">${orderType.orderTypeName}</option>
									</#list>
								</#if>
							</select>
						</div>
					</div>
					<br />
					<div class="row">
						<div class="form-group col-md-8">
							<label>生效日期:</label>
							<input type="text" class="form-control date" name="startTime">
						</div>
					</div>
					<br />
					<div class="row">
						<div class="form-group col-md-8">
							<label>失效日期:</label>
							<input type="text" class="form-control date" name="endTime">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="addMerchantOrderType()">新增</button>
			</div>
		</div>
	</div>
</div>

<!--修改支付产品生效日期-->
<div class="modal fade" id="updateActiveTime" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 300px;">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">修改有效期</h4>
			</div>
			<div class="modal-body" style="height: 300px;">
				<form id="updateActiveTimeForm" class="form-inline">
					<input type="hidden" name="id" value="" id="merchantOrderTypeId">
					<div class="row">
						<div class="form-group col-md-8">
							<label>支付产品:</label>
							<input type="text" class="form-control date" readonly="true" id="orderTypeName">
						</div>
					</div>
					<br />
					<div class="row">
						<div class="form-group col-md-8">
							<label>生效日期:</label>
							<input type="text" class="form-control date" name="startTime" id="startTime">
						</div>
					</div>
					<br />
					<div class="row">
						<div class="form-group col-md-8">
							<label>失效日期:</label>
							<input type="text" class="form-control date" name="endTime" id="endTime">
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="updateActiveTime()">修改</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	//初始化日期控件 创建日期
	$(".date").datetimepicker({
		language: "zh-CN",
		format: 'yyyy-mm-dd', //显示格式
		todayHighlight: 1, //今天高亮
		minView: "month", //设置只显示到月份		
		autoclose: true,
		todayBtn: true
	});

	//加载首次查询
	$(function() {
		queryMerchantConfig(1);
	});

	//分页查询table
	function queryMerchantConfig(page) {
		var elements = {
			pageNum: page,
			data: $("#queryMerchantForm").serialize(),
			paginationId: "merchantConfigPage",
			dataAreaId: "merchantConfigBody",
			pageSize: "10",
			action: "/ups-web/productConfig/queryMerchantConfigList"
		};
		$.queryPage(elements, page);
	}

	//启用配置
	function enableConfig(id) {

		$.ajax({
			url: "/ups-web/productConfig/enableConfig?id=" + id,
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
				$alert('启用成功！');
				refreshTable();
			}
		});

	}

	//禁用配置
	function disableConfig(id) {
		$.ajax({
			url: "/ups-web/productConfig/disableConfig?id=" + id,
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
				$alert('禁用成功！');
				refreshTable();
			}
		});
	}

	//删除商户配置
	function removeMerchantConfig(id) {

		$confirm("确定删除商户吗?", function(flag) {
			if(flag) {
				$.ajax({
					url: "/ups-web/productConfig/removeMerchantConfig?id=" + id,
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

	//打开配置商户
	function openMerchantConfig(id) {

		$.ajax({
			url: "/ups-web/productConfig/openMerchantConfig?id=" + id,
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
				$("#configForm").html(vo.result.html);
				$('#merchantConfig').modal('show');
			}
		});
	}

	//更新商户配置
	function updateMerchantConfig() {
		$.ajax({
			url: "/ups-web/productConfig/updateMerchantConfig",
			type: "post",
			async: false,
			dataType: "json",
			data: $("#configForm").serialize(),
			cache: false,
			error: function() {
				$alert('网络异常，刷新后重试！')
			},
			success: function(vo) {
				$alert(vo.message);
				if(vo.resultCode != '00') {
					return;
				}
				refreshTable()
				$('#merchantConfig').modal('hide');

			}
		});
	}

	//打开新增商户对话框
	function openAddMerchantConfig() {

		$('#addMerchantConfigForm')[0].reset();
		$('#addMerchantConfig').modal('show');

	}

	//新增商户对
	function addMerchantConfig() {
		$.ajax({
			url: "/ups-web/productConfig/addMerchantConfig",
			type: "post",
			async: false,
			data: $("#addMerchantConfigForm").serialize(),
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
				$('#addMerchantConfig').modal('hide');
			}
		});
	}

	//打开新增支付产品
	function openAddMerchantOrderType(id) {
		$('#merchantId').val(id);
		$('#addMerchantOrderTypeForm')[0].reset();
		$('#addMerchantOrderType').modal('show');

	}

	//商户新增支付产品
	function addMerchantOrderType() {
		$.ajax({
			url: "/ups-web/productConfig/addMerchantOrderType",
			type: "post",
			async: false,
			data: $("#addMerchantOrderTypeForm").serialize(),
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
				$('#addMerchantOrderType').modal('hide');
				$('#merchantConfig').modal('hide');
			}
		});
	}

	//删除商户配置的支付产品
	function deleteMerchantOrderType(id) {
		$confirm("确定删除该产品吗?", function(flag) {
			if(flag) {
				$.ajax({
					url: "/ups-web/productConfig/deleteMerchantOrderType?id=" + id,
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
						$('#merchantConfig').modal('hide');
					}
				});
			}
		})
	}

	function openUpdateActiveTime(id, startTime, endTime, orderTypeName) {
		$('#merchantOrderTypeId').val(id);
		$('#startTime').val(startTime);
		$('#endTime').val(endTime);
		$('#orderTypeName').val(orderTypeName)
		$('#updateActiveTime').modal('show');
	}

	function updateActiveTime() {
		$.ajax({
			url: "/ups-web/productConfig/updateActiveTime",
			type: "post",
			async: false,
			dataType: "json",
			data: $("#updateActiveTimeForm").serialize(),
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
				$('#updateActiveTime').modal('hide');
				$('#merchantConfig').modal('hide');
			}
		});
	}

	function refreshTable() {
		var currPage = $('.pagination .active').find('a').text();
		queryMerchantConfig(currPage);
	}
</script>