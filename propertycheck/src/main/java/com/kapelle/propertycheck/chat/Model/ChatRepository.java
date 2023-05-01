package com.kapelle.propertycheck.chat.Model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author anda
 */
@Repository
public interface ChatRepository extends JpaRepository<ChatEntity, Long> {
    String findBySender(String sender);
    String findByRecipient(String recipient); 
}

