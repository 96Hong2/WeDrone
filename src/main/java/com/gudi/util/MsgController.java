package com.gudi.util;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gudi.board.service.InformService;

@Controller
public class MsgController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired InformService service;
	
	//채팅방으로 이동시키는 메소드
	@RequestMapping(value = "/chatRoom")
	public String chatRoom(Model model, @RequestParam(value="other") String other) {
		model.addAttribute("other", other);
		logger.info("************other : "+other);
		return "/chat/chatRoom";
	}
	
	//메시지박스에 요청받은 대화 리스트를 불러오는 메소드
	@RequestMapping(value = "/getReqList")
	@ResponseBody
	public HashMap<String, Object> getReqList(HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		return service.getReqList(loginId);
	}
	
	//대화요청 시 알림을 DB에 저장하는 메소드
	@RequestMapping(value = "/insertReq")
	@ResponseBody
	public HashMap<String, Object> insertReq(@RequestParam String userId, @RequestParam String reqUserId) {
		return service.insertReq(userId, reqUserId);
	}
	
	//대화요청 시 알림을 DB에 저장하는 메소드
	@RequestMapping(value = "/deleteReq")
	@ResponseBody
	public HashMap<String, Object> deleteReq(@RequestParam String userId, @RequestParam String reqUserId) {
		return service.deleteReq(userId, reqUserId);
	}
	
}
