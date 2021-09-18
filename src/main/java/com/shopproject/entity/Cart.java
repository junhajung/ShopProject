package com.shopproject.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "CART" )
@SequenceGenerator(name = "SEQ", sequenceName = "SEQ_ITEM1_NO",	initialValue = 1,	allocationSize = 1) //생성될 시퀀스명
public class Cart {
	@Id
	@Column(name = "CARTID")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator="SEQ")
	Long cartid;
	
	@Column(name = "CARTCOUNT")
	Long count;
	
	
	@ManyToOne  
    @JoinColumn (name = "PRNAME")
    private Product product;
	
	@ManyToOne  
    @JoinColumn (name = "MEMID")
    private Member member;




	public Long getCartid() {
		return cartid;
	}

	public void setCartid(Long cartid) {
		this.cartid = cartid;
	}

	public Long getCount() {
		return count;
	}

	public void setCount(Long count) {
		this.count = count;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}




	public Cart(Long cartid, Long count, Product product, Member member) {
		super();
		this.cartid = cartid;
		this.count = count;
		this.product = product;
		this.member = member;
	}

	public Cart() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
