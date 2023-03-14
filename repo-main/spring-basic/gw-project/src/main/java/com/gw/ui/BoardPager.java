package com.gw.ui;

import lombok.Data;

@Data
public class BoardPager {
	
	private int pageSize;//한 페이지당 데이터 개수
	private int pagerSize;//번호로 보여주는 페이지 Link 개수
	private int dataCount;//총 데이터 수
	
	private int pageNo;//현재 페이지 번호
	private int pageCount;//총 페이지 수
	
	private String linkUrl;//페이저가 포함되는 페이지의 주소
	
	
	public BoardPager(int dataCount, int pageNo, 
		int pageSize, int pagerSize, String linkUrl) {
		
		this.linkUrl = linkUrl;
		
		this.dataCount = dataCount;
		this.pageSize = pageSize;
		this.pagerSize = pagerSize;
		this.pageNo = pageNo;		
		pageCount = 
			(dataCount / pageSize) + ((dataCount % pageSize) > 0 ? 1 : 0); 
	}
	
	public String toString(){
		StringBuffer linkString = new StringBuffer(2048);
		
		//2. 페이지 번호 Link 만들기
		int pagerBlock = (pageNo - 1) / pagerSize;
		int start = (pagerBlock * pagerSize) + 1;
		int end = start + pagerSize;
		for (int i = start; i < end; i++) {
			if (i > pageCount) break;
			if (i == pageNo) { 
				linkString.append(String.format(
					"<li class=\"page-item page-number\"><a class=\"page-link\" href='%s?pageNo=%d' style='font-weight:bold;'>%d</a></li>", linkUrl, i, i));
			} else {
				linkString.append(String.format(
					"<li class=\"page-item page-number\"><a class=\"page-link\" href='%s?pageNo=%d'>%d</a></li>", linkUrl, i, i));
			}
		}

		return linkString.toString();
	}

}












