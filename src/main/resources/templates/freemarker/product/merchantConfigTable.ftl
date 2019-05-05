<#if merchantConfigList??&&merchantConfigList?size gt 0>
	<#list merchantConfigList as merchantConfig>		
		<tr>
			<td>
				${merchantConfig_index+1}
			</td>
			<td>
				${merchantConfig.merchantCode!''}
			</td>	
			<td>
				${merchantConfig.merchantName!''}
			</td>
			<td>
				${merchantConfig.description!''}
			</td>
			<td>
				<#if merchantConfig.merchantOrderTypeList??&&merchantConfig.merchantOrderTypeList?has_content>
					<#list merchantConfig.merchantOrderTypeList as mot>
						${mot.upsOrderTypeEntity.orderTypeName!''}&nbsp;&nbsp;
					</#list>
				</#if>
			</td>
			<td> 
				 <a href="javascript:void(0)" class="btn btn-warning" onclick="removeMerchantConfig('${merchantConfig.id!''}')">删除</a>
				 <a href="javascript:void(0)" class="btn btn-default" onclick="openMerchantConfig('${merchantConfig.id!''}')">配置</a>
				 <#if merchantConfig.available==true>
				     <a href="javascript:void(0)" class="btn btn-danger" onclick="disableConfig('${merchantConfig.id!''}')">禁用</a>
				 <#else>
				 	 <a href="javascript:void(0)" class="btn btn-success" onclick="enableConfig('${merchantConfig.id!''}')">启用</a>
				 </#if>
			</td>
		</tr>
  </#list>
</#if>