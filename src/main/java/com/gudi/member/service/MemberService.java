package com.gudi.member.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.member.dao.MemberDAO;
import com.gudi.member.dto.MemberDTO;

@Service
public class MemberService {

Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired(required=false) MemberDAO dao;

	public ModelAndView join(HashMap<String, String> params) {
		
		MemberDTO dto = new MemberDTO();
		logger.info("서비스 조인 들어옴");
		dto.setUserId(params.get("userId"));
		dto.setPw(params.get("pw"));
		dto.setNickName(params.get("nickName"));
		dto.setChkAlert(params.get("chkAlert"));
		logger.info("서비스 조인 : {}", params);
		int success = dao.join(dto);		
		logger.info("success : "+success);
		String msg = "등록에 실패 했습니다.";
		String page = "joinForm";
		if(success >0 ) {
			msg = "등록에 성공 했습니다.";
			page = "home";
		}
		
				
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.setViewName(page);
		
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

	public MemberDTO login(MemberDTO info) {	
		logger.info("서비스 로그인 :{}",info.getUserId()+"/"+info.getPw());	
		MemberDTO dto = dao.login(info);	
		logger.info("dto : "+dto);
		
		return dto;
	}
}
