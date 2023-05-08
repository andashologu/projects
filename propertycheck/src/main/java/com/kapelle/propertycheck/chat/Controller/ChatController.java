package com.kapelle.propertycheck.Chat.Controller;

import java.security.Principal;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.kapelle.propertycheck.Chat.Model.Status;

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
        UserEntity sender = userRepository.findByUsernameIgnoreCase(user.getName());
        UserEntity recipient = userRepository.findByUsernameIgnoreCase(message.getTo());
        if(sender != null & recipient != null){
            ZonedDateTime serverDateTime = ZonedDateTime.now();
            ZoneId clientTimeZone = ZoneId.of(message.getTimezone());
            ZonedDateTime clientDateTime = serverDateTime.withZoneSameInstant(clientTimeZone);
            LocalDate date = clientDateTime.toLocalDate();
            Date sqlDate = Date.valueOf(date);
            LocalTime time = clientDateTime.toLocalTime();
            Time sqlTime = Time.valueOf(time);
            message.setDate(sqlDate.toString());
            message.setTime(sqlTime.toString());
            ChatEntity chat = new ChatEntity(sender, recipient, message.getText(), Status.SENT, sqlDate, sqlTime, message.getTimezone());
            chatRepository.save(chat);
            simpMessagingTemplate.convertAndSendToUser(message.getTo(), "/queue/reply", message);
        }
        else{
            throw new UsernameNotFoundException("Sender or Recipient could not be found !!!");
        }
    }
}