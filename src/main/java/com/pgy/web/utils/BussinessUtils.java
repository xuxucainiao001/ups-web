package com.pgy.web.utils;

import java.util.UUID;

/**
 * 业务工具类
 * @author 墨凉
 *
 */
public class BussinessUtils {
	
	
	/**
	 * 计算获取用户编码
	 * @return
	 */
	public static String getUserCode() {
		return "P"+System.currentTimeMillis();
	}
	
	/**
	 * 生成用户唯一token
	 * @param userName
	 * @return
	 */
	public static String getLoginToken() {
		return UUID.randomUUID().toString();
	}
	
}
