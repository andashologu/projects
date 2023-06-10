package com.kapelle.inc.tradezonemarket.Chat.Model;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Collection;

import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.TimeZoneStorage;
import org.hibernate.type.SqlTypes;

import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserEntity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "chats")
public class ChatEntity {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    public Long id;

    @Column(name = "users_id")
    public Long usersId;

    //@OneToOne(cascade = CascadeType.MERGE)
    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "sender_id", referencedColumnName = "id", nullable = false)
    public UserEntity sender;
    
    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "recipient_id", referencedColumnName = "id", nullable = false)
    public UserEntity recipient;

    @ManyToOne
    @JoinColumn(name = "replied_id", referencedColumnName = "id")
    public ChatEntity replied;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "replied", orphanRemoval = true)
    public Collection<ChatEntity> repliedChats = new ArrayList<ChatEntity>();

    @JdbcTypeCode(SqlTypes.LONGVARCHAR)/*for long text storage. But please specify max size for this field in js and html */
    @NotNull
    public String message;

    public String image;

    @Enumerated(EnumType.ORDINAL)
    public Status status;

    @TimeZoneStorage
    ZonedDateTime datetime;

    public ChatEntity() {}

    public ChatEntity(Long usersId, UserEntity sender, UserEntity recipient, ChatEntity replied, String message, String image, Status status, ZonedDateTime datetime){
        this.usersId = usersId;
        this.sender = sender;
        this.recipient = recipient;
        this.replied = replied;
        this.message = message;
        this.image = image;
        this.status = status;
        this.datetime = datetime;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public Long getUsersid() {
        return usersId;
    }
    public void setUsersid() {
        this.usersId = sender.getId()+recipient.getId();
    }

    public UserEntity getSender() {
        return sender;
    }
    public void setSender(UserEntity sender) {
        this.sender = sender;
    }
    
    public UserEntity getRecipient() {
        return recipient;
    }
    public void setRecipient(UserEntity recipient) {
        this.recipient = recipient;
    }

    public ChatEntity getReplied() {
        return replied;
    }
    public void setReplied(ChatEntity replied) {
        this.replied = replied;
    }

    public Collection<ChatEntity> getRepliedchats() {
        return repliedChats;
    }
    public void setRepliedchats(Collection<ChatEntity> repliedChats) {
        this.repliedChats = repliedChats;

    }

    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }

    public Status getStatus() {
        return status;
    }
    public void setStatus(Status status) {
        this.status = status;
    }

    public ZonedDateTime getDatetime() {
        return datetime;
    }
    public void setDatetime(ZonedDateTime datetime) {
        this.datetime = datetime;
    }
    
    @Override
    public String toString() {
        return "Message{" +
                "id='" + id +
                "usersId="+ usersId +
                "', sender='" + sender.username +
                "', recipient='" + recipient.username +
                "', replied="+ replied.message +
                "', repliedMessages='"+ repliedChats +
                ", imageLink="+ image +
                "', text='" + message +
                "', status='" + status +
                "', datetime='" + datetime +
                "'}";
    }
}
