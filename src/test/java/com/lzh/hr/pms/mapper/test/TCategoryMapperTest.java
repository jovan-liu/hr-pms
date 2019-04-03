package com.lzh.hr.pms.mapper.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//import com.lzh.hr.pms.entity.TCategory;
//import com.lzh.hr.pms.mapper.TCategoryMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring-context.xml", "classpath:spring-context-druid.xml", "classpath:spring-context-mybatis.xml"})
public class TCategoryMapperTest {

//	@Autowired
//	private TCategoryMapper categoryMapper;
//	
//	@Test
//	public void testSelectById() {
//		TCategory category = categoryMapper.selectById(1L);
//		System.out.println(category.toString());
//	}
}
