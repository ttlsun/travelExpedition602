package com.my.travelExpedition.utility;

import java.util.Iterator;
import java.util.Map;

public class Paging {

	// public static Paging instance = new Paging();

	// 페이징 관련 변수
	private int totalCount = 0; // 총 레코드 건수
	private int totalPage = 0; // 전체 페이지 수
	private int pageNumber = 0; // 보여줄 페이지 넘버
	private int pageSize = 0; // 한 페이지에 보여줄 건수
	private int beginRow = 0; // 현재 페이지의 시작 행
	private int endRow = 0; // 현재 페이지의 끝 행
	private int pageCount = 3; // 한 화면에 보여줄 페이지 링크 수 (페이지 갯수)
	private int beginPage = 0; // 페이징 처리 시작 페이지 번호
	private int endPage = 0; // 페이징 처리 끝 페이지 번호
	private int offset = 0;
	private int limit = 0;
	private String url = ""; // 예시 ==> http://localhost:8989/MyServlet/list.do
	private String pagingHtml = "";// 하단의 숫자 페이지 링크
	// private String pagingStatus = ""; //상단 우측의 현재 페이지 위치 표시
	// private String whatColumn = ""; //키워드
	// private String keyword = ""; //검색단어
	// 검색을 위한 변수 추가
	private String params = ""; // 파라미터 추가

	
	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getBeginRow() {
		return beginRow;
	}

	public void setBeginRow(int beginRow) {
		this.beginRow = beginRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getPagingHtml() {
		// System.out.println("pagingHtml:"+pagingHtml);
		return pagingHtml;
	}

	public void setPagingHtml(String pagingHtml) {
		this.pagingHtml = pagingHtml;
	}
	
	/**
	 * 페이지 정보 생성
	 * @param map : 넘어온 파라미터들
	 * @param _pageSize : 페이징 사이즈 
	 * @param totalCount : 페이지 총갯수
	 * @param url : 페이지정보
	 */
	public Paging(Map<String, String> map, String _pageSize, int totalCount, String url) {
		this(map.get("pageNumber"), _pageSize, totalCount, url, "", "");
		
		StringBuilder sb = new StringBuilder();
		
		Iterator<String> iter = map.keySet().iterator();
		System.out.println("list : 넘어온 파라미터들 ------------------------");
		while (iter.hasNext()) {
			String key = iter.next();
			String value = (String) map.get(key);
			System.out.println(key + " : " + value);
			
			if (value != null && !value.equals("")) {
				sb.append("&").append(key).append("=").append(value);
			}
		}
		System.out.println("-------------------------------------------");
		this.params = sb.toString();
		
		//값 받아서 다시 그리기.
		this.pagingHtml = getPagingHtml(url);
	}
	public Paging(String _pageNumber, String _pageSize, int totalCount, String url, String whatColumn, String keyword) {
		if (_pageNumber == null || _pageNumber.equals("null") || _pageNumber.equals("")) {
			//System.out.println("_pageNumber:" + _pageNumber); // null
			_pageNumber = "1";
		}
		this.pageNumber = Integer.parseInt(_pageNumber);
		if (_pageSize == null || _pageSize.equals("null") || _pageSize.equals("")) {
			_pageSize = "5"; // 한 페이지에 보여줄 레코드 갯수
		}
		this.pageSize = Integer.parseInt(_pageSize);
		this.limit = pageSize;
		this.totalCount = totalCount;
		this.totalPage = (int) Math.ceil((double) this.totalCount / this.pageSize);
		// ceil(7.0/2) => 3.5=> 4

		this.beginRow = (this.pageNumber - 1) * this.pageSize + 1;
		this.endRow = this.pageNumber * this.pageSize;
		// pageNumber가 2이면 beginRow=6, endRow=10

		if (this.pageNumber > this.totalPage) {
			this.pageNumber = this.totalPage;
		}

		this.offset = (pageNumber - 1) * pageSize;
		/*
		 * 1페이지 선택 : (1-1) * 2 => 0 2페이지 선택 : (2-1) * 2 => 2 3페이지 선택 : (3-1) * 2 => 4
		 * 4페이지 선택 : (4-1) * 2 => 6
		 */

		if (this.endRow > this.totalCount) {
			this.endRow = this.totalCount;
		}

		this.beginPage = (this.pageNumber - 1) / this.pageCount * this.pageCount + 1;
		this.endPage = this.beginPage + this.pageCount - 1;

		// System.out.println("pageNumber:"+pageNumber+"/totalPage:"+totalPage);

		if (this.endPage > this.totalPage) {
			this.endPage = this.totalPage;
		}

		// System.out.println("pageNumber2:"+pageNumber+"/totalPage2:"+totalPage);
		this.url = url; // /ex/list.ab
		this.params = "&whatColumn=" + whatColumn + "&keyword=" + keyword;
		// System.out.println("whatColumn:"+whatColumn+"/keyword:"+keyword);

		this.pagingHtml = getPagingHtml(url);
	}

	public String getPagingHtml(String url) { // 페이징 문자열을 만든다.
		// System.out.println("getPagingHtml url:"+url);

		String result = ""; // 페이징 html 조립할 변수.
		// added_param 변수 : 검색 관련하여 추가되는 파라미터 리스트
		String added_param = params; // &whatColumn=singer&keyword=아

		result += "<ul class='pagination pagination-sm'>";
		if (this.beginPage != 1) { // 앞쪽, pageSize:한 화면에 보이는 레코드 수
			// 처음 목록보기를 하면 pageNumber는 1이 되고 beginPage도 1이 된다.
			result += "<li><a href='" + url + "?pageNumber=" + (1) + "&pageSize=" + this.pageSize + added_param + "'>맨 처음</a></li>";
			result += "<li><a href='" + url + "?pageNumber=" + (this.beginPage - 1) + "&pageSize=" + this.pageSize + added_param + "'>이전</a></li>";
		}

		// 가운데
		String liActive = "";
		for (int i = this.beginPage; i <= this.endPage; i++) {
			liActive = i == this.pageNumber ? "active" : "";
			if (i == this.pageNumber) {
				result += "<li class='" + liActive + "'><a href='#'>" + i + "</a></li>";
			} else {
				result += "<li><a href='" + url + "?pageNumber=" + i + "&pageSize=" + this.pageSize + added_param + "'>" + i + "</a></li>";
			}
		}
		// System.out.println("result:"+result);
		// System.out.println();

		if (this.endPage != this.totalPage) { // 뒤쪽

			result += "<li><a href='" + url + "?pageNumber=" + (this.endPage + 1) + "&pageSize=" + this.pageSize + added_param + "'>다음</a></li>";

			result += "<li><a href='" + url + "?pageNumber=" + (this.totalPage) + "&pageSize=" + this.pageSize + added_param + "'>맨 끝</a></li>";
		}
		result += "</ul>";
		// System.out.println("result2:"+result);
		// result2 : <a href='/ex/list.ab?pageNumber=1&pageSize=2'>맨
		// 처음</a>&nbsp;&nbsp;<a
		// href='/ex/list.ab?pageNumber=3&pageSize=2&whatColumn=null&keyword=null'>이전</a>&nbsp;&nbsp;<font
		// color='red'>4</font>&nbsp;&nbsp;<a
		// href='/ex/list.ab?pageNumber=5&pageSize=2&whatColumn=null&keyword=null'>5</a>&nbsp;

		return result;
	}
}
