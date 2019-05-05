package com.pgy.web.controller.order;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.common.page.PageInfo;
import com.pgy.ups.pay.interfaces.entity.OrderPushEntity;
import com.pgy.ups.pay.interfaces.entity.UpsOrderEntity;
import com.pgy.ups.pay.interfaces.form.UpsOrderForm;
import com.pgy.ups.pay.interfaces.service.config.dubbo.MerchantConfigService;
import com.pgy.ups.pay.interfaces.service.order.dubbo.UpsOrderPushService;
import com.pgy.ups.pay.interfaces.service.order.dubbo.UpsOrderService;
import com.pgy.ups.pay.interfaces.service.route.dubbo.PayCompanyService;
import com.pgy.web.constant.VoCodeConstant;
import com.pgy.web.model.vo.Vo;
import com.pgy.web.utils.FreemarkerUtils;
import com.pgy.web.utils.annotation.RequiredPermission;

/**
  *  代付代扣订单展示
 * 
 * @author 墨凉
 *
 */
@Controller
@RequiredPermission
@RequestMapping("/order")
public class UpsOrderController {
	
	private Logger logger=LoggerFactory.getLogger(UpsOrderController.class);

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;
	
	@Reference(timeout = 10000)
	private UpsOrderService upsOrderService;
	
	@Reference(timeout = 10000)
	private UpsOrderPushService UpsOrderPushService;
	
	
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
	@RequestMapping("/showOrder")
	public Vo showOrder() {
		Map<String, Object> map = new LinkedHashMap<>();
		map.put("merchantConfigList", merchantConfigService.findAll());
		map.put("payChannelList", payCompanyService.queryAllPayChannels());
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/order/upsOrder.ftl", map));

	}

	/**
	 * 查询列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryUpsOrderList")
	public Vo queryUpsOrderList(UpsOrderForm form) {
		PageInfo<UpsOrderEntity> pageInfo=upsOrderService.queryByForm(form);
		Map<String, Object> param = new HashMap<>();
		param.put("upsOrderList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/order/upsOrderTable.ftl", param)).putResult("total", pageInfo.getTotal());
	}
	
	
	
	/**
	  * 打开查看订单推送状态
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/openOrderPushStatus")
	public Vo openOrderPushStatus(Long id) {
		if(Objects.isNull(id)) {
			return new Vo(VoCodeConstant.PARAMS_ERROR,"id不能为空");
		}
		OrderPushEntity ope=UpsOrderPushService.queryByOrderId(id);
		if(Objects.isNull(ope)) {
			logger.error("该订单未生成推送记录！");
			return new Vo(VoCodeConstant.BUSSINDESS_ERROR,"该订单未生成推送记录!");
		}
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/order/upsOrderPushStatus.ftl", ope));
	}
	
	
	/**
	  *  重查第三方状态
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/requeryOrder")
	public Vo requeryOrder(Long id) {
		if(Objects.isNull(id)) {
			return new Vo(VoCodeConstant.PARAMS_ERROR,"id不能为空");
		}
		OrderPushEntity ope=UpsOrderPushService.queryByOrderId(id);
		if(Objects.isNull(ope)) {
			return new Vo(VoCodeConstant.BUSSINDESS_ERROR,"设置失败，没有查询到订单推送信息！");
		}
		ope.setRequery(true);
		UpsOrderPushService.updateOrderPush(ope);
		return new Vo(VoCodeConstant.SUCCESS,"设置成功！");
	}
	
	/**
	  *  重查第三方状态
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryThirdpartResult")
	public Vo queryThirdpartResult(Long id) {
		if(Objects.isNull(id)) {
			return new Vo(VoCodeConstant.PARAMS_ERROR,"id不能为空!");
		}
		String str=UpsOrderPushService.queryThirdpartResult(id);
		return new Vo(VoCodeConstant.SUCCESS,str);
	}
	
	/**
	  *  订单重推业务方
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/pushOrder")
	public Vo pushOrder(Long id) {
		if(Objects.isNull(id)) {
			return new Vo(VoCodeConstant.PARAMS_ERROR,"id不能为空！");
		}
		OrderPushEntity ope=UpsOrderPushService.queryByOrderId(id);
		if(Objects.isNull(ope)) {
			return new Vo(VoCodeConstant.PARAMS_ERROR,"订单推送信息不存在！");
		}
		UpsOrderPushService.pushOrder(ope);
		return new Vo(VoCodeConstant.SUCCESS,"推送完成");
	}
	
}
