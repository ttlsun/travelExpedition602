package user.common.model;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;

public class KeywordBean {

	private int rownum;
	private int num;
	
	@NotEmpty(message = "필수 선택사항")
	private String acode;
	
	@NotBlank(message = "필수 입력사항")
	@Length(min = 2, max = 30, message = "타이틀 한글 2~30자 입력")
	private String tag;
	
	private String regdate;
	private String regid;
	private String moddate;
	private String modid;

	public KeywordBean() {
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

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
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
		return "KeywordBean [num=" + num + ", acode=" + acode + ", tag=" + tag + ", regdate=" + regdate + ", regid="
				+ regid + ", moddate=" + moddate + ", modid=" + modid + "]";
	}

}
