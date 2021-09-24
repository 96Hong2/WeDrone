package com.gudi.member.controller;


import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.codec.Hex;
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

	@RequestMapping(value = "/memberInfo")
	public ModelAndView memberInfo(HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		return service.memberInfo(loginId);
	}

	@RequestMapping(value = "/memberDel")
	public ModelAndView memberDel(HttpSession session){
		String loginId = (String)session.getAttribute("loginId");
		return service.memberDel(loginId);
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@RequestParam HashMap<String, String> params) {
		logger.info("update info : {}", params);
		service.update(params);
		return "redirect:/memberInfo?userId=" + params.get("");
	}
	
	//비밀번호 변경
	@RequestMapping(value = "/pwchange")
	public String pwchange(Model model) {

		return "mypage/pwchange";
	}
	
			
		String plainText = "";
		
		String hashText = "";
		
		
	@RequestMapping(value="/join1")
	public String join(@RequestParam String pass) {
		
		
		logger.info("평문 : "+pass);		
		logger.info("java 자체 메서드 사용 암호화 : "+getHash(pass));
		
		plainText = pass;		
		//변환
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		//spring security 의 암호화는 salut 라는 값을 사용하여
		//같은 값을 넣더라도 특정한 규칙에 의한 sault 값을 추가하여 다른 해시를 만든다.
		hashText = encoder.encode(pass);
		logger.info("암호문 : "+hashText);		
		return "mypage/pwchange";
	}
	
	private String getHash(String pass) {		
		String result = "";		
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] byteArr = digest.digest(pass.getBytes(StandardCharsets.UTF_8));
			//바이너리로 저장하면 깨지므로 16진수로 변환하여 만든다.
			result = new String(Hex.encode(byteArr));			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}		
		return result;
	}

	@RequestMapping(value="/confirm")
	public String confirm(@RequestParam String pass) {		
		//평문 -> 암호화 -> 기존암호화와 비교(이런 식으론 안된다. 해시 값이 각각 달라지므로)
		logger.info("평문 : "+pass);		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		boolean success = encoder.matches(pass, hashText);
		logger.info("일치 여부 : "+success);		
		return "mypage/pwchange";
	}
	
	
}
