package com.shopproject.security;


import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class MyUser extends User{
	
	// 추가할 변수명
	private String name = null;
	private String memname = null; // id
	private String mempassword = null; // pw

	
	// id, pw, 권한, 이름
	public MyUser(String username, String mempassword, Collection<? extends GrantedAuthority> authorities, String name) {
		super(username, mempassword, authorities);
		this.memname = username; //id
		this.mempassword = mempassword; //pw
		this.name = name; //name 
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


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



	

}
