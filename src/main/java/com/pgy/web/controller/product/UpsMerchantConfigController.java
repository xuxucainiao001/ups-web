package com.pgy.web.controller.product;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.common.annotation.ParamsLog;
import com.pgy.ups.common.page.PageInfo;
import com.pgy.ups.common.utils.CookieUtils;
import com.pgy.ups.pay.interfaces.entity.MerchantConfigEntity;
import com.pgy.ups.pay.interfaces.entity.UpsOrderTypeEntity;
import com.pgy.ups.pay.interfaces.form.MerchantConfigForm;
import com.pgy.ups.pay.interfaces.form.MerchantOrderTypeForm;
import com.pgy.ups.pay.interfaces.service.config.dubbo.MerchantConfigService;
import com.pgy.ups.pay.interfaces.service.config.dubbo.MerchantOrderTypeService;
import com.pgy.ups.pay.interfaces.service.order.dubbo.UpsOrderTypeService;
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
public class UpsMerchantConfigController {

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Reference(timeout = 10000)
	private MerchantConfigService merchantConfigService;

	@Reference(timeout = 10000)
	private UpsOrderTypeService upsOrderTypeService;

	@Reference(timeout = 10000)
	private MerchantOrderTypeService merchantOrderTypeService;

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
	 * 银行配置主页
	 * 
	 * @param
	 * 
	 */
	@ResponseBody
	@RequestMapping("/showMerchant")
	public Vo showMerchant() {
		List<UpsOrderTypeEntity> orderTypeList = upsOrderTypeService.getAllOrderType();
		Map<String, Object> param = new HashMap<>();
		param.put("orderTypeList", orderTypeList);
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/product/merchantConfig.ftl", param));

	}

	/**
	 * 查询列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryMerchantConfigList")
	public Vo queryMerchantConfigList(MerchantConfigForm form) {
		PageInfo<MerchantConfigEntity> pageInfo = merchantConfigService.queryByForm(form);
		Map<String, Object> param = new HashMap<>();
		param.put("merchantConfigList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("html", freemarkerUtils.getFreemarkerPageToString("/product/merchantConfigTable.ftl", param))
				.putResult("total", pageInfo.getTotal());
	}

	/**
	 * 更新商户配置
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateMerchantConfig")
	public Vo updateMerchantConfig(MerchantConfigForm form) {
		if (form.getId() == null) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "id不能为空！");
		}
		if (StringUtils.isAnyBlank(form.getMerchantCode(), form.getMerchantName(), form.getDescription(),
				form.getUpsPrivateKey(), form.getMerchantPublicKey())) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "表单中的内容不能为空！");
		}
		String userName = CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME);
		form.setUpdateUser(userName);
		boolean success = merchantConfigService.updateMerchantConfig(form);
		if (success) {
			return new Vo(VoCodeConstant.SUCCESS, "修改成功");
		}
		return new Vo(VoCodeConstant.PARAMS_ERROR, "修改失败，请检查商户编码或商户名称是否重复!");
	}

	/**
	 * 新增商户配置
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/addMerchantConfig")
	public Vo addMerchantConfig(MerchantConfigForm form) {
		if (StringUtils.isAnyBlank(form.getMerchantCode(), form.getMerchantName(), form.getDescription(),
				form.getUpsPrivateKey(), form.getMerchantPublicKey())) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "表单中的内容不能为空！");
		}
		String userName = CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME);
		form.setUpdateUser(userName);
		form.setCreateUser(userName);
		MerchantConfigEntity mce = merchantConfigService.createMerchantConfig(form);
		if (Objects.nonNull(mce)) {
			return new Vo(VoCodeConstant.SUCCESS, "创建成功");
		}
		return new Vo(VoCodeConstant.PARAMS_ERROR, "创建失败，请检查商户编码或商户名称是否重复！");
	}

	/**
	 * 新增支付产品配置
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/addMerchantOrderType")
	public Vo addMerchantOrderType(MerchantOrderTypeForm form) {
		if (form.getMerchantId() == null) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "商户Id不能为空！");
		}
		if (form.getOrderTypeId() == null) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "支付产品不能为空！");
		}
		if (form.getStartTime() == null) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "生效时间不能为空！");
		}
		if (form.getEndTime() == null) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "失效时间不能为空！");
		}
		if (form.getEndTime().before(form.getStartTime())) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "失效时间不能小于生效时间！");
		}
		form.setUpdateUser(CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME));
		boolean flag = merchantOrderTypeService.createMerchantOrderType(form);
		if (flag) {
			return new Vo(VoCodeConstant.SUCCESS, "创建成功");
		}
		return new Vo(VoCodeConstant.PARAMS_ERROR, "创建失败，不能添加已有的支付产品");
	}

	/**
	 * 新增支付产品配置
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/deleteMerchantOrderType")
	public Vo deleteMerchantOrderType(Long id) {
		if (id == null) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "id不能为空！");
		}
		merchantOrderTypeService.deleteMerchantOrderType(id);
		return new Vo(VoCodeConstant.SUCCESS, "删除成功");
	}
	
	/**
	  * 更新支付产品生效和失效日期
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/updateActiveTime")
	public Vo updateActiveTime(MerchantOrderTypeForm form) {
		if (form.getId() == null) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "id不能为空！");
		}
		boolean flag=merchantOrderTypeService.updateMerchantOrderType(form);
		if(flag) {
			return new Vo(VoCodeConstant.SUCCESS, "修改成功");
		}
		return new Vo(VoCodeConstant.BUSSINDESS_ERROR, "修改失败");
		
	}
	

	/**
	 * 打开商户配置
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@ParamsLog
	@RequestMapping("/openMerchantConfig")
	public Vo openMerchantConfig(Long id) {
		MerchantConfigEntity mce = merchantConfigService.queryMerchantConfig(id);
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/product/merchantConfigForm.ftl", mce));
	}

	// 商户配置启用
	@ResponseBody
	@RequestMapping("/enableConfig")
	public Vo enableConfig(Long id) {
		merchantConfigService.enableMerchantConfig(id);
		return new Vo(VoCodeConstant.SUCCESS, "启用成功！");
	}

	// 商户配置禁用
	@ResponseBody
	@RequestMapping("/disableConfig")
	public Vo disableConfig(Long id) {
		merchantConfigService.disableMerchantConfig(id);
		return new Vo(VoCodeConstant.SUCCESS, "禁用成功！");
	}

	// 删除商户配置
	@ResponseBody
	@RequestMapping("/removeMerchantConfig")
	public Vo removeMerchantConfig(Long id) {
		merchantConfigService.deleteMerchantConfig(id);
		return new Vo(VoCodeConstant.SUCCESS, "删除成功！");
	}

}
