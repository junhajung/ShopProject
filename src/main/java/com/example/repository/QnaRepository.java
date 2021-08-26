package com.example.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;



import com.example.entity.QNA;



public interface QnaRepository  extends JpaRepository<QNA, Long>{
	
	List<QNA> findByMember_Memname(String memname);
	
	List<QNA> findByProduct_Name(String name);
	
	@Transactional  //import javax.transaction.Transactional;
	void deleteById(Long no);
}
