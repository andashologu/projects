package com.kapelle.inc.tradezonemarket.Chat.Controller;

import java.security.Principal;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kapelle.inc.tradezonemarket.Chat.Model.ChatEntity;
import com.kapelle.inc.tradezonemarket.Chat.Model.ChatMessage;
import com.kapelle.inc.tradezonemarket.Chat.Model.ChatRepository;
import com.kapelle.inc.tradezonemarket.Chat.Model.Status;
import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserEntity;
import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserRepository;

@Controller
public class WebSocketControllerTest {

    @Autowired
    SimpMessagingTemplate simpMessagingTemplate;

    @Autowired 
    ChatRepository chatRepository;

    @Autowired 
    UserRepository userRepository;

    @GetMapping("/chat/test")
    public String test(){
        return "chat/justpage";
    }

    // Mapped as /app/all
    @MessageMapping("/all/test")
    @SendTo("/topic/messages/test")
    public ChatMessage send(final ChatMessage message) throws Exception {
        return message;
    }

    @PostMapping("/chat/sendmessage/test")
    @ResponseBody //temporal... just to avoid jsp errors
    public String sendToSpecificUser(@Payload ChatMessage message, Principal user, TimeZone timezone) throws UsernameNotFoundException {
        System.out.println("Message: "+message);
        UserEntity sender = userRepository.findByUsernameIgnoreCase(user.getName());
        UserEntity recipient = userRepository.findByUsernameIgnoreCase(message.getTo());
        if(sender != null & recipient != null) {
            ZonedDateTime serverDateTime = ZonedDateTime.now();
            ZoneId clientTimeZone = timezone.toZoneId();
            ZonedDateTime clientDateTime = serverDateTime.withZoneSameInstant(clientTimeZone);
            ChatEntity chat = new ChatEntity(null,sender, recipient, null, message.getText(), null, Status.Message.Sent, clientDateTime);
            chat.setUsersid();
            chatRepository.save(chat);
            simpMessagingTemplate.convertAndSendToUser(message.getTo(), "/queue/reply/test", message);
        } else {
            throw new UsernameNotFoundException("Sender or Recipient could not be found !!!");
        }
        return "chat/components/messages";
    }

    // Mapped as /app/specific
    /*@MessageMapping("/specific")
    public void sendToSpecificUser(@Payload ChatMessage message, Principal user) throws UsernameNotFoundException {
        UserEntity sender = userRepository.findByUsernameIgnoreCase(user.getName());
        UserEntity recipient = userRepository.findByUsernameIgnoreCase(message.getTo());
        if(sender != null & recipient != null){
            ZonedDateTime serverDateTime = ZonedDateTime.now();
            ZoneId clientTimeZone = ZoneId.of(message.getTimezone());
            //System.out.println(clientTimeZone.toString());
            ZonedDateTime clientDateTime = serverDateTime.withZoneSameInstant(clientTimeZone);
            ChatEntity chat = new ChatEntity(null,sender, recipient, null, message.getText(), null, Status.sent, clientDateTime);
            chat.setUsersid();
            chatRepository.save(chat);
            simpMessagingTemplate.convertAndSendToUser(message.getTo(), "/queue/reply", message);
        } else {
            throw new UsernameNotFoundException("Sender or Recipient could not be found !!!");
        }
    }*/
}
