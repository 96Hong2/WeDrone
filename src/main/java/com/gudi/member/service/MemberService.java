package com.gudi.member.service;



import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.member.dao.MemberDAO;
import com.gudi.member.dto.MemberDTO;

@Service
public class MemberService {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	ModelAndView mav = new ModelAndView();
	
	@Autowired(required = false)
	MemberDAO dao;

	public ModelAndView join(MemberDTO dto) {
		logger.info("서비스 조인 들어옴");
		logger.info("회원가입 요청dto : " + dto);
		
		String msg = "회원가입에 실패했습니다.";

		String plainPw = dto.getPw();
		logger.info("들어온 pw값 : " + plainPw);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String HashPw = encoder.encode(plainPw);
		logger.info("암호화된 pw값 : " + HashPw);
		dto.setPw(HashPw);
		logger.info("dto에 들어간 pw값 : " + dto.getPw());

		int success = dao.join(dto);
		if (success > 0) {
			msg = "회원가입에 성공했습니다. 로그인해주세요!";
		}
		mav.addObject("msg", msg);
		mav.setViewName("home");
		return mav;
	}

	public int idCheck(String userId) throws Exception {
		int result = dao.idCheck(userId);
		return result;
	}

	public int nickCheck(String nickName) throws Exception {
		int result = dao.nickCheck(nickName);
		return result;
	}

	public ModelAndView login(String userId, String pw, HttpSession session) {
		logger.info("서비스 로그인요청 id/pw : "+userId+ "/" + pw);
		String page = "loginForm";
		String msg = "아이디 또는 비밀번호를 확인하세요.";
		String DBPw=null;
		String nickName=null;
		HashMap<String, String> map = dao.login(userId);
		if(map!=null) {
			DBPw= map.get("PW");
			nickName = map.get("NICKNAME");
			logger.info("들어온 pw값/DB의 pw : "+pw+"/"+DBPw);
			logger.info("들어온 nickName : {}",nickName);
			logger.info("DBPw : {}", DBPw);
			
		}		
		
		if(DBPw != null && DBPw != "") {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			boolean matched = encoder.matches(pw, DBPw);
			logger.info("PW 일치 여부 : "+matched);
			
			if(matched) {
				session.setAttribute("loginId", userId);
				session.setAttribute("loginNickName", nickName);
				page = "home";
				msg = "로그인 성공";
			}
		}
		mav.addObject("msg", msg);
		mav.setViewName(page);
		return mav;
	}
}
