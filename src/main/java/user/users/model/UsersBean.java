package user.users.model;

public class UsersBean {
	private int num; //pk
	private String ucode; //20, not null
	private String id; //20, unique, not null
	private String pw; //20, not null
	private String name; //40, not null
	private String gender; //10
	private String email; //30, unique, not null
	private String birth; //sysdate
	private int postcode;
	private String address1; //150, not null
	private String address2; //150, not null
	private String address3; //150, not null
	private String address4; //150, not null
	private String contact; //30, not null
	private String regdate; //sysdate
	private String moddate;
	private String modid;
	private String status; //not null
	
	public UsersBean() {
		super();
	}
	public UsersBean(int num, String ucode, String id, String pw, String name, String gender, String email,
			String birth, int postcode, String address1, String address2, String address3, String address4,
			String contact, String regdate, String moddate, String modid, String status) {
		super();
		this.num = num;
		this.ucode = ucode;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.gender = gender;
		this.email = email;
		this.birth = birth;
		this.postcode = postcode;
		this.address1 = address1;
		this.address2 = address2;
		this.address3 = address3;
		this.address4 = address4;
		this.contact = contact;
		this.regdate = regdate;
		this.moddate = moddate;
		this.modid = modid;
		this.status = status;
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	
	public String getUcode() {
		return ucode;
	}
	public void setUcode(String ucode) {
		this.ucode = ucode;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
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
}
