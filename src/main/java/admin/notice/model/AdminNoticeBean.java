package admin.notice.model;

public class AdminNoticeBean {
	private int num; //pk
	private String id; //20, not null, fk(users.id)
	private String title; //200, not null
	private String contents; //clob, not null
	private int postimgnum;
	private String regdate; //sysdate
	private String moddate;
	private String modid; //20
	private int readcount; //0
	
	public AdminNoticeBean() {
		super();
	}
	public AdminNoticeBean(int num, String id, String title, String contents, int postimgnum, String regdate,
			String moddate, String modid, int readcount) {
		super();
		this.num = num;
		this.id = id;
		this.title = title;
		this.contents = contents;
		this.postimgnum = postimgnum;
		this.regdate = regdate;
		this.moddate = moddate;
		this.modid = modid;
		this.readcount = readcount;
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	public int getPostimgnum() {
		return postimgnum;
	}
	public void setPostimgnum(int postimgnum) {
		this.postimgnum = postimgnum;
	}
	
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	public String getModdate() {
		return moddate;
	}
	public void setModdate(String moddate) {
		this.moddate = moddate;
	}
	
	public String getModid() {
		return modid;
	}
	public void setModid(String modid) {
		this.modid = modid;
	}
	
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
}
