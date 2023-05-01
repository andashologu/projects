package com.kapelle.propertycheck.chat.Model;

import java.sql.Date;
import java.sql.Time;

import com.kapelle.propertycheck.authentication.user.Model.UserEntity;

import jakarta.persistence.Basic;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "chats")
public class ChatEntity{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    public Long id;

    @OneToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "sender_id", referencedColumnName = "id")
    public UserEntity sender;
    
    @OneToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "recipient_id", referencedColumnName = "id")
    public UserEntity recipient;

    @Column(name = "message", columnDefinition = "varchar(500)")
    public String message;

    @Basic
    Date date;

    @Basic
    Time time;

    public ChatEntity(){
    }
    public ChatEntity(UserEntity sender, UserEntity recipient, String message, Date date, Time time){
        this.sender = sender;
        this.recipient = recipient;
        this.message = message;
        this.date = date;
        this.time = time;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
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

    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }

    public Date  getDate() {
        return date;
    }
    public void setDate(Date date) {
        this.date = date;
    }

    public Time getTime() {
        return time;
    }
    public void setTime(Time time) {
        this.time = time;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "id='" + id +
                "', sender='" + sender.username +
                "', recipient='" + recipient.username +
                "', message='" + message +
                "', date='" + date +
                "', time='" + time +

                "'}";
    }
}
