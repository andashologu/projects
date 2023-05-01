package com.kapelle.propertycheck.chat.Events;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;
import org.springframework.web.socket.messaging.SessionSubscribeEvent;
import org.springframework.web.socket.messaging.SessionUnsubscribeEvent;

import com.kapelle.propertycheck.chat.Model.ChatEntity;

@Component
public class WebSocketEventListener {

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;
    
    @EventListener
    public void handleWebSocketConnectedListener(SessionConnectedEvent event) {
        Principal user = event.getUser();
        if(user != null){
            String username = user.getName();
            /*
             * Check baeldung website example of how to keep track of logged users in java arraylist
             * 
             */
        }
    }
    
    @EventListener
    public void handleWebSocketDisconnectListener( SessionDisconnectEvent event) {
        Principal user = event.getUser();
        if(user != null){
            String username = user.getName();
            /*
             * 
             * 
             */
        }
    }
    
}
