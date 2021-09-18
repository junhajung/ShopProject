package com.shopproject.repository;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.shopproject.entity.Notice;



public interface NoticeRepository extends JpaRepository<Notice, Long>{
	@Transactional  //import javax.transaction.Transactional;
	void deleteById(Long id);
	
	
	@Query(value="SELECT * FROM NOTICE WHERE NOTICEID=?" , nativeQuery = true)
	Notice findAllById(Long no);
	
	List<Notice> findAllByTitleIgnoreCaseContainingOrderByNoDesc(String txt, Pageable pageable);
	
	long countByTitleIgnoreCaseContaining(String txt);
	

}
