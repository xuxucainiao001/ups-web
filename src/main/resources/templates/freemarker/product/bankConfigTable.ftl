<#if bankConfigList??&&bankConfigList?size gt 0>
	<#list bankConfigList as upsBankEntity>		
		<tr>
			<td>
				${upsBankEntity_index+1}
			</td>
			<td>
				${upsBankEntity.bankName!''}
			</td>	
			<td>
				${upsBankEntity.bankCode!''}
			</td>
			<td> 
				 <a href="javascript:void(0)" class="btn btn-danger" onclick="removeBank('${upsBankEntity.id!''}')">删除</a>		
			</td>
		</tr>
  </#list>
</#if>