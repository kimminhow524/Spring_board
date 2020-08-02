package com.koreait.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.koreait.domain.BoardVO;
import com.koreait.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
//	@Test
//	public void testGetList() {
//		mapper.getList().forEach(board -> log.info(board));
//	}
	
	@Test
	public void testGetListWithPaging() {
		Criteria cri = new Criteria();
		
		cri.setPageNum(2);
		cri.setAmount(20);
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
		
	}
	
//	
//	@Test
//	public void testInsert() {
//		//결과 : bno가 null.
//		//작업은 완료되지만 현재 추가된 데이터의 PK값은 알 수 없다.
//		BoardVO board = new BoardVO();
//		board.setTitle("새로 작성한 글 제목");
//		board.setContent("새로 작성한 글 내용");
//		board.setWriter("newbie");
//		
//		mapper.insert(board);
//		
//		log.info(board);
//	}
	
//	@Test
//	public void testInsertSelectKey_bno() {
//		//결과
//		//PK값을 미리 SQL을 통해서 처리해 두고 지정한 이름으로 결과를 보관하는 방식
//		//SQL을 한 번 더 실행하는 부담이 있기는 하지만 자동으로 추가되는 PK값을 확인해야 하는 상황에서는
//		//유용하게 사용될 수 있다.
//		BoardVO board = new BoardVO();
//		board.setTitle("새로 작성한 글 제목");
//		board.setContent("새로 작성한 글 내용");
//		board.setWriter("newbie");
//		
//		mapper.insertSelectKey_bno(board);
//		
//		log.info(board);
//	}
	
//	@Test
//	public void testRead() {
//		BoardVO board = mapper.read(3L);
//		
//		log.info(board);
//	}
	
//	@Test
//	public void testDelete() {
//		log.info("DELETE COUNT : " + mapper.delete(3L));
//	}
	
//	@Test
//	public void testUpdate() {
//		Long bno = 2L;
//		if(mapper.read(bno) != null) {
//			BoardVO board = new BoardVO();
//			board.setBno(bno);
//			board.setTitle("수정된 제목");
//			board.setContent("수정된 내용");
//			board.setWriter("user00");
//			
//			int count = mapper.update(board);
//			log.info("UPDATE COUNT : " + count);
//			
//		}else {
//			log.info("*******No such board*******");
//		}
//	}
	
}











