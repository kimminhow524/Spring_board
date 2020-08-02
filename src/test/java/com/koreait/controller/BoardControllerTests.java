package com.koreait.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration	//Servlet의 ServletContext를 이용하기 위함
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext wac;
	
	//가짜 MVC
	//마치 브라우저에서 사용하는 것처럼 만들어서 Controller를 실행해 볼 수 있다.
	private MockMvc mockMvc;
	
	@Before
	//@Beafore가 적용된 메소드는 모든 테스트 전에 매번 실행된다.
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
//	@Test
//	public void testList() throws Exception{
//		log.info(mockMvc.perform(MockMvcRequestBuilders.get("board/list"))
//		.andReturn()				//반환된 결과를 이용해서
//		.getModelAndView()	//Model에 어떤 데이터가 담겨 있는지
//		.getModelMap());			//Map형식으로 확인
//	}
	
	@Test
	public void testList() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "2")
				.param("amount", "20"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}

//	@Test
//	public void testRegister() throws Exception{
//		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
//				.param("title", "테스트 새 글 제목")
//				.param("content", "테스트 새 글 내용")
//				.param("writer", "hds1204"))
//		.andReturn()
//		.getModelAndView()
//		.getViewName();
//		
//		log.info("***************결과 페이지 : " + resultPage);
//	}
	
//	@Test
//	public void testModify() throws Exception{
//		String resultPage =  mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
//				.param("bno", "21")
//				.param("title", "수정된 테스트 새 글 제목")
//				.param("content", "수정된 테스트 새 글 내용")
//				.param("writer", "hds1204"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName();
//		
//		log.info(resultPage);
//	}
	
//	@Test
//	public void testRemove() throws Exception{
//		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
//				.param("bno", "8"))
//				.andReturn()
//				.getModelAndView()
//				.getViewName();
//		
//		log.info(resultPage);
//	}
}








