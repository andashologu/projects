package com.kapelle.inc.tradezonemarket.Chat.Model;

import com.kapelle.inc.tradezonemarket.Chat.Model.Status.Message;

public class ChatMessage {

    private Long messageId;

    private Long senderId;

    private Long recipientId;
    
    private String text;

    private String to;

    private Message status;

    private Boolean isTyping;

    public ChatMessage() {}

    public ChatMessage(Long messageId, Long senderId, Long recipientId, String text, String to, Message status, Boolean isTyping) {
        this.messageId = messageId;
        this.senderId = senderId;
        this.recipientId = recipientId;
        this.text = text;
        this.to = to;
        this.status = status;
        this.isTyping = isTyping;
    }

    public Long getMessageId(){
        return messageId;
    }
    public void setMessageId(Long messageId) {
        this.messageId = messageId;
    }

    public Long getSenderId(){
        return senderId;
    }
    public void setSenderId(Long senderId) {
        this.senderId = senderId;
    }

    public Long getRecipientId(){
        return recipientId;
    }
    public void setRecipientId(Long recipientId) {
        this.recipientId = recipientId;
    }

    public String getText(){
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }

    public String getTo() {
        return to;
    }
    public void setTo(String to) {
        this.to = to;
    }
    
    public Message getStatus() {
        return status;
    }
    public void setStatus(Message status) {
        this.status = status;
    }

    public Boolean isTyping() {
        return isTyping;
    }
    public void setTyping(Boolean isTyping) {
        this.isTyping = isTyping;
    }

    @Override
    public String toString() {
        return "Message{" +
                "messageId='"+ messageId +
                "senderId='"+ senderId +
                "', recipientId='"+ recipientId +
                "', text='" + text +
                "', to='" + to +
                "', status='" + status +
                "', isTyping='"+ isTyping +
                "'}";
    }
}