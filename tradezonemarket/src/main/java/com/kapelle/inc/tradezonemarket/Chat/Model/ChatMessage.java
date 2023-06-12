package com.kapelle.inc.tradezonemarket.Chat.Model;

public class ChatMessage {

    private Long recipientId;
    
    private String text;

    private String to;

    private Boolean isTyping;

    public ChatMessage() {}

    public ChatMessage(Long recipientId, String text, String to, Boolean isTyping) {
        this.recipientId = recipientId;
        this.text = text;
        this.to = to;
        this.isTyping = isTyping;
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

    public Boolean isTyping() {
        return isTyping;
    }
    public void setTyping(Boolean isTyping) {
        this.isTyping = isTyping;
    }

    @Override
    public String toString() {
        return "Chat{" +
                "recipientId'"+ recipientId+
                "', text='" + text +
                "', to='" + to +
                "', isTyping='"+ isTyping +
                "'}";
    }
}