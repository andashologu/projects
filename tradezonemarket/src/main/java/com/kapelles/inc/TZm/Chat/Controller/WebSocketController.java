package com.kapelles.inc.TZm.chat.controller;

import java.security.Principal;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.user.SimpUser;
import org.springframework.messaging.simp.user.SimpUserRegistry;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kapelles.inc.TZm.chat.model.ChatEntity;
import com.kapelles.inc.TZm.chat.model.ChatMessage;
import com.kapelles.inc.TZm.chat.model.ChatRepository;
import com.kapelles.inc.TZm.chat.model.Status;
import com.kapelles.inc.TZm.authentication.user.model.UserEntity;
import com.kapelles.inc.TZm.authentication.user.model.UserRepository;

@Controller
public class WebSocketController {

    @Autowired
    SimpMessagingTemplate simpMessagingTemplate;

    @Autowired 
    ChatRepository chatRepository;

    @Autowired 
    UserRepository userRepository;

    @Autowired 
    SimpUserRegistry simpUserRegistry;//work with stomp

    @PostMapping("/chat/message")
    public String sendToSpecificUser(@RequestParam Boolean insert, @Payload ChatMessage message, Principal user, TimeZone timezone, Model model) throws UsernameNotFoundException {
        UserEntity sender = null;
        UserEntity recipient = null;
        if(insert) { //returned sender
            sender = userRepository.findByUsernameIgnoreCase(user.getName());
            recipient = userRepository.findByUsernameIgnoreCase(message.getTo());
        } else { //returned to recipient
            sender = userRepository.findByUsernameIgnoreCase(message.getTo());
            recipient = userRepository.findByUsernameIgnoreCase(user.getName());
        }
        ZonedDateTime clientDateTime = null;
        ChatEntity chat = null;
        if(sender != null && recipient != null) {
            ZonedDateTime serverDateTime = ZonedDateTime.now();
            ZoneId clientTimeZone = timezone.toZoneId();
            clientDateTime = serverDateTime.withZoneSameInstant(clientTimeZone);
            if(insert) {
                chat = new ChatEntity(null,sender, recipient, null, message.getText(), null, Status.Message.Sent, clientDateTime);//initially set message status to sent
                Set<SimpUser> loggedUsers = simpUserRegistry.getUsers();
                for(SimpUser simpUser: loggedUsers) {
                    if(simpUser.getName().equals(message.getTo())){//if recipient is logged to websocket, set message status to delivered
                        chat.setStatus(Status.Message.Delivered);
                        break;
                    }
                }
                chat.setUsersid();
                chatRepository.save(chat);
                if(sender != null) {
                    message.setSenderId(sender.getId());
                }
                message.setMessageId(chat.getId());
                simpMessagingTemplate.convertAndSendToUser(message.getTo(), "/queue/recievemessage", message);
            } else {
                Optional<ChatEntity> sentChat = chatRepository.findById(message.getMessageId());
                chat = sentChat.get();
                chat.setStatus(Status.Message.Seen);
                chatRepository.save(chat);//will be updated, not new record
                if(sender != null) {
                    simpMessagingTemplate.convertAndSendToUser(sender.getUsername(), "/queue/messagestatus", new ChatMessage(chat.getId(), null, chat.getRecipient().getId(), null, null, Status.Message.Seen, null));
                }
                //the message is updated as seen on the client side with javascript using message Id
            }
        } 
        else {
            throw new UsernameNotFoundException("Sender or Recipient could not be found !!!");
        }

        ZonedDateTime today =  clientDateTime;
        ZonedDateTime yesterday =  today.minusDays(1);
        ZonedDateTime thisweek =  today.minusDays(7);
        ZonedDateTime chatDateTime = null;
        ZonedDateTime loggedUserDateTime = null;
        
        chatDateTime = chat.getDatetime();
        loggedUserDateTime = chatDateTime.withZoneSameInstant(timezone.toZoneId());
        chat.setDatetime(loggedUserDateTime);

        List<ChatEntity> messagesList = new ArrayList<ChatEntity>();
        messagesList.add(chat);

        model.addAttribute("messages", messagesList);
        model.addAttribute("pagenumber", null);
        model.addAttribute("username", user.getName());
        model.addAttribute("today", today.toLocalDate());/*must compare only date! not zone date, hence this conversion */
        model.addAttribute("yesterday", yesterday.toLocalDate());
        model.addAttribute("thisweek", thisweek.toLocalDate());
        return "chat/components/messages";
    }
}