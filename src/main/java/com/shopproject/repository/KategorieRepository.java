package com.shopproject.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shopproject.entity.Kategorie;


@Repository
public interface KategorieRepository  extends JpaRepository<Kategorie, Long> {
	List<Kategorie> findAllById(Long id);
	
	
	
	
}
