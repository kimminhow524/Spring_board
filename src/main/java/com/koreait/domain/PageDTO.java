package com.koreait.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;
	private int endPage;
	private int realEnd;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		//Math.ceil(실수 값) : 올림처리, 페이지에 게시글이 한 개라도 있더라도 올림으로서 페이지를 표시하기 위함.
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0) * 10);
		this.startPage = this.endPage - 9;
		
		this.realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(this.endPage > realEnd){
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}






