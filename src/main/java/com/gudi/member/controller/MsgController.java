package com.gudi.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MsgController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/message")
	public String message(Model model) {
		return "message";
	}
}
