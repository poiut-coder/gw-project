package com.gw.ui;

public class ProjectPager {

	
	private int pageSize;//한 페이지당 데이터 개수
	private int pagerSize;//번호로 보여주는 페이지 Link 개수
	private int dataCount;//총 데이터 수
	
	private int pageNo;//현재 페이지 번호
	private int pageCount;//총 페이지 수
	
	private String linkUrl;//페이저가 포함되는 페이지의 주소
	
	
	public ProjectPager(int dataCount, int pageNo, 
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
		
 		linkString.append("<div class=\"card-body\">");
 		linkString.append("<ul class=\"pagination justify-content-center\">");
		//1. 처음, 이전 항목 만들기   
      
       linkString.append(
			String.format("<li class=\"page-item\"><a class=\"page-link\" href='%s?pageNo=1'><i class=\"fas fa-angle-double-left\"></i></a></li>",linkUrl));
		if (pageNo==1) {
			linkString.append("<li class=\"page-item\"><span class=\"page-link\"><i class=\"fas fa-angle-left\"></i></span></li>");
		} else {
			linkString.append(
					String.format("<li class=\"page-item\"><a class=\"page-link\" href='%s?pageNo=%d'><i class=\"fas fa-angle-left\"></i></a></li>", linkUrl, pageNo - 1));
		}
        
		//2. 페이지 번호 Link 만들기
		int pagerBlock = (pageNo - 1) / pagerSize;
		int start = (pagerBlock * pagerSize) + 1;
		int end = start + pagerSize;
		for (int i = start; i < end; i++) {
			if (i > pageCount) break;
			linkString.append("<li class=\"page-item\">");
			if(i == pageNo) {
				linkString.append(String.format("<span style='color:black' class=\"page-link\">%d</span>", i));
			} else { 
				linkString.append(String.format(
					"<a class=\"page-link\" href='%s?pageNo=%d'>%d</a>", linkUrl, i, i));
			}

	        linkString.append("</li>");
		}
		
		//3. 다음, 마지막 항목 만들기
		if (pageNo == pageCount) {
			linkString.append("<li class=\"page-item\"><span class=\"page-link\"><i class=\"fas fa-angle-right\"></i></span></li>");
		} else {
			linkString.append(String.format("<li class=\"page-item\"><a class=\"page-link\" href='%s?pageNo=%d'><i class=\"fas fa-angle-right\"></i></a></li>", linkUrl, pageNo + 1));
		}
		linkString.append(String.format(
			"<li class=\"page-item\"><a class=\"page-link\" href='%s?pageNo=%d'><i class=\"fas fa-angle-double-right\"></i></a></li>", linkUrl, pageCount));
		
		linkString.append("</ul>");
		linkString.append("</div>");
		
		return linkString.toString();
	}
}
