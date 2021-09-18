package com.shopproject.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.shopproject.entity.Order;


public interface OrderRepository extends JpaRepository<Order, Long>{
	
	@Query(value="SELECT * FROM ORDERPRODUCT WHERE ORDERNAME=?" , nativeQuery = true)
	List<Order> findAllByName(String name);
	
	List<Order> findByMember_Memname(String memname);
	
	
}
