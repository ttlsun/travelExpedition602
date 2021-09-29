package admin.qna.model;

public class AdminQnaBean {
	private int num; //pk
	private String id; //20, not null, fk(users.id)
	private String pw; //20
	private String title; //200, not null
	private String contents; //clob, not null
	private int postimgnum; 
	private String reg_keyword; //100
	private String regdate; //sysdate
	private String moddate;
	private String modid; //20
	private String status; //50
	private int ref; //not null
	private int restep; //not null
	private int relevel; //not null
	
	public AdminQnaBean() {
		super();
	}
	public AdminQnaBean(int num, String id, String pw, String title, String contents, int postimgnum,
			String reg_keyword, String regdate, String moddate, String modid, String status, int ref, int restep,
			int relevel) {
		super();
		this.num = num;
		this.id = id;
		this.pw = pw;
		this.title = title;
		this.contents = contents;
		this.postimgnum = postimgnum;
		this.reg_keyword = reg_keyword;
		this.regdate = regdate;
		this.moddate = moddate;
		this.modid = modid;
		this.status = status;
		this.ref = ref;
		this.restep = restep;
		this.relevel = relevel;
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
	
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
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
	
	public String getReg_keyword() {
		return reg_keyword;
	}
	public void setReg_keyword(String reg_keyword) {
		this.reg_keyword = reg_keyword;
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
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	
	public int getRestep() {
		return restep;
	}
	public void setRestep(int restep) {
		this.restep = restep;
	}

	public int getRelevel() {
		return relevel;
	}
	public void setRelevel(int relevel) {
		this.relevel = relevel;
	}
}
