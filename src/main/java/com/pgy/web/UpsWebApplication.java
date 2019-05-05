package com.pgy.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * UPS账务WEB系统启动
 * 
 * @author 墨凉
 *
 */

@SpringBootApplication(scanBasePackages = { "com.pgy.ups.common.**", "com.pgy.web.**" })
public class UpsWebApplication {

	private static final Logger logger = LoggerFactory.getLogger(UpsWebApplication.class);

	public static void main(String[] args) {	
		
		logger.info("begin to start-up [ups-web]");
		SpringApplication.run(UpsWebApplication.class, args);
		logger.info("start-up [ups-web] success !!!");
	}

}
