package com.example.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "QNA" )
@SequenceGenerator(name = "SEQ", sequenceName = "SEQ_ITEM1_NO",	initialValue = 1,	allocationSize = 1) //생성될 시퀀스명
public class QNA {

	@Id
	@Column(name = "QNAID")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator="SEQ")
	Long no;
	
	@Column(name = "QNACONTENT")
	String content;

	@CreationTimestamp // CURRENT_DATE와 같은 기능
	//@UpdateTimestamp
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name="QNADATE")
	private Date date; //import java.util.Date
	
	
	@ManyToOne  
    @JoinColumn (name = "PRNAME")
    private Product product;
	
	@ManyToOne  
    @JoinColumn (name = "MEMID") //memname
    private Member member;


	public Long getNo() {
		return no;
	}

	public void setNo(Long no) {
		this.no = no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}


	public QNA() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "QNA [no=" + no + ", content=" + content + ", date=" + date + ", product=" + product + ", member="
				+ member + "]";
	}


	
	
}
