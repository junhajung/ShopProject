package com.example.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "KATEGORIE" )
public class Kategorie {

	@Id
	@Column(name = "KATEID")
	private Long id;
	
	@Column(name = "KATENAME", length=100)
	private String name;

	
	@OneToMany(mappedBy = "kate")
	private List<Product> members = new ArrayList<>();
	
	
	public List<Product> getMembers() {
		return members;
	}

	public void setMembers(List<Product> members) {
		this.members = members;
	}



	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Kategorie(Long id, String name, List<Product> members) {
		super();
		this.id = id;
		this.name = name;
		this.members = members;
	}

	public Kategorie() {
		super();
	}




	
	
}
