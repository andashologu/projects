package com.kapelle.propertycheck.Chat.Model;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.kapelle.propertycheck.authentication.user.Model.UserEntity;

public interface ChatRepository extends JpaRepository<ChatEntity, Long> {

    List<ChatEntity> findAll();

    @Query(value = "select chat from ChatEntity chat where :sender in (chat.recipient, chat.sender) and :recipient in (chat.recipient, chat.sender)")
    List<ChatEntity> findBySenderAndRecipient(UserEntity sender, UserEntity recipient);

    @Query(value = "select chat as contacts from ChatEntity chat where chat.id in ("
                                +"select max(chat.id) from ChatEntity chat group by chat.usersId)"
                                    +"and :user in (chat.recipient, chat.sender)")
    List<ChatEntity> findContacts(UserEntity user);
}