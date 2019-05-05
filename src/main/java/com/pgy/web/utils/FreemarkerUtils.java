package com.pgy.web.utils;

import java.io.IOException;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import com.pgy.ups.common.utils.SpringUtils;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;

@Component
public class FreemarkerUtils {

	private Logger logger = LoggerFactory.getLogger(FreemarkerUtils.class);

	@Resource
	private Configuration configuration;

	public String getFreemarkerPageToString(String templatePath, Object dataMode) {
		try {
			return FreeMarkerTemplateUtils.processTemplateIntoString(configuration.getTemplate(templatePath), dataMode);
		} catch (IOException | TemplateException e) {
			logger.error("freemrker模板渲染异常{}", e);
			return null;
		}
	}
	
	public static FreemarkerUtils getInstance() {
		return SpringUtils.getBean(FreemarkerUtils.class);
	}

}
