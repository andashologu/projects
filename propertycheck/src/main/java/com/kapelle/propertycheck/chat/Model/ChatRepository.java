package com.kapelle.propertycheck.Chat.Model;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ChatRepository extends JpaRepository<ChatEntity, Long> {
    String findBySender(String sender);
    String findByRecipient(String recipient); 
}

