package com.pgy.web.controller.proofread;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.account.facade.dubbo.api.BaofuBorrowDataService;
import com.pgy.ups.account.facade.dubbo.api.BaofuReturnDataService;
import com.pgy.ups.account.facade.dubbo.api.ProofreadErrorService;
import com.pgy.ups.account.facade.dubbo.api.ProofreadResultService;
import com.pgy.ups.account.facade.dubbo.api.ProofreadSuccessService;
import com.pgy.ups.account.facade.dubbo.api.ProofreadSumService;
import com.pgy.ups.account.facade.from.ExcelForm;
import com.pgy.ups.account.facade.from.ProofreadResultForm;
import com.pgy.ups.account.facade.model.proofread.ProofreadError;
import com.pgy.ups.account.facade.model.proofread.ProofreadResult;
import com.pgy.ups.account.facade.model.proofread.ProofreadSuccess;
import com.pgy.ups.common.annotation.ParamsLog;
import com.pgy.ups.common.annotation.PrintExecuteTime;
import com.pgy.ups.common.exception.ParamValidException;
import com.pgy.ups.common.page.PageInfo;
import com.pgy.ups.common.utils.ParamUtils;
import com.pgy.web.constant.VoCodeConstant;
import com.pgy.web.model.vo.Vo;
import com.pgy.web.utils.ExcelUtils;
import com.pgy.web.utils.FreemarkerUtils;
import com.pgy.web.utils.annotation.RequiredPermission;

/**
 * 对账结果
 * 
 * @author 墨凉
 *
 */
@Controller
@ParamsLog
@RequestMapping("/proofreadResult")
@RequiredPermission
public class ProofreadResultController {

	// 宝付渠道
	private static final String BAO_FU = "01";

	// 借款
	private static final String BORROW = "01";

	// 还款
	private static final String RETURN = "02";

	@Resource
	private HttpServletRequest request;

	@Resource
	private HttpServletResponse response;

	@Resource
	private FreemarkerUtils freemarkerUtils;

	@Reference(timeout = 10000)
	private ProofreadSumService proofreadSumService;

	@Reference(timeout = 10000)
	private ProofreadResultService proofreadResultService;

	@Reference(timeout = 10000)
	private ProofreadSuccessService proofreadSuccessService;

	@Reference(timeout = 10000)
	private BaofuBorrowDataService baofuBorrowDateService;

	@Reference(timeout = 10000)
	private BaofuReturnDataService baofuReturnDateService;
	
	@Reference(timeout = 10000)
	private ProofreadErrorService proofreadErrorService;

	/**
	 * 
	 * 对账结果主页
	 * 
	 * @param
	 * 
	 */
	@ResponseBody
	@RequestMapping
	public Vo index(ModelMap modelMap) {
		return new Vo(VoCodeConstant.SUCCESS).putResult("html",
				freemarkerUtils.getFreemarkerPageToString("/proofread/proofreadResult.ftl", null));
	}

	/**
	 * 查询对账结果列表
	 * 
	 * @param form
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryProofreadResultList")
	public Vo queryProofreadSumList(ProofreadResultForm form) {
		PageInfo<ProofreadResult> pageInfo = proofreadResultService.getPage(form);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("proofreadResultList", pageInfo.getList());
		return new Vo(VoCodeConstant.SUCCESS)
				.putResult("html",
						freemarkerUtils.getFreemarkerPageToString("/proofread/proofreadResultTable.ftl", param))
				.putResult("total", pageInfo.getTotal());
	}

	/**
	 * 对账成功明细下载
	 * 
	 * @param form
	 * @return
	 * @throws ParamValidException
	 */
	@PrintExecuteTime
	@RequestMapping("/successDownload/{channel}/{fromSystem}/{proofreadType}/{proofreadDate}/{fileName}")
	public void successDownLoad(@PathVariable("channel") String channel, @PathVariable("fromSystem") String fromSystem,
			@PathVariable("proofreadType") String proofreadType, @PathVariable("proofreadDate") String proofreadDate,
			@PathVariable("fileName") String fileName) throws ParamValidException {

		// 验证参数不能为空
		ParamUtils.assertNotNull(channel, fromSystem, proofreadType, proofreadDate, fileName);
		// 封装参数
		ExcelForm excelForm = new ExcelForm();
		excelForm.setChannel(channel);
		excelForm.setFromSystem(fromSystem);
		excelForm.setProofreadType(proofreadType);
		excelForm.setProofreadDate(proofreadDate);

		List<ProofreadSuccess> successList = proofreadSuccessService.getExcelList(excelForm);
		// 创建成功对账列表文件
		String[] successTitles = { "对账日期", "商户号", "业务端", "商户订单号", "渠道订单创建时间", "渠道交易金额", "业务申请时间", "业务交易金额", "借款编号",
				"对账状态", "备注", "对账员" };
		String[] successProperties = { "proofreadDate", "businessNum", "fromSystem", "businessOrderNum",
				"channelOrderCreateTime", "channelExchangeMoney", "businessOrderCreateTime", "businessExchangeMoney",
				"borrowNum", "proofreadStatus", "remark", "updateUser" };
		XSSFWorkbook workbook = ExcelUtils.getIntance().generateExcel2007("对账成功", successTitles, successProperties, successList,
				null);
		// 创建失败对账列表文件
		List<ProofreadError> errorList = proofreadErrorService.getExcelList(excelForm);
		String[] errorTitles = { "对账日期", "业务名称","业务类型", "商户订单号", "借款编号", "业务交易金额", "业务状态", "业务申请时间", "渠道交易金额", "渠道订单状态",
				"渠道交易时间", "异常类型", "流水状态", "处理时间", "操作员" };
		String[] errorProperties = { "proofreadDate", "fromSystem", "proofreadType","businessOrderNum", "borrowNum", "businessExchangeMoney",
				"businessOrderStatuts", "businessOrderCreateTime", "channelExchangeMoney", "channelOrderStatus",
				"channelOrderCreateTime", "errorType", "flowStatus", "disposeTime", "updateUser" };
		workbook = ExcelUtils.getIntance().generateExcel2007("对账异常", errorTitles, errorProperties, errorList, workbook);
		// 输出excel文件
		ExcelUtils.getIntance().printOutExcel(workbook, response, fileName);
	}

