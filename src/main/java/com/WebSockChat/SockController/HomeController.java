package com.WebSockChat.SockController;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "Main";
	}
	
	@RequestMapping(value = "chatPage2")
	public ModelAndView chatPage2(String chatId,HttpSession session) {
		System.out.println("채팅페이지2 이동 요청");
		System.out.println("사용할 아이디 : "+chatId);
		ModelAndView mav = new ModelAndView();
		if(chatId ==null || chatId.length() == 0) {
			mav.setViewName("Main");
			return mav;
		}
		
		session.setAttribute("loginId",chatId);
		mav.setViewName("ChatPage");
		
		return mav;
	}
	
}
