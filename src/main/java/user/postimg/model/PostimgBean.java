package user.postimg.model;

public class PostimgBean {

	private int rownum;
	private int num; // pk
	private String acode; // 20, not null
	private int anum; // not null
	private String imgname; // 40
	private String imgraw; // 500, not null
	private String regdate; // sysdate
	private String regid; // 20, not null
	private String moddate;
	private String modid; // 20

	public PostimgBean() {
		super();
	}

	public PostimgBean(int num, String acode, int anum, String imgname, String imgraw, String regdate, String regid,
			String moddate, String modid) {
		super();
		this.num = num;
		this.acode = acode;
		this.anum = anum;
		this.imgname = imgname;
		this.imgraw = imgraw;
		this.regdate = regdate;
		this.regid = regid;
		this.moddate = moddate;
		this.modid = modid;
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

	public String getImgname() {
		return imgname;
	}

	public void setImgname(String imgname) {
		this.imgname = imgname;
	}

	public String getImgraw() {
		return imgraw;
	}

	public void setImgraw(String imgraw) {
		this.imgraw = imgraw;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getRegid() {
		return regid;
	}

	public void setRegid(String regid) {
		this.regid = regid;
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

	@Override
	public String toString() {
		return "PostimgBean [num=" + num + ", acode=" + acode + ", anum=" + anum + ", imgname=" + imgname + ", imgraw="
				+ imgraw + ", regdate=" + regdate + ", regid=" + regid + ", moddate=" + moddate + ", modid=" + modid
				+ "]";
	}

}
