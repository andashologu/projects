package com.kapelle.inc.tradezonemarket.Chat.Events;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.kapelle.inc.tradezonemarket.Chat.Model.ChatMessage;

@Component
public class WebSocketEventListener {

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;
    
    @EventListener
    public void handleWebSocketConnectedListener(SessionConnectedEvent event) {
        Principal user = event.getUser();
        if(user != null) {
            String username = user.getName();
            ChatMessage message = new ChatMessage();
            message.setText(username+" connected");
            messagingTemplate.convertAndSend("/topic/friend/"+username, message);
            System.out.println(username+" connected");
        }
    }
    
    @EventListener
    public void handleWebSocketDisconnectListener( SessionDisconnectEvent event) {
        Principal user = event.getUser();
        if(user != null) {
            String username = user.getName();
            ChatMessage message = new ChatMessage();
            message.setText(username+" disconnected");
            messagingTemplate.convertAndSend("/topic/friend/"+username, message);
        }
    }
    
}
