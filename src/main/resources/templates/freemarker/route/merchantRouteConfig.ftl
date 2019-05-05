<div class="panel panel-default">
	<div class="panel-heading"> 条件选项 </div>
	<div class="panel-body">
		<form id="merchantRouteConfigForm" class="form-inline">
			<div class="row">
				<div class="form-group col-md-3">
					<label>产品名称:</label>
					<select class="form-control" name="merchantName">
						<option value="">--全部--</option>
						<#if merchantConfigList??&&merchantConfigList?has_content>
							<#list merchantConfigList as merchantConfig>
								<option value="${merchantConfig.id!''}">${merchantConfig.merchantName!''}</option>
							</#list>
						</#if>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label>支付类型:</label>
					<select class="form-control" name="orderTypeId">
						<option value="">--全部--</option>
						<#if orderTypeList??&&orderTypeList?has_content>
							<#list orderTypeList as orderType>
								<option value="${orderType.id!''}">${orderType.orderTypeName!''}</option>
							</#list>
						</#if>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label>配置状态:</label>
					<select class="form-control" name="routeStatus">
						<option value="">--全部--</option>
						<option value="0">开启默认</option>
						<option value="1">开启路由</option>
					</select>
				</div>
				<div class="form-group col-md-3">
					<label>默认渠道:</label>
					<select class="form-control" name="defaultPayChannel">
						<option value="">--全部--</option>
						<#if payChannelList??&&payChannelList?has_content>
							<#list payChannelList as payChannel>
								<option value="${payChannel.companyCode!''}">${payChannel.companyName!''}</option>
							</#list>
						</#if>
					</select>
				</div>
			</div>
			<br />
			<div class="row">
				<div class="col-md-9">
				</div>
				<div class="col-md-3">
					<button type="button" class="btn btn-primary" onclick="queryMerchantRouteConfig('1')">查询</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
				<th>产品编码</th>
				<th>产品名称</th>
				<th>支付类型</th>
				<th>默认配置状态</th>
				<th>默认渠道</th>
				<th>更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="merchantRouteConfigBody" style="font-size: 13px;">

		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-md-4">

	</div>
	<div class="col-md-8" style="text-align: right;">
		<ul class="pagination" id="merchantRouteConfigPage">

		</ul>
	</div>
</div>

<!--添加弹框-->
<div class="modal fade" id="updateMerchantRouteConfig" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">配置默认通道</h4>
			</div>
			<div class="modal-body">
				<form id="updateMerchantRouteConfigForm" class="form-inline">
					<input type="hidden" name="id" id="merchantRouteConfigId">
					<div class="row">
						<div class="form-group col-md-8">
							<label>选择通道:</label>
							<select class="form-control" name="defaultPayChannel" id="defaultPayChannel">
							<option value="">--请选择--</option>
							<#if payChannelList??&&payChannelList?has_content>
								<#list payChannelList as payChannel>
									<option value="${payChannel.companyCode!''}">${payChannel.companyName!''}</option>
								</#list>
							</#if>
							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="upadteMerchantRouteConfig()">修改</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	//加载首次查询
	$(function() {
		queryMerchantRouteConfig(1);
	});

	//分页查询table
	function queryMerchantRouteConfig(page) {
		var elements = {
			pageNum: page,
			data: $("#merchantRouteConfigForm").serialize(),
			paginationId: "merchantRouteConfigPage",
			dataAreaId: "merchantRouteConfigBody",
			pageSize: "10",
			action: "/ups-web/routeConfig/queryMerchantRouteConfigList"
		};
		$.queryPage(elements, page);
	}

	//开启默认
	function openDefault(id) {
		$.ajax({
			url: "/ups-web/routeConfig/openDefault?id=" + id,
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

	//开启路由
	function openRoute(id) {
		$.ajax({
			url: "/ups-web/routeConfig/openRoute?id=" + id,
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
    
    //打开配置对话框
	function openMerchantRouteConfig(id,payChannel) {
		
        $('#merchantRouteConfigId').val(id);
        $('#defaultPayChannel').val(payChannel);
        $('#updateMerchantRouteConfig').modal('show');
        
	}
	
	function upadteMerchantRouteConfig(){
		$.ajax({
			url: "/ups-web/routeConfig/upadteMerchantRouteConfig",
			type: "post",
			async: false,
			dataType: "json",
			data:$('#updateMerchantRouteConfigForm').serialize(),
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
		 $('#updateMerchantRouteConfig').modal('hide');
	}
	
	

	function refreshTable() {
		var currPage = $('.pagination .active').find('a').text();
		queryMerchantRouteConfig(currPage);
	}
</script>