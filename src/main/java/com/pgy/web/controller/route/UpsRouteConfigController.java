package com.pgy.web.controller.route;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.common.page.PageInfo;
import com.pgy.ups.common.utils.CookieUtils;
import com.pgy.ups.pay.interfaces.entity.MerchantOrderTypeEntity;
import com.pgy.ups.pay.interfaces.form.MerchantOrderTypeForm;
import com.pgy.ups.pay.interfaces.service.config.dubbo.MerchantConfigService;
import com.pgy.ups.pay.interfaces.service.config.dubbo.MerchantOrderTypeService;
import com.pgy.ups.pay.interfaces.service.order.dubbo.UpsOrderTypeService;
import com.pgy.ups.pay.interfaces.service.route.dubbo.PayCompanyService;
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
@RequestMapping("/routeConfig")
public class UpsRouteConfigController {

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Reference(timeout = 10000)
	private MerchantOrderTypeService merchantOrderTypeService;

	@Reference(timeout = 10000)
	private MerchantConfigService merchantConfigService;

	@Reference(timeout = 10000)
	private UpsOrderTypeService upsOrderTypeService;

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
	@RequestMapping("/showMerchant")
	public Vo showMerchant(MerchantOrderTypeForm form) {
		Map<String, Object> map = new LinkedHashMap<>();
		map.put("merchantConfigList", merchantConfigService.findAll());
		map.put("orderTypeList", upsOrderTypeService.getAllOrderType());
		map.put("payChannelList", payCompanyService.queryAllPayChannels());
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/route/merchantRouteConfig.ftl", map));

	}

	/**
	 * 查询列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryMerchantRouteConfigList")
	public Vo queryMerchantRouteConfigList(MerchantOrderTypeForm form) {
		PageInfo<MerchantOrderTypeEntity> pageInfo = merchantOrderTypeService.queryMerchantOrderTypeForPage(form);
		Map<String, Object> param = new HashMap<>();
		param.put("merchantRouteConfigList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/route/merchantRouteConfigTable.ftl", param));
	}

	/**
	 * 开启默认
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/openDefault")
	public Vo openDefault(Long id) {
		merchantOrderTypeService.openDefaultOrRoute(id, MerchantOrderTypeService.OPEN_DEFAULT,
				CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME));
		return new Vo(VoCodeConstant.SUCCESS, "开启默认成功！");
	}

	/**
	 * 开启路由
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/openRoute")
	public Vo openRoute(Long id) {
		merchantOrderTypeService.openDefaultOrRoute(id, MerchantOrderTypeService.OPEN_ROUTE,
				CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME));
		return new Vo(VoCodeConstant.SUCCESS, "开启路由成功！");
	}
	
	/**
	  * 修改默认渠道
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/upadteMerchantRouteConfig")
	public Vo upadteMerchantRouteConfig(MerchantOrderTypeForm form) {
		if(form.getId()==null) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "id不能为空！");
		}
		if(StringUtils.isBlank(form.getDefaultPayChannel())) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "默认渠道不能为空！");
		}
		form.setUpdateUser(CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME));
		if(merchantOrderTypeService.updateMerchantRouteConfig(form)) {
			return new Vo(VoCodeConstant.SUCCESS, "配置成功！");
		}
		return new Vo(VoCodeConstant.BUSSINDESS_ERROR, "配置失败！");
		
	}

}
