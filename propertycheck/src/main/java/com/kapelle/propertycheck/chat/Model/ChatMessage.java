package com.kapelle.propertycheck.chat.Model;

public class ChatMessage {
    
    private String text;

    private String to;

    public String getText() {
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
}