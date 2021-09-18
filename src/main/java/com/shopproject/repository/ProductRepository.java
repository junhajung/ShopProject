package com.shopproject.repository;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.shopproject.entity.Product;

@Repository
public interface ProductRepository  extends JpaRepository<Product, String>{
	

	// SELECT * FROM PRODUCT WHERE NAME = ?
	@Query(value="SELECT * FROM PRODUCT WHERE PRNAME=?" , nativeQuery = true)
	Product findByName(String name);

	// SELECT * FROM PRODUCT WHERE NAME = ?
	@Query(value="SELECT * FROM PRODUCT WHERE PRNAME=?" , nativeQuery = true)
	List<Product> findAllByName(String[] prname);
	
	List<Product> findAllByNameIgnoreCaseContaining(String txt);

//	List<Product> findAllByIdIgnoreCaseContaining(Long id);
	
	@Query(value="SELECT * FROM PRODUCT WHERE KATEID=?" , nativeQuery = true)
	List<Product> findAllByKate(int i);
	
	
	List<Product> findByMember_Memname(String memname);
	

	@Transactional  //import javax.transaction.Transactional;
	void deleteByName(String name);


}
