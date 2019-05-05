package com.pgy.web.controller.order;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import com.pgy.ups.pay.interfaces.entity.UpsAuthSignEntity;
import com.pgy.ups.pay.interfaces.form.UpsUserSignForm;
import com.pgy.ups.pay.interfaces.service.auth.dubbo.UpsUserSignService;
import com.pgy.ups.pay.interfaces.service.config.dubbo.MerchantConfigService;
import com.pgy.ups.pay.interfaces.service.route.dubbo.PayCompanyService;
import com.pgy.web.constant.VoCodeConstant;
import com.pgy.web.model.vo.Vo;
import com.pgy.web.utils.FreemarkerUtils;
import com.pgy.web.utils.annotation.RequiredPermission;

/**
 * 签约订单展示
 * 
 * @author 墨凉
 *
 */
@Controller
@RequiredPermission
@RequestMapping("/order")
public class UpsSignController {

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Reference(timeout = 10000)
	private UpsUserSignService upsUserSignService;

	@Reference(timeout = 10000)
	private MerchantConfigService merchantConfigService;

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
	 * 訂單主页
	 * 
	 * @param
	 * 
	 */
	@ResponseBody
	@RequestMapping("/showSign")
	public Vo showSign() {
		Map<String, Object> map = new LinkedHashMap<>();
		map.put("merchantConfigList", merchantConfigService.findAll());
		map.put("payChannelList", payCompanyService.queryAllPayChannels());
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/order/upsSign.ftl", map));

	}

	/**
	 * 查询列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryUpsSignList")
	public Vo queryUpsOrderList(UpsUserSignForm form) {
		PageInfo<UpsAuthSignEntity> pageInfo = upsUserSignService.queryByForm(form);
		Map<String, Object> param = new HashMap<>();
		param.put("upsSignList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("html", freemarkerUtils.getFreemarkerPageToString("/order/upsSignTable.ftl", param))
				.putResult("total", pageInfo.getTotal());
	}

}
