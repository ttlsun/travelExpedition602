package user.reservation.model;

public class ReservationBean {

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
	
	public ReservationBean() {
		super();
	}

	public ReservationBean(int num, int cnum, int rnum, String id, String checkindate, String checkoutdate, String regdate, int guests,
			String name, String phone, String email, String requested, int totalprice, String status) {
		super();
		this.num = num;
		this.cnum = cnum;
		this.rnum = rnum;
		this.id = id;
		this.checkindate = checkindate;
		this.checkoutdate = checkoutdate;
		this.regdate = regdate;
		this.guests = guests;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.requested = requested;
		this.totalprice = totalprice;
		this.status = status;
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
	
}
