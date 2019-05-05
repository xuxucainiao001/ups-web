package com.pgy.web.model.entity;

import java.util.Objects;

import com.pgy.web.model.Model;

/**
 * 链接 (菜单，按钮，超链接的父类，用于配置权限白名单)
 * @author 墨凉
 *
 */
public class Link extends Model{
     
	private Long linkId;
	
	/*链接名称*/
	private String linkName;
	
	/*链接编码*/
	private String linkCode;
	
	/*链接请求地址*/
	private String linkUrl;
		
	/*链接类型 参考 ActionLinkType*/
	private String linkType;
	
	private String createTime;
	
	private String updateTime;
	
	private String createUser;
	
	private String updateUser;
		
	public Long getLinkId() {
		return linkId;
	}

	public void setLinkId(Long linkId) {
		this.linkId = linkId;
	}

	public String getLinkName() {
		return linkName;
	}

	public void setLinkName(String linkName) {
		this.linkName = linkName;
	}

	public String getLinkCode() {
		return linkCode;
	}

	public void setLinkCode(String linkCode) {
		this.linkCode = linkCode;
	}

	public String getLinkUrl() {
		return linkUrl;
	}

	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}

	public String getLinkType() {
		return linkType;
	}

	public void setLinkType(String linkType) {
		this.linkType = linkType;
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
		
		return linkCode.hashCode();
	}
	
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof Link) {
			return Objects.equals(linkCode, ((Link) obj).getLinkCode());
		}
		return super.equals(obj);
	}
			
}
