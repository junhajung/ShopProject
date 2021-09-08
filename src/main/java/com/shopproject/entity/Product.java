package com.example.entity;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "PRODUCT" )
public class Product {


	@Id
	@Column(name = "PRNAME", length=100)
	private String name;
	
	//이미지

	@Lob
	@Column(name = "PRIMG")
	public byte[] img;

	@Column(name = "PRICE")
	private Long price;
	
	@Column(name = "CONTENTS", length=500)
	private String contents;


	@ManyToOne  
    @JoinColumn (name = "KATEID")
    private Kategorie kate;

	@ManyToOne  
    @JoinColumn (name = "MEMID")
    private Member member;
	
	//등록일자 ITMDATE, DATE
	@CreationTimestamp // CURRENT_DATE와 같은 기능
	//@UpdateTimestamp
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSS")
	@Column(name="PRDATE")
	private Date date; //import java.util.Date






	public Member getMember() {
		return member;
	}


	public void setMember(Member member) {
		this.member = member;
	}


	public Kategorie getKate() {
		return kate;
	}


	public void setKate(Kategorie kate) {
		this.kate = kate;
	}


	public Long getPrice() {
		return price;
	}


	public void setPrice(Long price) {
		this.price = price;
	}


	public String getContents() {
		return contents;
	}


	public void setContents(String contents) {
		this.contents = contents;
	}


	// byte[] => base 64 string으로 변경해서 보관할 변수
	@Transient // 컬럼생성하지 않음
	private String base64;


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public byte[] getImg() {
		return img;
	}


	public void setImg(byte[] img) {
		this.img = img;
	}


	public Date getDate() {
		return date;
	}


	public void setDate(Date date) {
		this.date = date;
	}


	public String getBase64() {
		return base64;
	}


	public void setBase64(String base64) {
		this.base64 = base64;
	}


	@Override
	public String toString() {
		return "Product [name=" + name + ", img=" + Arrays.toString(img) + ", price=" + price + ", contents=" + contents
				+ ", date=" + date + ", base64=" + base64 + "]";
	}






	


	
}



	
