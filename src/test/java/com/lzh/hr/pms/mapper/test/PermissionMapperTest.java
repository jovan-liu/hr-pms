package com.lzh.hr.pms.mapper.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lzh.hr.pms.entity.Permission;
//import com.lzh.hr.pms.mapper.PermissionMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-context.xml", "classpath:spring-context-druid.xml", "classpath:spring-context-mybatis.xml"})
public class PermissionMapperTest {

//	@Autowired
//	private PermissionMapper permissionMapper;
//	
//	@Test
//	public void testGetList() {
//		List<Permission> list = permissionMapper.getList();
//		for (Permission permission : list) {
//			System.out.println(permission.toString());
//		}
//	}
}
