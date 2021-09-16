package utility;

public class Paging {

	// public static Paging instance = new Paging();

	// ����¡ ���� ����
	private int totalCount = 0; // �� ���ڵ� �Ǽ�
	private int totalPage = 0; // ��ü ������ ��
	private int pageNumber = 0; // ������ ������ �ѹ�
	private int pageSize = 0; // �� �������� ������ �Ǽ�
	private int beginRow = 0; // ���� �������� ���� ��
	private int endRow = 0; // ���� �������� �� ��
	private int pageCount = 3; // �� ȭ�鿡 ������ ������ ��ũ �� (������ ����)
	private int beginPage = 0; // ����¡ ó�� ���� ������ ��ȣ
	private int endPage = 0; // ����¡ ó�� �� ������ ��ȣ
	private int offset = 0;
	private int limit = 0;
	private String url = ""; // ���� ==> http://localhost:8989/MyServlet/list.do
	private String pagingHtml = "";// �ϴ��� ���� ������ ��ũ
	// private String pagingStatus = ""; //��� ������ ���� ������ ��ġ ǥ��
	// �˻��� ���� ���� �߰�
	private String whatColumn = ""; // �˻� ���(�ۼ���, ������, ��ü �˻��� all) ���
	private String keyword = ""; // �˻��� �ܾ�

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

	public String getWhatColumn() {
		return whatColumn;
	}

	public void setWhatColumn(String whatColumn) {
		this.whatColumn = whatColumn;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Paging(String _pageNumber, int totalCount, String url, String whatColumn, String keyword) {

		String _pageSize = "5"; //���������� ������ ������ ����
		
		if (_pageNumber == null || _pageNumber.equals("null") || _pageNumber.equals("")) {
			//System.out.println("_pageNumber:" + _pageNumber); // null
			_pageNumber = "1";
		}
		this.pageNumber = Integer.parseInt(_pageNumber); //������ ��ȣ
		this.pageSize = Integer.parseInt(_pageSize); //���������� ������ ������ ����
		this.limit = pageSize;
		this.totalCount = totalCount; // ���ڵ� �Ѱ���
		this.totalPage = (int) Math.ceil((double) this.totalCount / this.pageSize);
		// ceil(7.0/2) => 3.5=> 4

		this.beginRow = (this.pageNumber - 1) * this.pageSize + 1;
		this.endRow = this.pageNumber * this.pageSize;
		// pageNumber�� 2�̸� beginRow=6, endRow=10

		if (this.pageNumber > this.totalPage) {
			this.pageNumber = this.totalPage;
		}

		this.offset = (pageNumber - 1) * pageSize;
		/*
		 * 1������ ���� : (1-1) * 2 => 0 2������ ���� : (2-1) * 2 => 2 3������ ���� : (3-1) * 2 => 4
		 * 4������ ���� : (4-1) * 2 => 6
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
		this.url = url; // /ex/list.ab // �ش� url
		this.whatColumn = whatColumn; //�˻���(select�ڽ�)
		this.keyword = keyword;	//�˻���(�˻��ܾ�)
		// System.out.println("whatColumn:"+whatColumn+"/keyword:"+keyword);

		this.pagingHtml = getPagingHtml(url);

	}

	public String getPagingHtml(String url) { // ����¡ ���ڿ��� �����.
		// System.out.println("getPagingHtml url:"+url);

		String result = ""; // ����¡ html ������ ����.
		// added_param ���� : �˻� �����Ͽ� �߰��Ǵ� �Ķ���� ����Ʈ
		String added_param = "&whatColumn=" + whatColumn + "&keyword=" + keyword; // &whatColumn=singer&keyword=��

		result += "<ul class='pagination pagination-sm'>";
		if (this.beginPage != 1) { // ����, pageSize:�� ȭ�鿡 ���̴� ���ڵ� ��
			// ó�� ��Ϻ��⸦ �ϸ� pageNumber�� 1�� �ǰ� beginPage�� 1�� �ȴ�.
			result += "<li><a href='" + url + "?pageNumber=" + (1) + "&pageSize=" + this.pageSize + added_param + "'>�� ó��</a></li>";
			result += "<li><a href='" + url + "?pageNumber=" + (this.beginPage - 1) + "&pageSize=" + this.pageSize + added_param + "'>����</a></li>";
		}

		// ���
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

		if (this.endPage != this.totalPage) { // ����

			result += "<li><a href='" + url + "?pageNumber=" + (this.endPage + 1) + "&pageSize=" + this.pageSize + added_param + "'>����</a></li>";

			result += "<li><a href='" + url + "?pageNumber=" + (this.totalPage) + "&pageSize=" + this.pageSize + added_param + "'>�� ��</a></li>";
		}
		result += "</ul>";
		// System.out.println("result2:"+result);
		// result2 : <a href='/ex/list.ab?pageNumber=1&pageSize=2'>��
		// ó��</a>&nbsp;&nbsp;<a
		// href='/ex/list.ab?pageNumber=3&pageSize=2&whatColumn=null&keyword=null'>����</a>&nbsp;&nbsp;<font
		// color='red'>4</font>&nbsp;&nbsp;<a
		// href='/ex/list.ab?pageNumber=5&pageSize=2&whatColumn=null&keyword=null'>5</a>&nbsp;

		return result;
	}
}
