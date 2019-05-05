package com.pgy.web.controller.route;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.common.page.PageInfo;
import com.pgy.ups.pay.interfaces.entity.PayCompanyEntity;
import com.pgy.ups.pay.interfaces.form.PayCompanyForm;
import com.pgy.ups.pay.interfaces.service.route.dubbo.PayCompanyService;
import com.pgy.web.constant.VoCodeConstant;
import com.pgy.web.model.vo.Vo;
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
@RequestMapping("/routeConfig")
public class PayChannelController {

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Reference(timeout = 10000)
	private PayCompanyService payCompanyService;

	/**
	 * 日期、文本参数绑定规则
	 * 
	 * @param binder
	 */
	@InitBinder
	public void InitBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(true);
		// string 先trim再注入
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
		// 指定日期解析
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	/**
	 * 
	 * 商户路由配置主页
	 * 
	 * @param
	 * 
	 */
	@ResponseBody
	@RequestMapping("/showPayChannel")
	public Vo showPayChannel() {
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/route/payChannelConfig.ftl", null));

	}

	/**
	 * 查询列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryPayChannelList")
	public Vo queryPayChannelList(PayCompanyForm form) {
		PageInfo<PayCompanyEntity> pageInfo=payCompanyService.queryPayChannelsForPage(form);
		Map<String, Object> param = new HashMap<>();
		param.put("payChannelList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/route/payChannelTable.ftl", param));
	}
	
	/**
	 * 关闭通道
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/disablePayChannel")
	public Vo disablePayChannel(Long id) {
		if(payCompanyService.enableOrDisablePayCompany(id,false)) {
			return new Vo(VoCodeConstant.SUCCESS,"关闭成功");
		}
		return new Vo(VoCodeConstant.BUSSINDESS_ERROR,"开启失败");
		
	}
	
	/**
	 * 开启通道
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/enablePayChannel")
	public Vo enablePayChannel(Long id) {
		if(payCompanyService.enableOrDisablePayCompany(id,true)) {
			return new Vo(VoCodeConstant.SUCCESS,"开启成功");
		}
		return new Vo(VoCodeConstant.BUSSINDESS_ERROR,"开启失败");
	}
	
	
	
	
	

	

}
