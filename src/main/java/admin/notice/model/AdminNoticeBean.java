package admin.notice.model;

import java.util.Arrays;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class AdminNoticeBean {

	private int rownum;
	private int num; // pk
	private String id; // 20, not null, fk(users.id)

	@NotEmpty(message = "필수 선택사항")
	@Length(min = 2, max = 150, message = "타이틀 한글 2~150자 입력")
	private String title; // 200, not null

	@NotEmpty(message = "필수 선택사항")
	private String contents; // clob, not null

	private String regdate; // sysdate
	private String moddate;
	private String modid; // 20
	private int readcount; // 0

	private String imgname; // 여러개이미지명칭
	private MultipartFile[] multipleUpdateFile; // 파일업로드 여러개

	public AdminNoticeBean() {
		super();
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

	public String getImgname() {
		return imgname;
	}

	public void setImgname(String imgname) {
		this.imgname = imgname;
	}

	public MultipartFile[] getMultipleUpdateFile() {
		return multipleUpdateFile;
	}

	public void setMultipleUpdateFile(MultipartFile[] multipleUpdateFile) {
		this.multipleUpdateFile = multipleUpdateFile;
	}

	@Override
	public String toString() {
		return "AdminNoticeBean [num=" + num + ", id=" + id + ", title=" + title + ", contents=" + contents
				+ ", regdate=" + regdate + ", moddate=" + moddate + ", modid=" + modid + ", readcount=" + readcount
				+ ", imgname=" + imgname + ", multipleUpdateFile=" + Arrays.toString(multipleUpdateFile) + "]";
	}

}
