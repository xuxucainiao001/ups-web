<#if collectChooseList??&&collectChooseList?size gt 0>
	<#list collectChooseList as collectChoose>		
		<tr>
			<td>
				${collectChoose_index+1}
			</td>
			<td>
				${collectChoose.merchantCode!''}
			</td>	
			<td>
				<#if collectChoose??&&collectChoose.collectType=='Collect'>
					代扣
				<#elseif collectChoose??&&collectChoose.collectType=='ProtocolCollect'>
					协议代扣
				</#if>
			</td>
			<td>
				${collectChoose.updateTime?string('yyyy-MM-dd')}
			</td>
			<td>
				${collectChoose.updateUser!''}
			</td>
			<td> 
				 <a href="javascript:void(0)" class="btn btn-danger" onclick="removeCollectChoose('${collectChoose.id!''}')">删除</a>&nbsp;&nbsp;
				 <a href="javascript:void(0)" class="btn btn-success" onclick="openModifyCollectChoose('${collectChoose.id!''}','${collectChoose.merchantCode!''}')">修改</a>
			</td>
		</tr>
  </#list>
</#if>