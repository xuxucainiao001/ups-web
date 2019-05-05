package com.pgy.web.controller.product;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.common.page.PageInfo;
import com.pgy.ups.common.utils.CookieUtils;
import com.pgy.ups.pay.interfaces.entity.UpsBankEntity;
import com.pgy.ups.pay.interfaces.form.UpsBankForm;
import com.pgy.ups.pay.interfaces.service.config.dubbo.BankConfigService;
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
@RequiredPermission
@RequestMapping("/productConfig")
public class UpsBankConfigController {

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Reference(timeout = 10000)
	private BankConfigService bankConfigService;
	
	
	@InitBinder
	public void InitBinder(WebDataBinder binder) {	
		//string 先trim再注入
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));		
	}

	/**
	 * 
	 * 银行配置主页
	 * 
	 * @param
	 * 
	 */
	@ResponseBody
	@RequestMapping("/showBank")
	public Vo showBank() {
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/product/bankConfig.ftl", null));

	}

	/**
	 * 查询列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/querybankConfigList")
	public Vo querybankConfigList(UpsBankForm form) {
		PageInfo<UpsBankEntity> pageInfo = bankConfigService.queryByForm(form);
		Map<String, Object> param = new HashMap<>();
		param.put("bankConfigList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("html", freemarkerUtils.getFreemarkerPageToString("/product/bankConfigTable.ftl", param))
				.putResult("total", pageInfo.getTotal());
	}

	/**
	 * 删除银行配置
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/removeBank")
	public Vo removeBank(Long id) {
		if(Objects.isNull(id)) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "删除id不能为空！");
		}
		bankConfigService.deleteBankConfigById(id);
		return new Vo(VoCodeConstant.SUCCESS, "删除成功！");
	}

	/**
	 * 添加配置
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/addBank")
	public Vo addBank(String bankName, String bankCode) {
		if (StringUtils.isAnyBlank(bankName, bankCode)) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "银行名称或编码不能为空！");
		}
		String userName = CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME);
		UpsBankForm form = new UpsBankForm();
		form.setBankName(bankName.trim());
		form.setBankCode(bankCode.trim());
		form.setCreateUser(userName);
		form.setUpdateUser(userName);
		bankConfigService.saveBankConfig(form);
		return new Vo(VoCodeConstant.SUCCESS, "添加成功！");
	}

}
