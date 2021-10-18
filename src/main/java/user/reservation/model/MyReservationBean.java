package user.reservation.model;

public class MyReservationBean {

	/* 예약 정보 컬럼 */
	private int rownum;
	private int num;
	private int cnum;
	private int rnum;
	private String id;
	private String checkindate;
	private String checkoutdate;
	private String regdate;
	private int guests;
	private String name;
	private String phone;
	private String email;
	private String requested;
	private int totalprice;
	private String status;

	private String paycode;
	private String paydetail1;
	private String paydetail2;
	private int cvc;

	/* 캠핑 정보 컬럼 */
	private int campingnum;
	private String campingname;
	private String camptype;
	private String themecode;
	private String regkeyword;
	private String summary;
	private String contents;
	private String campingimgurl;
	private int postcode;
	private String addr;
	private String contact;

	/* 룸 정보 컬럼 */
	private int roomnum;
	private String roomname;
	private String roomtype;
	private String roomimg;
	private int propguests;
	private int maxguests;
	private int weekdayprice;
	private int weekendprice;
	private String options;
	private String amenity;

	public MyReservationBean() {

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

	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCheckindate() {
		return checkindate;
	}

	public void setCheckindate(String checkindate) {
		this.checkindate = checkindate;
	}

	public String getCheckoutdate() {
		return checkoutdate;
	}

	public void setCheckoutdate(String checkoutdate) {
		this.checkoutdate = checkoutdate;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getGuests() {
		return guests;
	}

	public void setGuests(int guests) {
		this.guests = guests;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRequested() {
		return requested;
	}

	public void setRequested(String requested) {
		this.requested = requested;
	}

	public int getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getCampingnum() {
		return campingnum;
	}

	public void setCampingnum(int campingnum) {
		this.campingnum = campingnum;
	}

	public String getCampingname() {
		return campingname;
	}

	public void setCampingname(String campingname) {
		this.campingname = campingname;
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

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getCampingimgurl() {
		return campingimgurl;
	}

	public void setCampingimgurl(String campingimgurl) {
		this.campingimgurl = campingimgurl;
	}

	public int getPostcode() {
		return postcode;
	}

	public void setPostcode(int postcode) {
		this.postcode = postcode;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public int getRoomnum() {
		return roomnum;
	}

	public void setRoomnum(int roomnum) {
		this.roomnum = roomnum;
	}

	public String getRoomname() {
		return roomname;
	}

	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}

	public String getRoomtype() {
		return roomtype;
	}

	public void setRoomtype(String roomtype) {
		this.roomtype = roomtype;
	}

	public String getRoomimg() {
		return roomimg;
	}

	public void setRoomimg(String roomimg) {
		this.roomimg = roomimg;
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

	public String getPaycode() {
		return paycode;
	}

	public void setPaycode(String paycode) {
		this.paycode = paycode;
	}

	public String getPaydetail1() {
		return paydetail1;
	}

	public void setPaydetail1(String paydetail1) {
		this.paydetail1 = paydetail1;
	}

	public String getPaydetail2() {
		return paydetail2;
	}

	public void setPaydetail2(String paydetail2) {
		this.paydetail2 = paydetail2;
	}

	public int getCvc() {
		return cvc;
	}

	public void setCvc(int cvc) {
		this.cvc = cvc;
	}

}
