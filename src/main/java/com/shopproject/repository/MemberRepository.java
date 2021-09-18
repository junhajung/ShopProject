package com.shopproject.repository;
import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.shopproject.entity.Member;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {

	
	@Query(value="SELECT * FROM MEMBER WHERE MEMID=? AND MEMPW =?" , nativeQuery = true)
	Member findAllByIdAndPw(String id, String pw);

	Member findByMemname(String nameString);
	

	@Transactional  //import javax.transaction.Transactional;
	void deleteByName(String no);
}
