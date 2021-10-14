package user.pay.model;

public class PayBean {
	private int num; //pk
	private String id; //20, not null, fk(users.id)
	private String paycode; //20, not null
	private String paydetail1; //30, not null
	private String paydetail2; //20, null
	private int cvc;
	private String regdate; //sysdate
	private String moddate;
	private String modid; //20
	
	
	public PayBean() {
		super();
	}
	public PayBean(int num, String id, String paycode, String paydetail1, String paydetail2, int cvc, String regdate,
			String moddate, String modid) {
		super();
		this.num = num;
		this.id = id;
		this.paycode = paycode;
		this.paydetail1 = paydetail1;
		this.paydetail2 = paydetail2;
		this.cvc = cvc;
		this.regdate = regdate;
		this.moddate = moddate;
		this.modid = modid;
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
}
