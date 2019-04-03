package com.lzh.hr.pms.mapper.test;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.lzh.hr.pms.controller.TestController;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration("src/main/resources")
@ContextConfiguration({"classpath:spring-context.xml", "classpath:spring-context-druid.xml", "classpath:spring-context-mybatis.xml", "classpath:spring-mvc.xml"})
public class TestControllerTest {
	
	private MockHttpServletRequest request;
	private MockHttpServletResponse response;

	@Autowired
	private TestController testController;
	
	@Before
	public void setUp(){
		request = new MockHttpServletRequest();
		request.setCharacterEncoding("UTF-8");
		response = new MockHttpServletResponse();
	}
	
	@Test
	public void testSelectById() {
		System.out.println(testController.hello());
	}
	
}
