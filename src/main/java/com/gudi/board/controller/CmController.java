package com.gudi.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


import com.gudi.board.dto.BoardDTO;
import com.gudi.board.service.BoardService;
import com.gudi.util.PageMaker;

@RestController
public class CmController {

	
	Logger logger = LoggerFactory.getLogger(BoardController.class);
	//자유 게시판 댓글 컨트롤러 입니다~~
		@Autowired BoardService service;
		

		@RequestMapping(value = "/fbcmList")
		@ResponseBody
		public Map<String, Object> fbcmtlist(PageMaker pageMaker, Model model,  @RequestParam Map<String, Object> map, HttpServletRequest request) {
			int commentTotalCount=service.fbcmtTotalCount(map);
			pageMaker.setTotPage(commentTotalCount);
			map.put("pageBegin", pageMaker.getPageBegin());
			map.put("pageEnd", pageMaker.getPageEnd());
			List<Map<String, Object>> commentList=service.fbcmtlist(map);
			String pagination=pageMaker.commentPagingHTML(request.getContextPath()  +"/fbcmList");
					
		    Map<String, Object> resultMap = new HashMap<String, Object>();
		    resultMap.put("page", pageMaker.getPage());
		    resultMap.put("commentTotalCount", commentTotalCount);
		    resultMap.put("commentList", commentList);
		    resultMap.put("pageMaker", pageMaker);
		    resultMap.put("pagination", pagination);
			
			return resultMap;
		}
		
		

		// 지윤쓰
		@RequestMapping(value = "/fbcmtwrite", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> write(@ModelAttribute BoardDTO dto,HttpSession session) {
					
			String loginId = (String) session.getAttribute("loginId");
			dto.setUserId(loginId);	
			return service.fbcmtwrite(dto);
		}

		
		
		@RequestMapping(value = "/getComment", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> getComment(@RequestParam Map<String, Object> map) {							
			return service.getComment(map);
		}
		
		
		
		
		
		// 댓글 업데이트 지윤쓰
		@RequestMapping(value = "/fbcmtupdate")
		@ResponseBody
		public HashMap<String, Object> fbupdate(@ModelAttribute BoardDTO dto, HttpSession session) {
			logger.info("댓글 업데이트  : {} ", dto);
			return service.fbcmtupdate(dto, session);
		}

		// 댓글 업데이트 지윤쓰
		@RequestMapping(value = "/fbcmtDel")
		@ResponseBody
		public HashMap<String, Object> fbcmtDel(@ModelAttribute BoardDTO dto, HttpSession session) {
			logger.info("댓글 삭제  : {} ", dto);

			return service.fbcmtDel(dto, session);
		}


}
