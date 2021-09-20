package com.gudi.member.controller;

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

	@RequestMapping(value = "/joinForm")
	public String joinForm(Model model) {
		return "joinForm";
	}

	@RequestMapping(value = "/join")
	public ModelAndView join(@ModelAttribute MemberDTO dto) {
		logger.info("컨트롤 조인 들어옴");
		logger.info("join : {}", dto);
		return service.join(dto);
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
    
    @RequestMapping(value = "/loginForm")
	public String loginForm(Model model) {    	
		return "loginForm";
	}
    
    @RequestMapping(value = "/login")
	public ModelAndView login(@RequestParam String userId, @RequestParam String pw, HttpSession session) {	
		
		logger.info("컨트롤 로그인 요청");				
		return service.login(userId, pw, session);
	}
    
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) {
        logger.info("컨트롤 로그아웃 요청");
        session.invalidate();    
        
        return "redirect:/";
    }


}
