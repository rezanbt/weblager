package com.rezanbt.weblager.repository;

import com.rezanbt.weblager.entities.User;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
	User findByUsername(String username);
}