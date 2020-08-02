package com.koreait.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.koreait.domain.BoardVO;
import com.koreait.domain.Criteria;

public interface BoardMapper {
	
	public int getTotal(Criteria cri);
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
//	@Select("SELECT * FROM TBL_BOARD WHERE BNO > 0")
	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public void insertSelectKey_bno(BoardVO board);
	
	public BoardVO read(Long bno);
	
	//게시물이 삭제되었다면 1 이상의 값이 리턴되고
	//없는 게시물이라면 0이 리턴된다.
	public int delete(Long bno);
	
	//수정된 게시물 개수 리턴
	//매개변수는 BoardVO타입으로 설정한다.
	//테스트 서버에서 실행 전 존재하는 번호인지 먼저 확인하기
	public int update(BoardVO board);
	
}












