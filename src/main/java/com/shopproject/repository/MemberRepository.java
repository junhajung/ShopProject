package com.example.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.entity.Member;
import com.example.entity.Product;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {

	
	@Query(value="SELECT * FROM MEMBER WHERE MEMID=? AND MEMPW =?" , nativeQuery = true)
	Member findAllByIdAndPw(String id, String pw);

	Member findByMemname(String nameString);
	

	@Transactional  //import javax.transaction.Transactional;
	void deleteByName(String no);
}
