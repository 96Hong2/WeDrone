package com.gudi.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MsgController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/message")
	public String message(Model model, @RequestParam String other) {
		model.addAttribute("other", other);
		logger.info("************other : ", other);
		return "message";
	}
	
	@RequestMapping(value = "/chatRoom")
	public String chatRoom(Model model) {
		return "chat/chatRoom";
	}
	
}
