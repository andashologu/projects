package com.kapelle.inc.tradezonemarket.Chat.Model;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.kapelle.inc.tradezonemarket.Chat.Model.Status.Message;
import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserEntity;

public interface ChatRepository extends JpaRepository<ChatEntity, Long> {

    List<ChatEntity> findAll();

    @Query(value = "select chat from ChatEntity chat where :contact in (chat.recipient, chat.sender) and :currentuser in (chat.recipient, chat.sender) order by chat.datetime desc")
    Slice<ChatEntity> findBySenderOrRecipient(UserEntity contact, UserEntity currentuser, Pageable page);

    @Query(value = "select chat from ChatEntity chat where chat.id <= :initialId and :contact in (chat.recipient, chat.sender) and :currentuser in (chat.recipient, chat.sender) order by chat.datetime desc")
    Slice<ChatEntity> findBySenderOrRecipient(Long initialId, UserEntity contact, UserEntity currentuser, Pageable page);

    @Query(value = "select chat from ChatEntity chat where :currentuser = chat.recipient and chat.status = :status")
    List<ChatEntity> findByRecipient(UserEntity currentuser, Message status);


    @Query(value = "select chat as contacts from ChatEntity chat where chat.id in ("
                                +"select max(chat.id) from ChatEntity chat group by chat.usersId)"
                                    +"and :user in (chat.recipient, chat.sender) order by chat.datetime desc")
    Slice<ChatEntity> findContacts(UserEntity user, Pageable page);
}