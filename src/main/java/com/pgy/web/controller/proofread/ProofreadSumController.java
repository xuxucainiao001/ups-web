package com.pgy.web.controller.proofread;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.account.facade.dubbo.api.ProofreadAccountApi;
import com.pgy.ups.account.facade.dubbo.api.ProofreadSumService;
import com.pgy.ups.account.facade.from.ProofreadSumForm;
import com.pgy.ups.account.facade.model.proofread.ProofreadResult;
import com.pgy.ups.account.facade.model.proofread.ProofreadSum;
import com.pgy.ups.common.annotation.ParamsLog;
import com.pgy.ups.common.exception.ParamValidException;
import com.pgy.ups.common.page.PageInfo;
import com.pgy.ups.common.utils.DateUtils;
import com.pgy.ups.common.utils.ParamUtils;
import com.pgy.web.constant.VoCodeConstant;
import com.pgy.web.model.vo.Vo;
import com.pgy.web.utils.FreemarkerUtils;
import com.pgy.web.utils.annotation.RequiredPermission;

/**
 * 对账汇总登录
 * 
 * @author 墨凉
 *
 */
@Controller
@ParamsLog
@RequestMapping("/proofreadSum")
@RequiredPermission
public class ProofreadSumController {

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Reference(timeout = 10000)
	private ProofreadSumService proofreadSumService;
	
	@Reference(timeout = 60000,cluster="failfast")
	private ProofreadAccountApi proofreadAccountApi;

	/**
	 * 
	 * 对账汇总主页
	 * 
	 * @param
	 * 
	 */

	@RequestMapping
	@ResponseBody
	public Vo index(ModelMap modelMap) {
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/proofread/proofreadSum.ftl", null));

	}

	/**
	 * 查询对账汇总列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryProofreadSumList")
	public Vo queryProofreadSumList(ProofreadSumForm form) {
		PageInfo<ProofreadSum> pageInfo = proofreadSumService.getPage(form);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("proofreadSumList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("html", freemarkerUtils.getFreemarkerPageToString("/proofread/proofreadSumTable.ftl", param))
				.putResult("total", pageInfo.getTotal());

	}
	
	/**
	 * 重新对账触发
	 * @param date
	 * @param proofreadType
	 * @param fromSystem
	 * @return
	 * @throws ParamValidException
	 */
	@ResponseBody
	@RequestMapping("/reProofread")
	public Vo reProofread(String date,String proofreadType,String fromSystem) throws ParamValidException {
		if(StringUtils.isEmpty(date)||StringUtils.isEmpty(proofreadType)||StringUtils.isEmpty(fromSystem)) {
			throw new ParamValidException("日期，对账类型，对账系统均不能为空！");
		}
		Date proofreadDate=DateUtils.stringToDate(date);
		if(proofreadDate.after(new Date())){
			throw new ParamValidException("对账日期不能超过今天！");
		}
		ParamUtils.validateByExp(proofreadType, "^[0][12]$");
		ParamUtils.validateByExp(fromSystem, "^[0][123]$");			
		ProofreadResult proofreadResult=proofreadAccountApi.reProofread(fromSystem, proofreadType, proofreadDate);
		if(Boolean.TRUE.equals(proofreadResult.getSuccess())) {
			return new Vo(VoCodeConstant.SUCCESS,"任务执行成功！").putResult("result", proofreadResult);
		}else {			
			return new Vo(VoCodeConstant.BUSSINDESS_ERROR,"任务执行失败！").putResult("result", proofreadResult);
		}
	}

}
