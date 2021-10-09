package user.like.model;

public class LikeBean {

	private int rownum;
	private int num; // pk
	private String id; // 20, not null, fk(users.id)
	private String acode; // 20, not null
	private int anum; // not null
	private String regdate; // sysdate

	private String name;
	private String summary;
	private String themecode;

	public LikeBean() {
	}

	public LikeBean(int num, String id, String acode, int anum, String regdate) {
		super();
		this.num = num;
		this.id = id;
		this.acode = acode;
		this.anum = anum;
		this.regdate = regdate;
	}

	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getThemecode() {
		return themecode;
	}

	public void setThemecode(String themecode) {
		this.themecode = themecode;
	}

	@Override
	public String toString() {
		return "LikeBean [rownum=" + rownum + ", num=" + num + ", id=" + id + ", acode=" + acode + ", anum=" + anum
				+ ", regdate=" + regdate + ", name=" + name + ", summary=" + summary + ", themecode=" + themecode + "]";
	}

}
