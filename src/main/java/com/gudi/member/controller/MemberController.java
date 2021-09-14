package com.gudi.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.member.dto.MemberDTO;
import com.gudi.member.service.MemberService;

@Controller
public class MemberController {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired(required = false)
	MemberService service;

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String home(Model model) {
		return "joinForm";
	}

	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public ModelAndView home(@RequestParam HashMap<String, String> params) {
		logger.info("컨트롤 조인 들어옴");
		logger.info("join : {}", params);
		return service.join(params);
	}

	@ResponseBody
    @RequestMapping(value = "/idCheck", method = RequestMethod.POST)
    public int idCheck(String userId) throws Exception {
		logger.info("컨트롤 아이디체크 들어옴");
		logger.info(userId);
        int result = service.idCheck(userId);
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/nickCheck", method = RequestMethod.POST)
    public int nickCheck(String nickName) throws Exception {
    	logger.info("컨트롤 닉네임체크 들어옴");
    	logger.info(nickName);
        int result = service.nickCheck(nickName);
        return result;
    }
    
    @RequestMapping(value = "/login", method = RequestMethod.GET)
	public String home1(Model model) {
		return "login";
	}
    
    @RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Model model, HttpSession session,@ModelAttribute MemberDTO info) {	
		
		logger.info("컨트롤 로그인 :{}",info.getUserId()+"/"+info.getPw());				
		String page = "login";
				
		MemberDTO loginInfo= service.login(info);
		if(loginInfo != null) {
			page = "redirect:/";
			session.setAttribute("loginId", loginInfo);
		}else {
			model.addAttribute("msg", "아이디 패스워드를 확인 하세요");
		}		
		return page;
	}
}
