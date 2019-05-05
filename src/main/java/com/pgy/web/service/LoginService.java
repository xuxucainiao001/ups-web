package com.pgy.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pgy.ups.common.exception.ParamValidException;
import com.pgy.web.model.entity.User;


public interface LoginService {

	boolean verifyLoginTimeOver(User user) throws ParamValidException ;

	User VerifyLogin(User user) throws ParamValidException ;

	void loginOut(HttpServletRequest request, HttpServletResponse response);

	boolean saveLogin(User user, HttpServletResponse response);
	
	public boolean checkLoginStatus(HttpServletRequest request);

}
