package com.kapelles.inc.TZm.authentication.user.model;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
    Optional<UserEntity> findById(Long id);
    UserEntity findByUsername(String username);
    UserEntity findByEmailIgnoreCase(String email);
    UserEntity findByUsernameIgnoreCase(String username);
}