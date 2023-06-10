package com.kapelle.inc.tradezonemarket.Chat.Model;

public class ChatMessage {
    
    private String text;

    private String to;

    private String date;

    private String time;

    private String timezone;

    public ChatMessage() {}

    public ChatMessage(String text, String to, String date, String time, String timezone) {
        this.text = text;
        this.to = to;
        this.date = date;
        this.time = time;
        this.timezone = timezone;
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

    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }
    public void setTime(String time) {
        this.time = time;
    }

    public String getTimezone() {
        return timezone;
    }
    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }

    @Override
    public String toString() {
        return "Chat{" +
                "text='" + text +
                "', to='" + to +
                "', date='" + date +
                "', time='" + time +
                "', timezone='" + timezone +
                "'}";
    }
}