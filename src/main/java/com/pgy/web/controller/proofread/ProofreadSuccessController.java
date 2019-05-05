package com.pgy.web.controller.proofread;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.account.facade.dto.proofread.ProofreadSuccessCountDto;
import com.pgy.ups.account.facade.dubbo.api.ProofreadSuccessService;
import com.pgy.ups.account.facade.from.ProofreadSuccessForm;
import com.pgy.ups.account.facade.model.proofread.ProofreadSuccess;
import com.pgy.ups.common.annotation.ParamsLog;
import com.pgy.ups.common.page.PageInfo;
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
@RequestMapping("/proofreadSuccess")
@RequiredPermission
public class ProofreadSuccessController {

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Reference(timeout = 10000)
	private ProofreadSuccessService proofreadSuccessService;

	/**
	 * 
	 * 对账归档主页
	 * 
	 * @param
	 * 
	 */

	@RequestMapping
	@ResponseBody
	public Vo index() {
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/proofread/proofreadSuccess.ftl", null));

	}

	/**
	 * 查询对账归档列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryProofreadSuccessList")
	public Vo queryProofreadSuccessList(ProofreadSuccessForm form) {
		PageInfo<ProofreadSuccess> pageInfo = proofreadSuccessService.getPage(form);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("proofreadSuccessList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("html",
						freemarkerUtils.getFreemarkerPageToString("/proofread/proofreadSuccessTable.ftl", param))
				.putResult("total", pageInfo.getTotal());

	}

	/**
	 * 查询归档汇总数据
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryProofreadSuccessSum")
	public Vo queryProofreadSuccessSum(ProofreadSuccessForm form) {
		ProofreadSuccessCountDto proofreadSuccessCountDto = proofreadSuccessService.getProofreadSuccessCount(form);
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("proofreadTotalMoney", proofreadSuccessCountDto.getProofreadTotalMoney())
				.putResult("proofreadCount", proofreadSuccessCountDto.getProofreadCount());
	}

}
