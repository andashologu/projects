package com.kapelles.inc.TZm.chat.events;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.kapelles.inc.TZm.chat.model.ChatEntity;
import com.kapelles.inc.TZm.chat.model.ChatMessage;
import com.kapelles.inc.TZm.chat.model.ChatRepository;
import com.kapelles.inc.TZm.chat.model.Status;
import com.kapelles.inc.TZm.authentication.user.model.UserEntity;
import com.kapelles.inc.TZm.authentication.user.model.UserRepository;

@Component
public class WebSocketEventListener {

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;

    @Autowired 
    ChatRepository chatRepository;

    @Autowired 
    UserRepository userRepository;
    
    @EventListener
    public void handleWebSocketConnectedListener(SessionConnectedEvent event) {
        Principal user = event.getUser();
        if(user != null){
            UserEntity currentuser = userRepository.findByUsername(user.getName());
            messagingTemplate.convertAndSend("/topic/friend/"+currentuser.getId(), new Status().new Online(currentuser.getId(), "Available"));
            List<ChatEntity> messagesList =  chatRepository.findByRecipient(currentuser, Status.Message.Sent);
            for(ChatEntity chat: messagesList) {
                chat.setStatus(Status.Message.Delivered);
                messagingTemplate.convertAndSendToUser(chat.getSender().getUsername(), "/queue/messagestatus", new ChatMessage(chat.getId(), null, chat.getRecipient().getId(), null, null, Status.Message.Delivered, null));
            }
        }
    }
    
    @EventListener
    public void handleWebSocketDisconnectListener( SessionDisconnectEvent event) {
        Principal user = event.getUser();
        if(user != null){
            UserEntity currentuser = userRepository.findByUsername(user.getName());
            messagingTemplate.convertAndSend("/topic/friend/"+currentuser.getId(), new Status().new Online(currentuser.getId(), "Away"));
        }
    }
}
