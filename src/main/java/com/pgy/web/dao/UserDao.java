package com.pgy.web.dao;

import com.pgy.web.model.entity.User;


public interface UserDao {
     
	 /*通过用户名密码查询用户*/
	 User queryUserByUserNameAndPassword(User user);
     
	 /*通过用户名信息查询用户权限。菜单*/
	 User queryUser(User user);
		
}
