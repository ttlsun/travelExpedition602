package user.camping.model;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class CampingBean {

	private int rownum;
	
	private int num;

	@NotBlank(message = "캠핑장 상호명 입력은 필수입니다.")
	private String name;

	@NotEmpty(message = "캠핑장 유형을 선택하세요.")
	private String camptype;

	@NotEmpty(message = "캠핑장 테마를 선택하세요.")
	private String themecode;

	private String regkeyword;
	
	@NotBlank(message = "한줄 소개글 입력은 필수입니다.")
	private String summary;
	
	@NotBlank(message = "대표이미지를 선택하세요.")
	private String imgurl;
	
	private MultipartFile updateFile; // 대표이미지명
	
	private String options;
	private String contents;
	private int postcode;

	@NotEmpty(message = "캠핑장 주소(시도) 입력은 필수입니다.")
	private String address1;
	@NotEmpty(message = "캠핑장 주소(시군구) 입력은 필수입니다.")
	private String address2;
	@NotEmpty(message = "캠핑장 주소(동길) 입력은 필수입니다.")
	private String address3;
	@NotEmpty(message = "캠핑장 주소(상세주소) 입력은 필수입니다.")
	private String address4;

	private String latitude;
	private String longitude;
	
	@NotBlank(message = "캠핑장 연락처 입력은 필수입니다.")
	private String contact;
	
	private String regdate;
	private String regid;
	private String moddate;
	private String modid;
	private int readcount;
	private int recommend;
	private int steamed;
	private int reviewcount;
	private String status; //00:완전삭제/01:노출/02:비노출

	
	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}

	public int getNum() {
		return num;
	}

	public String getOptions() {
		return options;
	}

	public void setOptions(String options) {
		this.options = options;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCamptype() {
		return camptype;
	}

	public void setCamptype(String camptype) {
		this.camptype = camptype;
	}

	public String getThemecode() {
		return themecode;
	}

	public void setThemecode(String themecode) {
		this.themecode = themecode;
	}

	public String getRegkeyword() {
		return regkeyword;
	}

	public void setRegkeyword(String regkeyword) {
		this.regkeyword = regkeyword;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
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

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getPostcode() {
		return postcode;
	}

	public void setPostcode(int postcode) {
		this.postcode = postcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getAddress3() {
		return address3;
	}

	public void setAddress3(String address3) {
		this.address3 = address3;
	}

	public String getAddress4() {
		return address4;
	}

	public void setAddress4(String address4) {
		this.address4 = address4;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
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

	public int getReviewcount() {
		return reviewcount;
	}

	public void setReviewcount(int reviewcount) {
		this.reviewcount = reviewcount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "CampingBean [num=" + num + ", name=" + name + ", camptype=" + camptype + ", themecode=" + themecode
				+ ", regkeyword=" + regkeyword + ", summary=" + summary + ", imgurl=" + imgurl + ", updateFile="
				+ updateFile + ", options=" + options + ", contents=" + contents + ", postcode=" + postcode
				+ ", address1=" + address1 + ", address2=" + address2 + ", address3=" + address3 + ", address4="
				+ address4 + ", latitude=" + latitude + ", longitude=" + longitude + ", contact=" + contact
				+ ", regdate=" + regdate + ", regid=" + regid + ", moddate=" + moddate + ", modid=" + modid
				+ ", readcount=" + readcount + ", recommend=" + recommend + ", steamed=" + steamed + ", reviewcount="
				+ reviewcount + ", status=" + status + "]";
	}

}
