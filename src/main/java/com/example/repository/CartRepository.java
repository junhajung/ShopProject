package com.example.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;


import com.example.entity.Cart;

public interface CartRepository extends JpaRepository<Cart, Long>{

	List<Cart> findByMember_Memname(String memname);
	
	

	@Transactional  //import javax.transaction.Transactional;
	void deleteById(Long id);


}
