package com.kapelle.inc.tradezonemarket.Chat.Model;

public class Status {

    public enum Message {
        Sent, Delivered, Seen;
    }


    public class Online {

        private Long userId;
        private String status;

        public Online(Long userId, String status) {
            this.userId = userId;
            this.status = status;
        }

        public Long getId() {
            return userId;
        }
        public void setId(Long id) {
            this.userId = id;
        }

        public String getStatus() {
            return status;
        }
        public void setStatus(String status) {
            this.status = status;
        }
    
        @Override
        public String toString() {
            return "Status{" +
                    "userId='" + userId +
                    "status="+ status +
                    "'}";
        }

    }

    public class Typing {

        private Long userId;
        private Boolean isTyping;

        public Typing(Long userId, Boolean isTyping) {
            this.userId = userId;
            this.isTyping = isTyping;
        }

        public Long getId() {
            return userId;
        }
        public void setId(Long id) {
            this.userId = id;
        }

        public Boolean getStatus() {
            return isTyping;
        }
        public void setStatus(Boolean isTyping) {
            this.isTyping = isTyping;
        }
        
        @Override
        public String toString() {
            return "Status{" +
                    "userId='" + userId +
                    "isTyping="+ isTyping +
                    "'}";
        }

    }
}
