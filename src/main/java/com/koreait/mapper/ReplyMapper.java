package com.koreait.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.koreait.domain.Criteria;
import com.koreait.domain.ReplyVO;

public interface ReplyMapper {
	
	public int getTotal(Long bno);
	
	public int insert(ReplyVO reply);
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO reply);
	
	//기존의 게시물 페이징 처리 + 특정 게시물 번호를 전달해야 한다.
	//Mybatis는 두 개 이상의 데이터를 파라미터로 전달하기 위해서는
	//별도의 객체로 구성하거나 Map, @Param을 이용한다.
	
	//이 중 가장 간단한 @Param을 이용하는 방식으로 사용하며, 속성값은
	//Mybatis에서 #{}으로 사용가능하다.
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	
	
}
