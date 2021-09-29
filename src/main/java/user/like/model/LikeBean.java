package user.like.model;

public class LikeBean {
	private int num; //pk
	private String id; //20, not null, fk(users.id)
	private String acode; //20, not null
	private int anum; //not null
	private String regdate; //sysdate
	
	public LikeBean() {
		super();
	}
	public LikeBean(int num, String id, String acode, int anum, String regdate) {
		super();
		this.num = num;
		this.id = id;
		this.acode = acode;
		this.anum = anum;
		this.regdate = regdate;
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
	
	public String getAcode() {
		return acode;
	}
	public void setAcode(String acode) {
		this.acode = acode;
	}
	
	public int getAnum() {
		return anum;
	}
	public void setAnum(int anum) {
		this.anum = anum;
	}

	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
}
