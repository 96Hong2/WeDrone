package com.gudi.board.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.board.dto.BoardDTO;
import com.gudi.board.service.BoardService;

@RestController
public class CmController {

	
	Logger logger = LoggerFactory.getLogger(BoardController.class);
	//자유 게시판 댓글 컨트롤러 입니다~~
		@Autowired BoardService service;
		
		//자유게시판 댓글 리스트//지윤쓰
		@RequestMapping(value = "/list/{pagePerNum}/{page}")
		public HashMap<String, Object> fbcmtlist(@PathVariable int pagePerNum, @PathVariable int page ,HttpSession session) {
		    logger.info("자유 게시판 댓글 리스트 요청!!");
		    logger.info("pagePerNum : {} / page: {}",pagePerNum,page);		
			HashMap<String, Object> map = service.list(page, pagePerNum,session);		
			return map;	
		}
	
		//pagePerNum 
		//page 
		
			
			//댓글 쓰기//지윤쓰
			@RequestMapping(value = "/fbcmtwriteForm", method = RequestMethod.GET)
			public String fbcmtwriteForm(Model model, HttpSession session) {
			    
				logger.info("자유 게시판 댓글 쓰기 폼 요청");
				
				String page = "";
				
				if(session.getAttribute("loginId") != null) {
					page  = "fbcmtwriteForm";
				}else {
					model.addAttribute("msg", "로그인이 필요한 서비스입니다:) 로그인을 먼저 해주세요~~!!");
				}
				return page;
				
				
			}
			//지윤쓰
			@RequestMapping(value = "/fbcmtwrite", method = RequestMethod.POST)
			public ModelAndView write(@ModelAttribute BoardDTO dto) {
			    logger.info("자유게시판 댓글 쓰기 요청 ");
			    logger.info(dto.getNickName()+"/"+dto.getCmtContent());
			    
				return service.fbcmtwrite(dto);
			}
}
