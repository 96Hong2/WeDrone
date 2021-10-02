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
public class MemberService<pwchange> {

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
		logger.info("서비스 로그인요청 id/pw : " + userId + "/" + pw);
		String page = "loginForm";
		String msg = "아이디 또는 비밀번호를 확인하세요.";

		HashMap<String, String> map = dao.login(userId);
		//int hasId = map.size();
		logger.info("***************map : {}", map);
		
		if(map == null) {
			logger.info("아이디 없음");
		} else {
			String DBPw = map.get("PW");
			String nickName = map.get("NICKNAME");
			String chkAlert = map.get("CHKALERT");
			String isDel = map.get("ISDEL");
			
			logger.info("들어온 pw값/DB의 pw : " + pw + "/" + DBPw);
			logger.info("들어온 nickName : {}", nickName);
			logger.info("DBPw : {}", DBPw);
			logger.info("알림여부 : {}", chkAlert);
			logger.info("탈퇴여부 : {}" + isDel);
	
			if (DBPw != null && DBPw != "") {
				BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
				boolean matched = encoder.matches(pw, DBPw);
				logger.info("PW 일치 여부 : " + matched);
				
				if (isDel.equals("Y")||isDel=="Y") {
	
					page = "home";
					msg = "탈퇴한 회원입니다.";
				}else if (matched) {
					session.setAttribute("loginId", userId);
					session.setAttribute("loginNickName", nickName);
					session.setAttribute("chkAlert", chkAlert);
					page = "home";
					msg = "";
				}
			}
		}
		mav.addObject("msg", msg);
		mav.setViewName(page);
		return mav;
	}

	//내 정보 
	public ModelAndView memberInfo(String userId) {

		ModelAndView mav = new ModelAndView();
		String page = "redirect:/mypages";

		MemberDTO dto = dao.memberInfo(userId);
		logger.info("dto : {}", dto);

		if (dto != null) {
			page = "mypage/myinfo";
			mav.addObject("dto", dto);
		}
//지우시면 안돼요 ㅜㅜ
		mav.setViewName(page);

		return mav;
	}

	//탈퇴하기
	public ModelAndView memberDel(String userId) {
		ModelAndView mav = new ModelAndView();

		int success = dao.memberDel(userId);
		logger.info("삭제된 행 : " + success);

		mav.setViewName("redirect:/");

		return mav;
	}

	//정보 수정하기
	public void update(HashMap<String, String> params, HttpSession session, String loginId) {
		int success = dao.update(params);
		HashMap<String, String> map = dao.login(loginId);
		String nickName = map.get("NICKNAME");
		String chkAlert = map.get("CHKALERT");
		logger.info("정보수정 nick/chkAlert : " + nickName +"/"+chkAlert);
		session.setAttribute("loginNickName", nickName);
		session.setAttribute("chkAlert", chkAlert);
		logger.info("내 정보 수정 성공 여부 : " + success);
	}


	//비번 수정하기
		public void pwupdate(HashMap<String, String> params) {
			int success = dao.update(params);
			logger.info("비밀번호 수정 성공 여부 : " + success);
		}

		public String idpwCheck(HashMap<String, String> params) {
		
			return dao.idpwCheck(params);
			
		}

		public void pwChange(String hashPw, String loginId) {
			dao.pwChange(hashPw,loginId);
		}
		
		
	
	}
	//비밀번호 가져오기
	//*public ModelAndView getMyPassword(String userId, String pw, HttpSession session) {
//		logger.info("본인 확인 요청 id, pw : " + userId + "/" + pw);
//		HashMap<String, String> map = dao.login(userId);
//		String DBPw = map.get("PW");
//		logger.info("들어온 pw값 : " + pw );
//		logger.info("DBPw : {}", DBPw);
//		if (DBPw != null && DBPw != "") {
//			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
//			boolean matched = encoder.matches(pw, DBPw);
//			logger.info("PW 일치 여부 : " + matched);
//			if (matched) {
//				session.setAttribute("loginId", userId);
//						pw = "${path}mypage/pwchange";
//				msg = "비밀번호가 이전과 동일합니다";
//			}
//			if(encoder.matches(pw,map.get("PW")))
//					mav.addObject("msg", msg);
//		mav.setViewName(pw);
		//return mav;*/
		//	}

//}}
