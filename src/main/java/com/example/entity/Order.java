
package com.example.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "ORDERPRODUCT" )
@SequenceGenerator(name = "SEQ", sequenceName = "SEQ_ITEM1_NO",	initialValue = 1,	allocationSize = 1) //생성될 시퀀스명
public class Order {
	
	@Id
	@Column(name = "ORDERID")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator="SEQ")
	Long orderid;
	
	@Column(name = "ORDERCOUNT")
	Long count;
	
	
	@ManyToOne  
    @JoinColumn (name = "PRNAME")
    private Product product;
	
	@ManyToOne  
    @JoinColumn (name = "MEMID")
    private Member member;


	@CreationTimestamp // CURRENT_DATE와 같은 기능
	//@UpdateTimestamp
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSS")
	@Column(name="ORDERDATE")
	private Date date; //import java.util.Date






	public Member getMember() {
		return member;
	}



	public void setMember(Member member) {
		this.member = member;
	}



	public Long getOrderid() {
		return orderid;
	}



	public void setOrderid(Long orderid) {
		this.orderid = orderid;
	}



	public Long getCount() {
		return count;
	}



	public void setCount(Long count) {
		this.count = count;
	}




	public Date getDate() {
		return date;
	}



	public void setDate(Date date) {
		this.date = date;
	}





	public Product getProduct() {
		return product;
	}



	public void setProduct(Product product) {
		this.product = product;
	}



	public Order() {
		super();
		// TODO Auto-generated constructor stub
	}



	public Order(Long orderid, Long count, Product product, Date date) {
		super();
		this.orderid = orderid;
		this.count = count;
		this.product = product;
		this.date = date;
	}










	
	
}