	/**
	 * 渠道数据下载
	 * 
	 * @param channel
	 * @param fromSystem
	 * @param proofreadType
	 * @param proofreadDate
	 * @param fileName
	 * @throws ParamValidException
	 */
	@PrintExecuteTime
	@RequestMapping("/channelDownload/{channel}/{fromSystem}/{proofreadType}/{proofreadDate}/{fileName}")
	public void channelDownload(@PathVariable("channel") String channel, @PathVariable("fromSystem") String fromSystem,
			@PathVariable("proofreadType") String proofreadType, @PathVariable("proofreadDate") String proofreadDate,
			@PathVariable("fileName") String fileName) throws ParamValidException {

		// 验证参数不能为空
		ParamUtils.assertNotNull(channel, fromSystem, proofreadType, proofreadDate, fileName);
		// 封装参数
		ExcelForm excelForm = new ExcelForm();
		excelForm.setChannel(channel);
		excelForm.setFromSystem(fromSystem);
		excelForm.setProofreadType(proofreadType);
		excelForm.setProofreadDate(proofreadDate);
        //查询数据
		List<?> list = null;
		String[] titles = null;
		String[] properties = null;
		if (Objects.equals(channel, BAO_FU) && (Objects.equals(proofreadType, BORROW))) {
			list = baofuBorrowDateService.getExcelList(excelForm);
			titles = new String[] { "系统编码", "从宝付下载时间", "对账日期", "商户号", "终端号", "交易类型", "交易子类型", "宝付订单号", "商户代付订单号", "批次号",
					"清算日期", "订单状态", "交易金额", "手续费", "收款人账号", "收款人姓名", "宝付交易号", "代付订单创建时间", "退款订单创建时间" };
			properties = new String[] { "fromSystem", "downLoadTime", "proofreadDate", "businessNum", "terminalNum",
					"exchangeType", "subExchangeType", "baofuOrderNum", "businessOrderNum", "batchNum", "caculateTime",
					"orderStatus", "exchangeAmount", "exchangeTip", "recievePersonNum", "recievePersonName",
					"baofuExchangeNum", "orderCreateTime", "refundOrderCreateTime" };
		} else if (Objects.equals(channel, BAO_FU) && (Objects.equals(proofreadType, RETURN))) {
			list = baofuReturnDateService.getExcelList(excelForm);
			titles = new String[] { "系统编码", "从宝付下载时间", "对账时间", "商户号", "终端号", "交易类型", "交易子类型", "宝付订单号", "商户订单号", "清算日期",
					"订单状态", "交易金额", "手续费", "宝付交易号", "支付订单创建时间", "商户退款订单号", "退款订单创建时间" };
			properties = new String[] { "fromSystem", "downLoadTime", "proofreadDate", "businessNum", "terminalNum",
					"exchangeType", "subExchangeType", "baofuOrderNum", "businessOrderNum", "caculateTime",
					"orderStatus", "exchangeAmount", "exchangeTip", "baofuExchangeNum", "orderCreateTime",
					"businessRefundOrderNum", "refundOrderCreateTime" };
		}
		XSSFWorkbook workbook = ExcelUtils.getIntance().generateExcel2007(fileName, titles, properties, list, null);
		ExcelUtils.getIntance().printOutExcel(workbook, response, fileName);
	}

}
