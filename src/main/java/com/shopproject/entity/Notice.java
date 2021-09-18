package com.shopproject.entity;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "NOTICE" )
@SequenceGenerator(name = "SEQ", sequenceName = "SEQ_ITEM1_NO",	initialValue = 1,	allocationSize = 1) //생성될 시퀀스명
public class Notice {
	
	@Id
	@Column(name = "NOTICEID")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator="SEQ")
	private Long no;

	@Column(name = "NOTICETITLE")
	private String title;
	
	@Column(name = "NOTICECONTNET", length=4000)
	private String content;

	@CreationTimestamp // CURRENT_DATE와 같은 기능
	//@UpdateTimestamp
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Column(name="NOTICEDATE")
	private Date date; //import java.util.Date
	
	
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	

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

	public Notice() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
}
