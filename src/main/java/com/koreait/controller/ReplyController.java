package com.koreait.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.koreait.domain.Criteria;
import com.koreait.domain.ReplyPageDTO;
import com.koreait.domain.ReplyVO;
import com.koreait.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
public class ReplyController {
	@Setter(onMethod_ = @Autowired)
	private ReplyService service;
	
	//댓글 등록
	//브라우저에서 JSON타입으로 데이터를 전송하고 서버에서는 댓글의 처리 결과에 따라 문자열로 결과를 리턴한다.
	//consumes와 produces를 통해서 JSON방식의 데이터만 처리하도록 한다.
	@PostMapping(value="/new", consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	//ResponseEntity : 서버의 상태코드, 응답 메세지 등을 담을 수 있는 타입
	//@RequestBody : JSON데이터를 ReplyVO타입으로 변환하도록 지정한다.
	public ResponseEntity<String> create(@RequestBody ReplyVO reply){
		
		log.info("ReplyVO: " + reply);
		
		int insertCount = service.register(reply);
		
		log.info("Reply Insert Count : " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) :	//200 OK
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	//500 Server Error
	}
	
	//댓글 전체 목록
	@GetMapping(value="/pages/{bno}/{page}", produces= {
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("bno") Long bno, @PathVariable("page") int page){
		log.info("getList...........");
		Criteria cri = new Criteria(page, 10);
		
		log.info(cri);
		
		return new ResponseEntity<>(service.getList(cri, bno), HttpStatus.OK);
	}
	
	//댓글 조회
	@GetMapping(value="/{rno}", produces= {
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		log.info("get : " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	//댓글 수정
	//PUT : 자원의 전체 수정, 자원 내 모든 필드를 전달해야 함, 일부만 전달할 경우 전달되지 않은 필드는 모두 초기화 처리가 된다.
	//PATCH : 자원의 일부 수정, 수정할 필드만 전송
	//PUT과  PATCH 모두 사용가능
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH},
			value= {"/{rno}"}, consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	//@RequestBody로 지정된 객체는 URI로 값을 전달할 수 없으므로 전달 할 값은 @PathVariable로 따로 설정해주어야 한다.
	public ResponseEntity<String> modify(@RequestBody ReplyVO reply, @PathVariable("rno") Long rno){
		reply.setRno(rno);
		
		log.info("rno : " + rno);
		log.info("modify : " + reply);
		
		return service.modify(reply) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) :
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 삭제
	//@DeleteMapping
	@DeleteMapping(value="/{rno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		log.info("remove : " + rno);
		
		return service.remove(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK) :
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}



















