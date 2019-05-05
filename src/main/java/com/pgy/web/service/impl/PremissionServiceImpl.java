package com.pgy.web.service.impl;

import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.pgy.ups.common.exception.BussinessException;
import com.pgy.web.dao.MenuDao;
import com.pgy.web.dao.RoleDao;
import com.pgy.web.dao.UserDao;
import com.pgy.web.model.entity.Link;
import com.pgy.web.model.entity.Menu;
import com.pgy.web.model.entity.Role;
import com.pgy.web.model.entity.User;
import com.pgy.web.service.PremissionService;

/**
 * 权限API
 * 
 * @author 墨凉
 *
 */
@Component
public class PremissionServiceImpl implements PremissionService{

	@Resource
	private UserDao useDao;

	@Resource
	private RoleDao roleDao;

	@Resource
	private MenuDao menuDao;

	private Logger logger = LoggerFactory.getLogger(PremissionServiceImpl.class);

	/**
	 * 查询用户权限下的一级菜单
	 * 
	 * @param user menuLevel
	 * @return
	 */
	public Set<Menu> queryUserMenus(User user, int menuLevel) {
		List<Role> roles = queryUserRoles(user);
		if (CollectionUtils.isEmpty(roles)) {
			return Collections.emptySet();
		}
		// 构建有set序集，按照菜单order大小比较
		for (Role r : roles) {
			Role role = roleDao.queryRole(r);
			List<Menu> ms = role.getMenus();
			if (!CollectionUtils.isEmpty(ms)) {
				return ms.stream().filter(e -> {
					// 仅保留menuLevel级菜单
					return Objects.equals(e.getMenuLevel(), menuLevel);
				}).collect(Collectors.toSet());
			}
		}
		return Collections.emptySet();
	}

	/**
	 * 查询用户所有权限
	 * 
	 * @param user
	 * @return
	 */
	@Override
	public List<Role> queryUserRoles(User user) {
		User u = useDao.queryUser(user);
		if (Objects.isNull(u)) {
			throw new RuntimeException("用户信息查询为空！");
		}
		List<Role> roles = u.getRoles();
		if (CollectionUtils.isEmpty(roles)) {
			logger.warn("该用户尚无权限！用户信息：{ }", u);
			return Collections.emptyList();
		}
		return roles;
	}

	/**
	 * 查询一级菜单下所有可用的子菜单(二级菜单即为选项卡)
	 * 
	 * @param m
	 * @return
	 */
	@Override
	public List<Menu> queryAvalibleSubMenus(Menu m) {
		Menu menu = menuDao.queryMenu(m);
		if (Objects.isNull(menu)) {
			throw new BussinessException("没有查询到该菜单信息！");
		}
		if (!menu.getMenuActive()) {
			throw new BussinessException("该菜尚未激活！");
		}
		List<Menu> subMenus = menu.getSubMenus();
		if (CollectionUtils.isEmpty(subMenus)) {
			logger.warn("该菜单没有子菜单！{ }", subMenus);
			return Collections.emptyList();
		}
		// 仅返回有效菜单并排序
		return subMenus.stream().filter(e -> {
			return e.getMenuActive();
		}).sorted((t1, t2) -> {
			return (int) (t1.getMenuOrder() - t2.getMenuOrder());
		}).collect(Collectors.toList());
	}

	/**
	 * 获取用户地址黑名单
	 * 
	 * @param user
	 * @return
	 */
	@Override
	public List<String> getUserBlackNames(User user) {
		User u = useDao.queryUser(user);
		if (Objects.isNull(u)) {
			throw new BussinessException("未查询到用户信息！userName=" + user);
		}
		List<Link> list = u.getBlackNames();
		if (CollectionUtils.isEmpty(list)) {
			return Collections.emptyList();
		}
		return list.stream().map(link -> {
			return link.getLinkUrl();
		}).collect(Collectors.toList());

	}

}
