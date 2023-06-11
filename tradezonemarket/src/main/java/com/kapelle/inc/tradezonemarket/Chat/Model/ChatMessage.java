package com.kapelle.inc.tradezonemarket.Chat.Model;

public class ChatMessage {
    
    private String text;

    private String to;

    private Boolean isTyping;

    public ChatMessage() {}

    public ChatMessage(String text, String to, Boolean isTyping) {
        this.text = text;
        this.to = to;
        this.isTyping = isTyping;
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
                "text='" + text +
                "', to='" + to +
                "', isTyping='"+ isTyping +
                "'}";
    }
}