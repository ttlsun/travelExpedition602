package user.community.model;

import java.util.Arrays;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class CommunityBean {

	private int rownum;
	private int num;
	private int reservationnum; // 후기 예약번호
	private int reviewnum;
	private String reviewtype;

	// @Pattern(regexp = " /(.*?)\\.(jpg|jpeg|png|gif|pdf)$/", message =
	// "jpg,jpeg,png,gif,pdf 파일형식만 만올릴수있습니다.")
	@NotEmpty(message = "필수 선택사항")
	private String imgurl; // 대표이미지

	private MultipartFile updateFile; // 파일업로드 1개 (대표이미지명)

	// @Pattern(regexp = " /(.*?)\\.(jpg|jpeg|png|gif|pdf)$/", message =
	// "jpg,jpeg,png,gif,pdf 파일형식만 만올릴수있습니다.")
	@NotEmpty(message = "필수 선택사항")
	private String imgname; // 여러개이미지명칭
	private MultipartFile[] multipleUpdateFile; // 파일업로드 여러개

	@NotBlank(message = "필수 입력사항")
	@Length(min = 2, max = 150, message = "타이틀 한글 2~150자 입력")
	private String title;

	@NotBlank(message = "필수 입력사항")
	@Length(min = 2, max = 150, message = "한줄요약 한글 2~150자 입력")
	private String summary;

	@NotBlank(message = "필수 입력사항")
	private String contents;
	private int readcount;
	private int recommend;
	private int steamed;

	private int starranking;
	private String regkeyword;

	private String status;
	private String regid;
	private String regdate;
	private String modid;
	private String moddate;

	public CommunityBean() {
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

	public int getReservationnum() {
		return reservationnum;
	}

	public void setReservationnum(int reservationnum) {
		this.reservationnum = reservationnum;
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

	public String getImgurl() {
		return imgurl;
	}

	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}

	public MultipartFile getUpdateFile() {
		return updateFile;
	}

	public void setUpdateFile(MultipartFile updateFile) {
		this.updateFile = updateFile;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public int getSteamed() {
		return steamed;
	}

	public void setSteamed(int steamed) {
		this.steamed = steamed;
	}

	public int getStarranking() {
		return starranking;
	}

	public void setStarranking(int starranking) {
		this.starranking = starranking;
	}

	public String getRegkeyword() {
		return regkeyword;
	}

	public void setRegkeyword(String regkeyword) {
		this.regkeyword = regkeyword;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

	public String getModid() {
		return modid;
	}

	public void setModid(String modid) {
		this.modid = modid;
	}

	public String getModdate() {
		return moddate;
	}

	public void setModdate(String moddate) {
		this.moddate = moddate;
	}


	@Override
	public String toString() {
		return "CommunityBean [rownum=" + rownum + ", num=" + num + ", reservationnum=" + reservationnum
				+ ", reviewnum=" + reviewnum + ", reviewtype=" + reviewtype + ", imgurl=" + imgurl + ", updateFile="
				+ updateFile + ", imgname=" + imgname + ", multipleUpdateFile=" + Arrays.toString(multipleUpdateFile)
				+ ", title=" + title + ", summary=" + summary + ", contents=" + contents + ", readcount=" + readcount
				+ ", recommend=" + recommend + ", steamed=" + steamed + ", starranking=" + starranking + ", regkeyword="
				+ regkeyword + ", status=" + status + ", regid=" + regid + ", regdate=" + regdate + ", modid=" + modid
				+ ", moddate=" + moddate + "]";
	}

}
