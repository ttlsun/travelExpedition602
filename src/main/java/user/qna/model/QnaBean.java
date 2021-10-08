package user.qna.model;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class QnaBean {

	private int rownum;
	private int num; // pk
	private String id; // 20, not null, fk(users.id)
	private String name;
	private String pw; // 20

	@NotBlank(message = "필수 입력사항입니다.")
	@Length(min = 2, max = 150, message = "타이틀 한글 2~150자 입력")
	private String title; // 200, not null

	@NotBlank(message = "필수 입력사항입니다.")
	private String contents; // clob, not null
	
	@NotEmpty(message = "필수 입력사항입니다.")
	private String regkeyword; // 100

	private String regdate; // sysdate
	private String moddate;
	private String modid; // 20
	private String status; // 50
	private int ref; // not null
	private int restep; // not null
	private int relevel; // not null

	private String imgname; // 여러개이미지명칭
	private MultipartFile[] multipleUpdateFile; // 파일업로드 여러개

	public QnaBean() {
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getRegkeyword() {
		return regkeyword;
	}

	public void setRegkeyword(String regkeyword) {
		this.regkeyword = regkeyword;
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

}
