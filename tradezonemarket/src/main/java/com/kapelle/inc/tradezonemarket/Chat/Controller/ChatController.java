package com.kapelle.inc.tradezonemarket.Chat.Controller;

import java.security.Principal;
import java.time.LocalDate;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kapelle.inc.tradezonemarket.Chat.Model.ChatEntity;
import com.kapelle.inc.tradezonemarket.Chat.Model.ChatRepository;
import com.kapelle.inc.tradezonemarket.Chat.Model.Status;
import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserEntity;
import com.kapelle.inc.tradezonemarket.authentication.user.Model.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class ChatController {

    @Autowired 
    ChatRepository chatRepository;

    @Autowired 
    UserRepository userRepository;

    @GetMapping("/chat")
    public String index(Model model, Principal loggedUser){
        model.addAttribute("username", loggedUser.getName());
        return "chat/index";
    }

    @GetMapping("/chat/test")
    public String test(){
        return "chat/justpage";
    }

    @GetMapping("/chat/api/contacts")
    public String contacts(@RequestParam int pagenumber, @RequestParam int pagesize, TimeZone timezone, Model model, Principal loggedUser, HttpSession session){
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
            if(contact.getStatus() == Status.Sent){
                //update all messages where recipient = this currently logged user to delivered
            }
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
    public String messages(@RequestParam Long id, @RequestParam int pagenumber, @RequestParam int pagesize, TimeZone timezone, Model model, Principal loggedUser) {
        Pageable pageable = PageRequest.of(pagenumber, pagesize);
        Optional<UserEntity> contact = userRepository.findById(id);
        Slice<ChatEntity> messagesSlice = chatRepository.findBySenderOrRecipient(contact.get(), userRepository.findByUsername(loggedUser.getName()), pageable);
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
            if(chat.getStatus() == Status.Delivered) {
                //update this specific message to if recipient == this currently logged user
            }
        }
        model.addAttribute("messages", messagesList);
        model.addAttribute("hasNextMessages", messagesSlice.hasNext());
        model.addAttribute("pagenumber", pagenumber);
        /*model.addAttribute("contact", contact);*/
        model.addAttribute("username", loggedUser.getName());
        model.addAttribute("today", today.toLocalDate());/*must compare only date! not zone date, hence this conversion */
        model.addAttribute("yesterday", yesterday.toLocalDate());
        model.addAttribute("thisweek", thisweek.toLocalDate());
        return "chat/components/messages";
    }

    @GetMapping("/chat/api/content")
    public String contacts(@RequestParam Long id, Model model, Principal loggedUser){
        Optional<UserEntity> contact = userRepository.findById(id);
        model.addAttribute("chat", contact);
        model.addAttribute("username", loggedUser.getName());
        return "chat/components/content";
    }
}