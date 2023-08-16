package com.kapelles.inc.TZm.Chat.Events;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.messaging.SessionConnectedEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import com.kapelles.inc.TZm.Chat.Model.ChatEntity;
import com.kapelles.inc.TZm.Chat.Model.ChatMessage;
import com.kapelles.inc.TZm.Chat.Model.ChatRepository;
import com.kapelles.inc.TZm.Chat.Model.Status;
import com.kapelles.inc.TZm.authentication.user.Model.UserEntity;
import com.kapelles.inc.TZm.authentication.user.Model.UserRepository;

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
