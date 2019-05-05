package com.pgy.web.model.vo;

import java.util.LinkedHashMap;
import java.util.Map;

import com.pgy.web.model.Model;

/**
 * 墨凉
 * 返回前台结果封装
 * @author acer
 *
 */
public  class Vo extends Model{
		
	private String resultCode=null;
	
	private String message=null;
	
	private Map<String,Object> result=new LinkedHashMap<>(8);
	
	/**
	 * 
	 * @param 参考VoCode
	 */
	public Vo() {}
	
	public Vo(String resultCode) {
		this.resultCode=resultCode;
	}
	
	public Vo(String resultCode,String message) {
		this.resultCode=resultCode;
		this.message=message;
	}
	
	public String getResultCode() {
		return resultCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	public Vo putResult(String key,Object value) {
		result.put(key, value);
		return this;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	
	
  
}
