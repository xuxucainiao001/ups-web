package com.pgy.web.model.entity;

import java.util.List;
/**
 * 菜单实体
 * @author 墨凉
 *
 */
public class Menu extends Link{
	
	/*菜单名称*/
	private String menuName;
		
	/*菜单级别 0：根菜单 1：一级菜单  2：二级菜单*/
	private Integer menuLevel;
	
	/*菜单顺序*/
	private Long menuOrder;
	
	/*是否生效*/
	private Boolean menuActive;
	
	/*父级菜单*/
	private Menu parentMenu;
	
	/*所属权限列表*/
	private List<Role> roles;
	
	/*子菜单列表*/
	private List<Menu> subMenus;

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public Menu getParentMenu() {
		return parentMenu;
	}

	public void setParentMenu(Menu parentMenu) {
		this.parentMenu = parentMenu;
	}

	
	public Boolean getMenuActive() {
		return menuActive;
	}

	public void setMenuActive(Boolean menuActive) {
		this.menuActive = menuActive;
	}

	public Integer getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(Integer menuLevel) {
		this.menuLevel = menuLevel;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public Long getMenuOrder() {
		return menuOrder;
	}

	public void setMenuOrder(Long menuOrder) {
		this.menuOrder = menuOrder;
	}

	public List<Menu> getSubMenus() {
		return subMenus;
	}

	public void setSubMenus(List<Menu> subMenus) {
		this.subMenus = subMenus;
	}			
}
