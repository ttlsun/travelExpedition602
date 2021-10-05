package user.community.model;

import org.hibernate.validator.constraints.NotBlank;

public class CommunityReplyBean {

	private int rownum;
	private int num;
	private int reviewnum;
	private String reviewtype;

	@NotBlank
	private String contents;

	private String regid;
	private String regdate;

	private String regname; // 등록자 이름

	public CommunityReplyBean() {
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

	public int getReviewnum() {
		return reviewnum;
	}

	public void setReviewnum(int reviewnum) {
		this.reviewnum = reviewnum;
	}

	public String getReviewtype() {
		return reviewtype;
	}

	public void setReviewtype(String reviewtype) {
		this.reviewtype = reviewtype;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getRegid() {
		return regid;
	}

	public void setRegid(String regid) {
		this.regid = regid;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getRegname() {
		return regname;
	}

	public void setRegname(String regname) {
		this.regname = regname;
	}

	@Override
	public String toString() {
		return "CommunityReplyBean [rownum=" + rownum + ", num=" + num + ", reviewnum=" + reviewnum + ", reviewtype="
				+ reviewtype + ", contents=" + contents + ", regid=" + regid + ", regdate=" + regdate + ", regname="
				+ regname + "]";
	}

}
