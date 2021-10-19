package user.room.model;

import java.util.Arrays;

import javax.validation.constraints.Min;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class RoomBean {
	
	private int num;
	
	@NotBlank(message = "객실명 입력은 필수입니다.")
	private String name;
	
	private String roomtype;
	private int cnum;
	
	@NotBlank(message = "대표이미지를 선택하세요.")
	private String imgurl; // 대표이미지
	private MultipartFile updateFile; // 대표이미지명

	private String imgname; // 상세이미지(여러장)
	private MultipartFile[] multipleUpdateFile; // 상세이미지명(여러장)

	private String summary;
	
	@NotBlank(message = "내용을 선택하세요.")
	private String contents;
	
	@Min(value = 1, message = "적정인원 입력은 필수입니다.")
	private int propguests;
	@Min(value = 1, message = "최대인원 입력은 필수입니다.")
	private int maxguests;
	@Min(value = 1, message = "주중 가격 입력은 필수입니다.")
	private int weekdayprice;
	@Min(value = 1, message = "주말 가격 입력은 필수입니다.")
	private int weekendprice;
	
	private String options;
	private String amenity;
	private String regdate;
	private String regid;
	private String moddate;
	private String modid;
	private String status; //00:완전삭제/01:노출/02:비노출
	

	public int getNum() {
		return num;
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

	public String getRoomtype() {
		return roomtype;
	}

	public void setRoomtype(String roomtype) {
		this.roomtype = roomtype;
	}

	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
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

	public int getPropguests() {
		return propguests;
	}

	public void setPropguests(int propguests) {
		this.propguests = propguests;
	}

	public int getMaxguests() {
		return maxguests;
	}

	public void setMaxguests(int maxguests) {
		this.maxguests = maxguests;
	}

	public int getWeekdayprice() {
		return weekdayprice;
	}

	public void setWeekdayprice(int weekdayprice) {
		this.weekdayprice = weekdayprice;
	}

	public int getWeekendprice() {
		return weekendprice;
	}

	public void setWeekendprice(int weekendprice) {
		this.weekendprice = weekendprice;
	}

	public String getOptions() {
		return options;
	}

	public void setOptions(String options) {
		this.options = options;
	}

	public String getAmenity() {
		return amenity;
	}

	public void setAmenity(String amenity) {
		this.amenity = amenity;
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
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "RoomBean [num=" + num + ", name=" + name + ", roomtype=" + roomtype + ", cnum=" + cnum + ", imgurl="
				+ imgurl + ", updateFile=" + updateFile + ", imgname=" + imgname + ", multipleUpdateFile="
				+ Arrays.toString(multipleUpdateFile) + ", summary=" + summary + ", contents=" + contents
				+ ", propguests=" + propguests + ", maxguests=" + maxguests + ", weekdayprice=" + weekdayprice
				+ ", weekendprice=" + weekendprice + ", options=" + options + ", amenity=" + amenity + ", regdate="
				+ regdate + ", regid=" + regid + ", moddate=" + moddate + ", modid=" + modid + ", status=" + status
				+ "]";
	}

	
	
}
