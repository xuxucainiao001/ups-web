package com.pgy.web.utils;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.util.IOUtils;
import com.pgy.ups.common.annotation.PrintExecuteTime;
import com.pgy.ups.common.utils.SpringUtils;


@Component
public class ExcelUtils {
		
	public static ExcelUtils getIntance() {
		return SpringUtils.getBean(ExcelUtils.class);
	}

	private Logger logger = LoggerFactory.getLogger(ExcelUtils.class);

	@PrintExecuteTime
	public  XSSFWorkbook generateExcel2007(String sheetName, String[] titles, String[] properties, List<?> list,
			XSSFWorkbook workbook) {

		// 默认文件名为unknown
		sheetName = StringUtils.isEmpty(sheetName) ? "unknown" : sheetName;
		// 为空时创建新的excel文件
		if (Objects.isNull(workbook)) {
			workbook = new XSSFWorkbook();
		}
		XSSFSheet sheet = workbook.createSheet(sheetName);
		// 创建表头
		if (ArrayUtils.isNotEmpty(titles)) {
			Row row0 = sheet.createRow(0);
			for (int i = 0; i < titles.length; i++) {
				Cell cell = row0.createCell(i, Cell.CELL_TYPE_STRING);
				cell.setCellValue(titles[i]);
			}
		}

		if (CollectionUtils.isNotEmpty(list) && ArrayUtils.isNotEmpty(properties)) {
			// get方法缓存集合，避免每次通过反射获取方法
			List<Method> getMethodList = new ArrayList<>(properties.length);
			Class<?> clazz = list.get(0).getClass();
			for (String property : properties) {
				// 获取元素类型
				getMethodList.add(acquireGetMethod(property, clazz));
			}
			int size = list.size();
			for (int i = 0; i < size; i++) {
				Row row = sheet.createRow(i + 1);
				for (int j = 0; j < properties.length; j++) {
					Cell cell = row.createCell(j, Cell.CELL_TYPE_STRING);
					cell.setCellValue(getStringResult(getMethodList.get(j), list.get(i)));
				}				
			}
		}
		//最终格式化  拖慢速度
		/*for(int i=0;i<properties.length;i++) {
			sheet.autoSizeColumn(i);
		}*/
		
		return workbook;
	}

	/**
	 * 生成excel文件并输出
	 * 
	 * @param workbook
	 * @param response
	 * @param fileName
	 */
	public  void printOutExcel(XSSFWorkbook workbook, HttpServletResponse response, String fileName) {
		OutputStream outputStream = null;
		try {
			fileName = new String(fileName.getBytes(), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			logger.error("文件名编码异常！{}", e);
			fileName = "unknown";
		}
		try {
			outputStream = response.getOutputStream();
			// response.setContentType("application/octet-stream;charset=ISO8859-1");
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");
			response.addHeader("Pargam", "no-cache");
			response.addHeader("Cache-Control", "no-cache");
			workbook.write(outputStream);
			outputStream.flush();
		} catch (IOException e) {
			logger.error("生成excel文件出错{}", ExceptionUtils.getStackTrace(e));
		} finally {
			IOUtils.close(outputStream);
		}
	}

	/**
	 * 从本类或超类中获取public的get方法
	 * 
	 * @param fieldName
	 * @param t
	 * @return
	 */
	private  Method acquireGetMethod(String fieldName, Class<?> clazz) {

		String firstLetter = fieldName.substring(0, 1).toUpperCase();
		String getter = "get" + firstLetter + fieldName.substring(1);
		for (Class<?> c = clazz; c != Object.class; c = c.getSuperclass()) {
			try {
				Method method = clazz.getMethod(getter);
				return method;
			} catch (Exception e) {
				// 不做任何处理 否则会跳出循环
			}
		}
		throw new RuntimeException("excel导出异常，该对象中不存在" + getter + "方法！");
	}

	/**
	 * 使用method反射方法获取value值
	 * 
	 * @param m
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	private  String getStringResult(Method m, Object obj) {
		try {
			Object result = m.invoke(obj);
			if (Objects.isNull(result)) {
				return StringUtils.EMPTY;
			}
			return result.toString();
		} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			throw new RuntimeException("excel导出异常，对象" + obj + "反射調用方法" + m.getName() + "失败！");
		}

	}

}
