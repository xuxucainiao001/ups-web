package com.pgy.web.controller.cache;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.pgy.ups.pay.interfaces.service.cache.dubbo.UpsCacheService;
import com.pgy.web.constant.VoCodeConstant;
import com.pgy.web.model.vo.Vo;
import com.pgy.web.utils.annotation.RequiredPermission;

/**
  *  缓存数据管理
 * 
 * @author 墨凉
 *
 */
@Controller
@RequiredPermission
@RequestMapping("/cache")
public class UpsCacheController {
    
	@Reference
	private UpsCacheService upsCacheService;
	
	@ResponseBody
	@RequestMapping("/refresh")
	public Vo refreshCache() {
		upsCacheService.refreshCache();
		return new Vo(VoCodeConstant.SUCCESS,"刷新成功！");
	}
	
}
