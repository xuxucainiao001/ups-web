<input type="hidden" name="id" value="${id!''}">
<div class="row">
	<div class="form-group col-md-8">
		<label>产品编码:</label>
		<input type="text" class="form-control" name="merchantCode" id="merchantCode" value="${merchantCode!''}">
	</div>
</div>
<div class="row">
	<div class="form-group col-md-8">
		<label>产品名称:</label>
		<input type="text" class="form-control" name="merchantName" id="merchantName" value="${merchantName!''}">
	</div>
</div>
<div class="row">
	<div class="form-group col-md-8">
		<label>产品描述:</label>
		<input type="text" class="form-control" name="description" id="description" value="${description!''}">			
	</div>
</div>
<div class="row">
	<div class="form-group col-md-8">
		<label>公钥:</label>
		<textarea id="remark" rows="5" cols="60" name="merchantPublicKey" >${merchantPublicKey!''}</textarea>
	</div>
</div>
<div class="row">
	<div class="form-group col-md-8">
		<label>私钥:</label>
		<textarea id="remark" rows="5" cols="60" name="upsPrivateKey">${upsPrivateKey!''}</textarea>
	</div>
</div>
<div class="row">
	<div class="form-group col-md-3">
		<button type="button" class="btn btn-success" onclick="openAddMerchantOrderType('${id!''}')">添加支付产品</button>
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>序号</th>
					<th>支付产品</th>
					<th>生效日期</th>
					<th>失效日期</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody style="font-size: 13px;">
				<#if merchantOrderTypeList??&&merchantOrderTypeList?size gt 0>
					<#list merchantOrderTypeList as mot>
						<tr>
							<td>${mot_index+1}</td>
							<td>${mot.upsOrderTypeEntity.orderTypeName!''}</td>
							<td>${mot.startTime?string("yyyy-MM-dd")}</td>
							<td>${mot.endTime?string("yyyy-MM-dd")}</td>
							<td>
								<button type="button" class="btn btn-primary" onclick="openUpdateActiveTime('${mot.id!''}','${mot.startTime?string('yyyy-MM-dd')}','${mot.endTime?string('yyyy-MM-dd')}','${mot.upsOrderTypeEntity.orderTypeName!''}')">修改时间</button>&nbsp;&nbsp;
								<button type="button" class="btn btn-danger" onclick="deleteMerchantOrderType('${mot.id!''}')">删除</button>
							</td>
						</tr>
					</#list>
				</#if>
			</tbody>
		</table>
	</div>
</div>