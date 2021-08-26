package com.example.entity;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;


import org.hibernate.annotations.CreationTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "MEMBER" )
public class Member {


	@Id
	@Column(name = "MEMID", length=20)
	private String memname;


	@Column(name = "MEMPW", length=200)
	private String mempassword;
	
	@Column(name = "MEMNAME", length=20)
	private String name;
	

	@Column(name = "MEMEMAIL", length=200)
	private String email;
	

	@Column(name = "MEMZIPNUM", length=500)
	private String zip_num;
	
	@Column(name = "MEMADDRESS1", length=500)
	private String address1;
	
	@Column(name = "MEMADDRESS2", length=500)
	private String address2;
	
	@Column(name = "MEMPHONE", length=200)
	private String phone;
	
	@Column(name = "MEMROLE", length=200)
	private String role;	
	
	@OneToMany(mappedBy = "member", cascade=CascadeType.REMOVE)
	private List<Cart> cart = new ArrayList<>();
	
	@OneToMany(mappedBy = "member", cascade=CascadeType.REMOVE)
	private List<Order> order = new ArrayList<>();
	
	@OneToMany(mappedBy = "member", cascade=CascadeType.REMOVE)
	private List<QNA> qna = new ArrayList<>();
	
	
	public String getRole() {
		return role;
	}




	public void setRole(String role) {
		this.role = role;
	}




	//등록일자 ITMDATE, DATE
	@CreationTimestamp // CURRENT_DATE와 같은 기능
	//@UpdateTimestamp
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSS")
	@Column(name="MEMDATE")
	private Date date; //import java.util.Date




	public String getMemname() {
		return memname;
	}




	public void setMemname(String memname) {
		this.memname = memname;
	}




	public String getMempassword() {
		return mempassword;
	}




	public void setMempassword(String mempassword) {
		this.mempassword = mempassword;
	}




	public String getName() {
		return name;
	}




	public void setName(String name) {
		this.name = name;
	}




	public String getEmail() {
		return email;
	}




	public void setEmail(String email) {
		this.email = email;
	}






	public String getZip_num() {
		return zip_num;
	}




	public void setZip_num(String zip_num) {
		this.zip_num = zip_num;
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




	public String getPhone() {
		return phone;
	}




	public void setPhone(String phone) {
		this.phone = phone;
	}




	public Date getDate() {
		return date;
	}




	public void setDate(Date date) {
		this.date = date;
	}







	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}




	
	
}



	
