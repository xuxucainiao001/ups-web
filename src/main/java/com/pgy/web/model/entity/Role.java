package com.pgy.web.model.entity;

import java.util.List;
import java.util.Objects;

import com.pgy.web.model.Model;

/**
 * 角色实体
 * @author acer
 *
 */
public class Role extends Model{
	
	private Long roleId;
	
	/*角色名称*/
	private String RoleName;
	
	/*角色编码*/
	private String roleCode;
	
	/*菜单列表*/
	private List<Menu> menus;
	
	/*生效失效*/
	private Boolean roleActive;
	
	private String createTime;
	 
	 private String updateTime;
	 
	 private String createUser;
	 
	 private String updateUser;

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

    

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return RoleName;
	}

	public void setRoleName(String roleName) {
		RoleName = roleName;
	}
		
	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public Boolean getRoleActive() {
		return roleActive;
	}

	public void setRoleActive(Boolean roleActive) {
		this.roleActive = roleActive;
	}

	public List<Menu> getMenus() {
		return menus;
	}

	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}
	
	@Override
	public int hashCode() {		
		return roleCode.hashCode();
	}
	
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof Role) {
			return Objects.equals(roleCode, ((Role) obj).getRoleCode());
		}
		return super.equals(obj);
	}

}	
