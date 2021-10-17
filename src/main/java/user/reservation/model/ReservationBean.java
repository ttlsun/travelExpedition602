package user.reservation.model;

import org.hibernate.validator.constraints.NotBlank;

public class ReservationBean {
	
	private int num;
	private int cnum;
	private int rnum;
	private String id;
	private String checkindate;
	private String checkoutdate;
	private String regdate;
	private int guests;
	
	@NotBlank(message = "예약자 성명을 입력하세요.")
	private String name;
	
	@NotBlank(message = "예약자 연락처을 입력하세요.")
	private String phone;
	
	private String email;
	private String requested;
	private int totalprice;
	private String status;
	
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

	@Override
	public String toString() {
		return "ReservationBean [num=" + num + ", cnum=" + cnum + ", rnum=" + rnum + ", id=" + id + ", checkindate="
				+ checkindate + ", checkoutdate=" + checkoutdate + ", regdate=" + regdate + ", guests=" + guests
				+ ", name=" + name + ", phone=" + phone + ", email=" + email + ", requested=" + requested
				+ ", totalprice=" + totalprice + ", status=" + status + "]";
	}
	
	
}
