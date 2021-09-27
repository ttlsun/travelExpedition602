package com.my.travelExpedition.model;

public class AddrBean {

	private String no;
	private String code;
	private String name;

	public AddrBean() {
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "AjaxApiAddrBean [no=" + no + ", code=" + code + ", name=" + name + "]";
	}

}
