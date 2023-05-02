package com.kapelle.propertycheck.Chat.Controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kapelle.propertycheck.authentication.user.Model.UserEntity;
import com.kapelle.propertycheck.authentication.user.Model.UserRepository;
import com.kapelle.propertycheck.Chat.Model.ChatMessage;
import com.kapelle.propertycheck.Chat.Model.ChatEntity;
import com.kapelle.propertycheck.Chat.Model.ChatRepository;

@Controller
public class ChatController {

    @Autowired
    SimpMessagingTemplate simpMessagingTemplate;

    @Autowired 
    ChatRepository chatRepository;

    @Autowired 
    UserRepository userRepository;

    @GetMapping("/chat")
    public String index(){
        return "chat/index";
    }

    // Mapped as /app/all
    @MessageMapping("/all")
    @SendTo("/topic/messages")
    public ChatMessage send(final ChatMessage message) throws Exception {
        return message;
    }

    // Mapped as /app/specific
    @MessageMapping("/specific")
    public void sendToSpecificUser(@Payload ChatMessage message, Principal user) throws UsernameNotFoundException{
        System.out.println("username of send with email login in: "+user.getName());//must test !!!
        UserEntity sender = userRepository.findByUsernameIgnoreCase(user.getName());
        UserEntity recipient = userRepository.findByUsernameIgnoreCase(message.getTo());
        if(sender != null | recipient != null){
            ChatEntity chat = new ChatEntity(sender, recipient, message.getText(), null, null);
            chatRepository.save(chat);
            simpMessagingTemplate.convertAndSendToUser(message.getTo(), "/queue/reply", message);
        }
        else{
            throw new UsernameNotFoundException("Sender or Recipient could not be found !!!");
        }
    }

    //Mapped as /app/typing/{status}
   /*  @MessageMapping("/specific/{userId}")
    public void sendToSpecificUser(@DestinationVariable String userId, Principal user) {

        simpMessagingTemplate.convertAndSendToUser(chat.getRecipient().getUsername(), "/specific", "");
        //Must get a boolean true if user is typing or false of not....
        //And send the status to specific user...
    }*/
}