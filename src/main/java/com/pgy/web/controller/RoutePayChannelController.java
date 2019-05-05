package com.pgy.web.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.pgy.web.model.vo.Vo;
import com.pgy.web.utils.annotation.RequiredPermission;

@RestController
@RequestMapping("/routeConfig")
@RequiredPermission
public class RoutePayChannelController {
	
	
	
	@RequestMapping("/payChannel")
	public Vo payChannelList() {
			
		return new Vo();
		
	}

}
