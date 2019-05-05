package com.pgy.web.service.impl;

import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.pgy.ups.common.exception.ParamValidException;
import com.pgy.ups.common.utils.CookieUtils;
import com.pgy.ups.common.utils.RedisUtils;
import com.pgy.web.dao.UserDao;
import com.pgy.web.model.entity.User;
import com.pgy.web.service.LoginService;
import com.pgy.web.utils.BussinessUtils;



@Component
@ConfigurationProperties
public class LoginServiceImpl implements LoginService{
	
	@Value("${login.loginTimeOut}")
	private Integer loginTimeOut;
	
	@Value("${login.loginCount}")
	private Integer loginCount;
	
	public static final String LONGIN_COUNT="_login_count";
	public static final String LONGIN_TOKEN="_login_token";
	
	public static final String USER_NAME="userName";
	public static final String USER_CODE="userCode";
	public static final String USER_ID="userId";
     
	@Resource
	private UserDao userDao;

	
	/**
	 * 验证用户密码是否可以登录
	 * @param user
	 * @return
	 * @throws ParamValidException
	 */
	public User VerifyLogin(User user) throws ParamValidException {
		if(StringUtils.isEmpty(user.getUserName())||StringUtils.isEmpty(user.getUserName())) {
			throw new ParamValidException("账户或账户密码不能为空！");
		}
		return userDao.queryUserByUserNameAndPassword(user);
	}

    /**
     * 验证1分钟用户登录次数是否超过限制
     * @param user
     * @return
     */
	public boolean verifyLoginTimeOver(User user) {
		RedisUtils redisUtils=RedisUtils.getInstance();
		String count=redisUtils.get(user.getUserName()+LONGIN_COUNT);
		if(!StringUtils.isNumeric(count)) {
			return !redisUtils.setex(user.getUserName()+LONGIN_COUNT, "1",60);
		}
		int countInt=Integer.parseInt(count);
		if(countInt<loginCount) {
			return !redisUtils.setex(user.getUserName()+LONGIN_COUNT, ""+(++countInt),60);
		}
		return true;
	}
    
	/**
	 * 保存用Token信任登录
	 * @param user
	 * @param request
	 * @return
	 */
	public boolean saveLogin(User user, HttpServletResponse response) {
		String token=BussinessUtils.getLoginToken();	
		//存入redis成功后，和用户信息一起保存至cookie中
		RedisUtils redisUtils=RedisUtils.getInstance();
		if(redisUtils.setex(user.getUserName()+LONGIN_TOKEN, token, 1800)){
			CookieUtils.setCookie(response, user.getUserName()+LONGIN_TOKEN, token, loginTimeOut);
			CookieUtils.setCookie(response, USER_NAME, user.getUserName(), loginTimeOut);
			CookieUtils.setCookie(response, USER_CODE, user.getUserCode(), loginTimeOut);
			CookieUtils.setCookie(response, USER_ID, user.getUserId()+"", loginTimeOut);
			return true;
		}
		return false;
	}
	
	/**
	  *   通过cookie验证用户是否还处于登录状态
	 * @param request
	 * @return
	 */
	public boolean checkLoginStatus(HttpServletRequest request) {
		String userName=CookieUtils.getCookieValue(request, USER_NAME);
		if(StringUtils.isEmpty(userName)) {
			return false;
		}
		//查询redis中是否有token
		RedisUtils redisUtils=RedisUtils.getInstance();
		String loginToken=redisUtils.get(userName+LONGIN_TOKEN);
		if(StringUtils.isEmpty(loginToken)) {
			return false;
		}
		//查询loginToken可cookie中的token是否一致；
		String cookieToken=CookieUtils.getCookieValue(request, userName+LONGIN_TOKEN);
		return Objects.equals(loginToken, cookieToken);
	}

	public void loginOut(HttpServletRequest request,HttpServletResponse response) {
		RedisUtils redisUtils=RedisUtils.getInstance();
		String userName=CookieUtils.getCookieValue(request, USER_NAME);
		if(StringUtils.isEmpty(userName)) {
			return;
		}
		CookieUtils.removeCookie(request, response, USER_NAME);
		CookieUtils.removeCookie(request, response, USER_CODE);
		CookieUtils.removeCookie(request, response, USER_ID);
		CookieUtils.removeCookie(request, response, userName+LONGIN_TOKEN);
		redisUtils.delete(userName+LONGIN_TOKEN);		
	}
	
}
