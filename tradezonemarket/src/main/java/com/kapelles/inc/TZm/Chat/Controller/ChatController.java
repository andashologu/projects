package com.kapelles.inc.TZm.chat.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.TimeZone; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.user.SimpUser;
import org.springframework.messaging.simp.user.SimpUserRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kapelles.inc.TZm.chat.model.ChatEntity;
import com.kapelles.inc.TZm.chat.model.ChatMessage;
import com.kapelles.inc.TZm.chat.model.ChatRepository;
import com.kapelles.inc.TZm.chat.model.Status;
import com.kapelles.inc.TZm.authentication.user.model.UserEntity;
import com.kapelles.inc.TZm.authentication.user.model.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {

    @Autowired
    SimpMessagingTemplate simpMessagingTemplate;

    @Autowired 
    ChatRepository chatRepository;

    @Autowired 
    UserRepository userRepository;

    @Autowired 
    SimpUserRegistry simpUserRegistry;//work with stomp

    @GetMapping("/chat")
    public String index(Model model, Principal loggedUser) {
        model.addAttribute("username", loggedUser.getName());
        return "chat/index";
    }
    @GetMapping("/chat/api/contacts")
    public String contacts(@RequestParam int pagenumber, @RequestParam int pagesize, TimeZone timezone, Model model, Principal loggedUser, HttpSession session) {
        
        Pageable pageable = PageRequest.of(pagenumber, pagesize);
        Slice<ChatEntity> contactsSlice = chatRepository.findContacts(userRepository.findByUsername(loggedUser.getName()), pageable);
        List<ChatEntity> contactsList = contactsSlice.getContent();
        //Would need List<ChatEntity> contactsList = new ArrayList<ChatEntity>();, contactsSlice.getContent() is not working with messagesList.sort(Comparator.comparing(ChatEntity::getDatetime).thenComparing(Comparator.comparingLong(ChatEntity::getId).reversed()));/* method to reverse List<Entity>*/
        LocalDate clientCurrentTime = LocalDate.now();
        ZonedDateTime today =  clientCurrentTime.atStartOfDay(timezone.toZoneId());
        ZonedDateTime yesterday =  today.minusDays(1);
        ZonedDateTime thisweek =  today.minusDays(7);
        ZonedDateTime chatDateTime = null;
        ZonedDateTime loggedUserDateTime = null;
        for(ChatEntity contact: contactsSlice) {

            chatDateTime = contact.getDatetime();
            loggedUserDateTime = chatDateTime.withZoneSameInstant(timezone.toZoneId());
            contact.setDatetime(loggedUserDateTime);
        }
        model.addAttribute("contacts", contactsList);
        model.addAttribute("hasNextContacts", contactsSlice.hasNext());
        model.addAttribute("pagenumber", pagenumber);
        model.addAttribute("username", loggedUser.getName());
        model.addAttribute("today", today);
        model.addAttribute("yesterday", yesterday);
        model.addAttribute("thisweek", thisweek);
        return "chat/components/contacts";
    }
    @GetMapping("/chat/api/messages")
    public String messages(@RequestParam Long initialId, @RequestParam Long id, @RequestParam int pagenumber, @RequestParam int pagesize, TimeZone timezone, Model model, Principal loggedUser) {
        
        Pageable pageable = PageRequest.of(pagenumber, pagesize);
        Optional<UserEntity> contact = userRepository.findById(id);
        UserEntity user = userRepository.findByUsername(loggedUser.getName());
        Slice<ChatEntity> messagesSlice = null;
        if(initialId == 0) {//pagination offset
            messagesSlice = chatRepository.findBySenderOrRecipient(contact.get(), user, pageable);
        } else {
            messagesSlice = chatRepository.findBySenderOrRecipient(initialId, contact.get(), userRepository.findByUsername(loggedUser.getName()), pageable);
        }
        List<ChatEntity> messagesList = messagesSlice.getContent();
        LocalDate clientCurrentTime = LocalDate.now();
        ZonedDateTime today =  clientCurrentTime.atStartOfDay(timezone.toZoneId());
        ZonedDateTime yesterday =  today.minusDays(1);
        ZonedDateTime thisweek =  today.minusDays(7);
        ZonedDateTime chatDateTime = null;
        ZonedDateTime loggedUserDateTime = null;
        for(ChatEntity chat: messagesSlice) {

            chatDateTime = chat.getDatetime();
            loggedUserDateTime = chatDateTime.withZoneSameInstant(timezone.toZoneId());
            chat.setDatetime(loggedUserDateTime);
            if(chat.getStatus() != Status.Message.Seen && user == chat.getRecipient()) {
                    chat.setStatus(Status.Message.Seen);
                    chat.setRead(false);
                    chatRepository.save(chat);
                    simpMessagingTemplate.convertAndSendToUser(chat.getSender().getUsername(), "/queue/messagestatus", new ChatMessage(chat.getId(), null, chat.getRecipient().getId(), null, null, Status.Message.Seen, null));
                    //message can be updated as seen on the client side with javascript using message Id
                }
        }
        model.addAttribute("messages", messagesList);
        model.addAttribute("hasNextMessages", messagesSlice.hasNext());
        model.addAttribute("pagenumber", pagenumber);
        model.addAttribute("username", loggedUser.getName());
        model.addAttribute("today", today.toLocalDate());/*must compare only date! not zone date, hence this conversion */
        model.addAttribute("yesterday", yesterday.toLocalDate());
        model.addAttribute("thisweek", thisweek.toLocalDate());
        return "chat/components/messages";
    }

    @GetMapping("/chat/api/content")
    public String contacts(@RequestParam Long id, Model model, Principal loggedUser) {
        Optional<UserEntity> contact = userRepository.findById(id);
        String chat_username = contact.get().getUsername();
        Boolean isActive = false;
        model.addAttribute("chat", contact);
        model.addAttribute("username", loggedUser.getName());
        Set<SimpUser> loggedUsers = simpUserRegistry.getUsers();
        for(SimpUser simpUser: loggedUsers){
            
            if(simpUser.getName().equals(chat_username)) {//if recipient is logged to websocket, set message status to delivered
                isActive = true;
                break;
            }
        }
        model.addAttribute("isActive", isActive);
        return "chat/components/content";
    }
}