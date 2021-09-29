package user.room.model;

public class RoomBean {
	
	private int num;
	private String name;
	private String room_type;
	private int cnum;
	private String cname;
	private String imgurl;
	private int postingnum;
	private String contents;
	private int propguests;
	private int maxguests;
	private int weekdayprice;
	private int weekendprice;
	private String options;
	private String amenity;
	private String bookabledate;
	private String regdate;
	private String regid;
	private String moddate;
	private String modid;
	
	public RoomBean() {
		super();
	}

	public RoomBean(int num, String name, String room_type, int cnum, String cname, String imgurl, int postingnum,
			String contents, int propguests, int maxguests, int weekdayprice, int weekendprice, String options,
			String amenity, String bookabledate, String regdate, String regid, String moddate, String modid) {
		super();
		this.num = num;
		this.name = name;
		this.room_type = room_type;
		this.cnum = cnum;
		this.cname = cname;
		this.imgurl = imgurl;
		this.postingnum = postingnum;
		this.contents = contents;
		this.propguests = propguests;
		this.maxguests = maxguests;
		this.weekdayprice = weekdayprice;
		this.weekendprice = weekendprice;
		this.options = options;
		this.amenity = amenity;
		this.bookabledate = bookabledate;
		this.regdate = regdate;
		this.regid = regid;
		this.moddate = moddate;
		this.modid = modid;
	}

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

	public String getRoom_type() {
		return room_type;
	}

	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}

	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getImgurl() {
		return imgurl;
	}

	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}

	public int getPostingnum() {
		return postingnum;
	}

	public void setPostingnum(int postingnum) {
		this.postingnum = postingnum;
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

	public String getBookabledate() {
		return bookabledate;
	}

	public void setBookabledate(String bookabledate) {
		this.bookabledate = bookabledate;
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
	
	
}
