package com.kapelle.propertycheck.PropertyCheck.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.support.RequestContextUtils;

import jakarta.servlet.http.HttpServletRequest;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Currency;
import java.util.Locale;
import java.util.TimeZone;

import org.springframework.stereotype.Controller;

@Controller
public class Home {

    @GetMapping("/")
    public String index(){
        return "home";
    }
    @GetMapping("/post/{id}")
    public String index(@PathVariable("id") String username){
        return "posts/item";
    }
    @GetMapping("/test")
    public String test(HttpServletRequest request, TimeZone timezone, Locale locale){
        
        
      /* Object obj = null;
     if(timezone != null){
        System.out.println("client:...");
       

        obj = timezone.toZoneId();
        System.out.println("obj: "+obj);
     }
     else{
        System.out.println("sytem:...");
        obj =  ZoneId.systemDefault();
        
     }*/
     System.out.println("Current time zone: "+timezone.toZoneId());
     System.out.println("Current  locate: "+locale.getDisplayCountry());
     String country = timezone.getDisplayName(locale);//country
     System.out.println("Country: "+country);

     Currency currency = null;
     
     System.out.println("Currency: "+Currency.getInstance(locale));
     System.out.println("");

        // Current date and time using now()
		ZonedDateTime currentDateTime = ZonedDateTime.now();

        // Creating two timezone zoneid objects using ZoneId.of() method.

        ZoneId clienttimeZone = timezone.toZoneId();
	    ZoneId dubaiTimeZone = ZoneId.of("Asia/Dubai");

        // Converting Current timezone time to Log Angeles time
		ZonedDateTime losAngelesDateTime = currentDateTime.withZoneSameInstant(clienttimeZone);

		// Converting Current timezone time to Dubai time
		ZonedDateTime dubaiDateTime = currentDateTime.withZoneSameInstant(dubaiTimeZone);
        System.out.println("ZonedDateTime : " + dubaiDateTime);
        System.out.println("Zone: " + dubaiDateTime.getZone());
        System.out.println("ZonedDate: " + dubaiDateTime.toLocalDate());
        System.out.println("ZonedTime: " + dubaiDateTime.toLocalTime());

		// Datetime formatting 
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MMM-dd HH:mm z");
		
		// Print all 3 dates
		System.out.println("Current time in IST : " + formatter.format(currentDateTime));
		System.out.println("Los Angeles time now : " + formatter.format(losAngelesDateTime));
		System.out.println("Dubai time now : " + formatter.format(dubaiDateTime));

        //............................................................................
        System.out.println(locale.getCountry());

        return "test";
    }
} 
