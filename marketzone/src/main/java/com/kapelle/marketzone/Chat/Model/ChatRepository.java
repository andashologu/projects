package com.kapelle.marketzone.Chat.Model;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.kapelle.marketzone.authentication.user.Model.UserEntity;

public interface ChatRepository extends JpaRepository<ChatEntity, Long> {

    List<ChatEntity> findAll();

    @Query(value = "select chat from ChatEntity chat where :contact in (chat.recipient, chat.sender) and :currentuser in (chat.recipient, chat.sender) order by chat.datetime desc")
    Slice<ChatEntity> findBySenderOrRecipient(UserEntity contact, UserEntity currentuser, Pageable page);

    @Query(value = "select chat from ChatEntity chat where :contact in (chat.recipient, chat.sender) and :currentuser in (chat.recipient, chat.sender) order by chat.datetime desc")
    List<ChatEntity> findAllBySenderOrRecipient(UserEntity contact, UserEntity currentuser, Pageable page);

    @Query(value = "select chat as contacts from ChatEntity chat where chat.id in ("
                                +"select max(chat.id) from ChatEntity chat group by chat.usersId)"
                                    +"and :user in (chat.recipient, chat.sender) order by chat.datetime desc")
    Slice<ChatEntity> findContacts(UserEntity user, Pageable page);
}