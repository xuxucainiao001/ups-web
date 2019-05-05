package com.pgy.web.model.entity;

import java.util.List;
import java.util.Objects;

import com.pgy.web.model.Model;

/**
 * 用户实体类
 * @author 墨凉
 *
 */
public class User extends Model{

	
	 private Long userId;
	 
	 private String userName;
	 
	 /*唯一编码*/
	 private String userCode;
	 
	 private String userPassword;
	 
	 private String createTime;
	 
	 private String updateTime;
	 
	 private String createUser;
	 
	 private String updateUser;
	 
	 private String description;
	 
	 /*角色列表*/
	 private List<Role> roles;
	 
	 /*链接黑名单*/
	 private List<Link> blackNames;

	

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	
	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public List<Link> getBlackNames() {
		return blackNames;
	}

	public void setBlackNames(List<Link> blackNames) {
		this.blackNames = blackNames;
	}

	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}	
	
	@Override
	public int hashCode() {		
		return userCode.hashCode();
	}
	
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof User) {
			return Objects.equals(((User) obj).getUserCode(), this.userCode);
		}
		return super.equals(obj);
	}
	
}
