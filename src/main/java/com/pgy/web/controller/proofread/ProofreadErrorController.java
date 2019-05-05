package com.pgy.web.controller.proofread;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.account.facade.dto.proofread.ProofreadErrorCountDto;
import com.pgy.ups.account.facade.dubbo.api.ProofreadErrorService;
import com.pgy.ups.account.facade.from.ProofreadErrorForm;
import com.pgy.ups.account.facade.model.proofread.ProofreadError;
import com.pgy.ups.common.annotation.ParamsLog;
import com.pgy.ups.common.exception.ParamValidException;
import com.pgy.ups.common.page.PageInfo;
import com.pgy.ups.common.utils.CookieUtils;
import com.pgy.web.constant.VoCodeConstant;
import com.pgy.web.model.vo.Vo;
import com.pgy.web.service.impl.LoginServiceImpl;
import com.pgy.web.utils.FreemarkerUtils;
import com.pgy.web.utils.annotation.RequiredPermission;

/**
 * 对账异常明细登录
 * 
 * @author 墨凉
 *
 */
@Controller
@ParamsLog
@RequestMapping("/proofreadError")
@RequiredPermission
public class ProofreadErrorController {

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Reference(timeout = 10000)
	private ProofreadErrorService proofreadErrorService;
	
	

	/**
	 * 
	 * 对账汇总主页
	 * 
	 * @param
	 * 
	 */
	@ResponseBody
	@RequestMapping
	public Vo index() {
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/proofread/proofreadError.ftl", null));
	}

	/**
	 * 查询异常明细列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryProofreadErrorList")
	public Vo queryProofreadErrorList(ProofreadErrorForm form) {
		PageInfo<ProofreadError> pageInfo = proofreadErrorService.getPage(form);
		Map<String, Object> param = new HashMap<>();
		param.put("proofreadErrorList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("html",
						freemarkerUtils.getFreemarkerPageToString("/proofread/proofreadErrorTable.ftl", param))
				.putResult("total", pageInfo.getTotal());
	}

	/**
	 * 指定记录的id 预留到下一次对账
	 * 
	 * @param id
	 * @return
	 * @throws ParamValidException
	 */
	@ResponseBody
	@RequestMapping("/reserver")
	public Vo reserverProofreadError(Long id) throws ParamValidException {
		if (Objects.isNull(id)) {
			throw new ParamValidException("记录Id不能为空！");
		}
		String userName = CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME);
		proofreadErrorService.reservedProofread(id, userName);
		return new Vo(VoCodeConstant.SUCCESS, "预留成功！");
	}

	/**
	 * 指定记录的id 修改流水状态为废弃
	 * 
	 * @param id
	 * @return
	 * @throws ParamValidException
	 */
	@ResponseBody
	@RequestMapping("/discard")
	public Vo discardProofreadError(Long id, String remark) throws ParamValidException {
		if(StringUtils.isBlank(remark)) {
			throw new ParamValidException("备注不能为空");
		}
		if ( remark.length() > 50) {
			throw new ParamValidException("备注不能超过50个字！");
		}
		if (Objects.isNull(id)) {
			throw new ParamValidException("记录Id不能为空！");
		}
		String userName = CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME);
		proofreadErrorService.cancelProofread(id, remark, userName);
		return new Vo(VoCodeConstant.SUCCESS, "预留成功！");
	}
    
	/**
	 * 查询异常汇总数据
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryProofreadErrorSum")
	public Vo queryProofreadErrorSum(ProofreadErrorForm form) {
		ProofreadErrorCountDto proofreadErrorCountDto = proofreadErrorService.getProofreadErrorCount(form);
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("businessExchangeTotalMoney", proofreadErrorCountDto.getBusinessExchangeTotalMoney())
				.putResult("businessExchangeCount", proofreadErrorCountDto.getBusinessExchangeCount())
				.putResult("channelExchangeTotalMoney", proofreadErrorCountDto.getChannelExchangeTotalMoney())
				.putResult("channelExchangeTotalCount", proofreadErrorCountDto.getChannelExchangeTotalCount());
	}
	
	

}
