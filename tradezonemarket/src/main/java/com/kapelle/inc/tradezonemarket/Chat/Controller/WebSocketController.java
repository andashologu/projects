package com.kapelle.inc.tradezonemarket.Chat.Controller;

import java.security.Principal;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kapelle.inc.tradezonemarket.Chat.Model.ChatEntity;
import com.kapelle.inc.tradezonemarket.Chat.Model.ChatMessage;
import com.kapelle.inc.tradezonemarket.Chat.Model.ChatRepository;
import com.kapelle.inc.tradezonemarket.Chat.Model.Status;
import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserEntity;
import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserRepository;

@Controller
public class WebSocketController {

    @Autowired
    SimpMessagingTemplate simpMessagingTemplate;

    @Autowired 
    ChatRepository chatRepository;

    @Autowired 
    UserRepository userRepository;

    @PostMapping("/chat/sendmessage")
    public String sendToSpecificUser(@RequestParam Boolean insert, @Payload ChatMessage message, Principal user, TimeZone timezone, Model model, Principal loggedUser) throws UsernameNotFoundException {
        UserEntity sender = userRepository.findByUsernameIgnoreCase(user.getName());
        UserEntity recipient = userRepository.findByUsernameIgnoreCase(message.getTo());
        ZonedDateTime clientDateTime = null;
        ChatEntity chat = null;
        if(sender != null | recipient != null) {
            if(recipient == null) {
                recipient = userRepository.findById(message.getRecipientId()).get();
                if(recipient == null){
                    throw new UsernameNotFoundException("Recipient could not be found !!!");
                }
            }
            ZonedDateTime serverDateTime = ZonedDateTime.now();
            ZoneId clientTimeZone = timezone.toZoneId();
            clientDateTime = serverDateTime.withZoneSameInstant(clientTimeZone);
            chat = new ChatEntity(null,sender, recipient, null, message.getText(), null, Status.Sent, clientDateTime);
            if(insert){
                chat.setUsersid();
                chatRepository.save(chat);
                simpMessagingTemplate.convertAndSendToUser(message.getTo(), "/queue/reply", message);
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
        model.addAttribute("username", loggedUser.getName());
        model.addAttribute("today", today.toLocalDate());/*must compare only date! not zone date, hence this conversion */
        model.addAttribute("yesterday", yesterday.toLocalDate());
        model.addAttribute("thisweek", thisweek.toLocalDate());
        return "chat/components/messages";
    }
    // Mapped as /app/specific/typingstatus
    @MessageMapping("/specific/typingstatus")
    public void sendTypingStatus(@Payload ChatMessage message) {
        simpMessagingTemplate.convertAndSendToUser(message.getTo(), "/queue/typingstatus", message);
    }
}
