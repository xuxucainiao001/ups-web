package com.pgy.web.controller.product;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import com.pgy.ups.pay.interfaces.entity.CollectChooseEntity;
import com.pgy.ups.pay.interfaces.form.CollectChooseForm;
import com.pgy.ups.pay.interfaces.service.config.dubbo.CollectChooseService;
import com.pgy.ups.pay.interfaces.service.config.dubbo.MerchantConfigService;
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
@RequestMapping("/collect")
public class UpsCollectChooseController {

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Resource
	private HttpServletRequest request;

	@Reference
	private CollectChooseService collectChooseService;

	@Reference(timeout = 10000)
	private MerchantConfigService merchantConfigService;

	@InitBinder
	public void InitBinder(WebDataBinder binder) {
		// string 先trim再注入
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
	@RequestMapping("/showCollectChoose")
	public Vo showCollectChoose() {
		Map<String, Object> map = new LinkedHashMap<>();
		map.put("merchantConfigList", merchantConfigService.findAll());
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/product/collectChoose.ftl", map));

	}

	/**
	 * 查询列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryCollectChooseList")
	public Vo queryCollectChooseList(CollectChooseForm form) {
		PageInfo<CollectChooseEntity> pageInfo = collectChooseService.queryByForm(form);
		Map<String, Object> param = new HashMap<>();
		param.put("collectChooseList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("html", freemarkerUtils.getFreemarkerPageToString("/product/collectChooseTable.ftl", param))
				.putResult("total", pageInfo.getTotal());
	}

	/**
	 * 新增配置
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/addCollectChoose")
	public Vo addCollectChoose(CollectChooseForm form) {
		if (StringUtils.isBlank(form.getMerchantCode()) || StringUtils.isBlank(form.getCollectType())) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "非法参数！");
		}
		String userName = CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME);
		form.setCreateUser(userName);
		CollectChooseEntity cce = collectChooseService.createCollectChoose(form);
		if (Objects.nonNull(cce)) {
			return new Vo(VoCodeConstant.SUCCESS, "添加成功！");
		}
		return new Vo(VoCodeConstant.BUSSINDESS_ERROR, "添加失败！");
	}

	/**
	 * 刪除配置
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delteCollectChoose")
	public Vo delteCollectChoose(Long id) {
		collectChooseService.deleteCollectChooseById(id);
		return new Vo(VoCodeConstant.SUCCESS, "刪除成功！");
	}

	/**
	 * 修改配置
	 */
	@ResponseBody
	@RequestMapping("/modifyCollectChoose")
	public Vo modifyCollectChoose(CollectChooseForm form) {
		if (null == form.getId() || StringUtils.isBlank(form.getCollectType())) {
			return new Vo(VoCodeConstant.PARAMS_ERROR, "非法参数！");
		}
		String userName = CookieUtils.getCookieValue(request, LoginServiceImpl.USER_NAME);
		form.setUpdateUser(userName);
		if (collectChooseService.updateCollectChoose(form)) {
			return new Vo(VoCodeConstant.SUCCESS, "修改成功！");
		}
		return new Vo(VoCodeConstant.BUSSINDESS_ERROR, "修改失敗！");

	}
}
