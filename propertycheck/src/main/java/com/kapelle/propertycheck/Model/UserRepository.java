package com.kapelle.propertycheck.Model;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
    UserEntity findByUsername(String username);
    UserEntity findByEmailIgnoreCase(String email);
    UserEntity findByUsernameIgnoreCase(String username);
}