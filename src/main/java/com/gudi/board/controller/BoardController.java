package com.gudi.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gudi.board.service.BoardService;
import com.gudi.board.service.InformService;
import com.gudi.util.PageMaker;

@Controller
public class BoardController {

	@Autowired
	BoardService service;

	@Autowired
	InformService informService;
	
	Logger logger = LoggerFactory.getLogger(BoardController.class);

	@RequestMapping(value = "/")
	public String home(Model model) {

		return "home";
	}

	@RequestMapping(value = "/warnmap")
	public String warnmap(Model model) {

		return "navbar/warnmap";
	}

	@RequestMapping(value = "/navbar")
	public String navbar(Model model) {

		return "/navbar";
	}

	@RequestMapping(value = "/lognav")
	public String lognav(Model model) {

		return "/lognav";
	}

	@Controller
	public class Controller0 {

		// map 페이지
		@RequestMapping("/map")
		public String springView(HttpServletRequest request, Model model) throws Exception {

			return "navbar/map";
		}

		// calendar 페이지
		@RequestMapping("/calendar")
		public String springView1(HttpServletRequest request, Model model) throws Exception {

			return "navbar/calendar";
		}

		// news 페이지
		@RequestMapping("/news")
		public String springView2(HttpServletRequest request, Model model) throws Exception {

			return "navbar/news";
		}

		// notice 페이지
		@RequestMapping("/notice")
		public String springView3(HttpServletRequest request, Model model) throws Exception {

			return "navbar/notice";
		}

		// board 페이지
		@RequestMapping("/board")
		public String springView4(HttpServletRequest request, Model model) throws Exception {

			return "navbar/board";
		}

		// 마이페이지
		@RequestMapping("/mypages")
		public String springView5(HttpServletRequest request, Model model) throws Exception {

			return "mypage/mypages";
		}

		// 내 정보
		@RequestMapping("/myinfo")
		public String springView8(HttpServletRequest request, Model model) throws Exception {

			return "mypage/myinfo";
		}

		// 내가 쓴 글
		@RequestMapping("/mypost")
		public String springView9(HttpServletRequest request, Model model) throws Exception {

			return "mypage/mypost";
		}

		// 내가 쓴 댓글
		@RequestMapping("/mycomment")
		public String springView10(HttpServletRequest request, Model model) throws Exception {

			return "mypage/mycomment";
		}

		// 내가 후기마커
		@RequestMapping("/myreview")
		public String springView11(HttpServletRequest request, Model model) throws Exception {
			return "mypage/myreview";
		}


		@RequestMapping("/alarmAllRead")
		public String alarmAllRead(Map<String, Object> map, HttpSession session) throws Exception {
			map.put("userid", (String)session.getAttribute("loginId") );
			informService.alarmAllRead(map);
			return "redirect:alarmlist";
		}

		@RequestMapping("/alarmLinkMove")
		public String alarmLinkMove(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
			String postId=(String)map.get("postId");			
			map.put("userid", (String)session.getAttribute("loginId") );
			informService.alarmRead(map);
			return "redirect:fbdetail?postId="+postId;
		}
		
		@RequestMapping(value = "/alarmDelete", method = RequestMethod.POST)
		@ResponseBody
		public int alarmDelete(@RequestParam Map<String, Object> map) {							
			return service.alarmDelete(map);
		}
		
		
		
		
		// 내 알림리스트
		@RequestMapping("/alarmlist")
		public String springView12(PageMaker pageMaker, Model model, Map<String, Object> map,
				HttpServletRequest request) throws Exception {
			map.put("userid", (String)request.getSession().getAttribute("loginId") );
			int totalCount=informService.informCount(map);
			
			pageMaker.setTotPage(totalCount);
			map.put("pageBegin", pageMaker.getPageBegin());
			map.put("pageEnd", pageMaker.getPageEnd());
			List<Map<String, Object>> list=informService.selectListInform(map);
			String pagination=pageMaker.bootStrapPagingHTML(request.getContextPath()  +"/alarmlist");
			
			model.addAttribute("list",list);
			model.addAttribute("totalCount",totalCount);
			model.addAttribute("pageMaker",pageMaker);
			model.addAttribute("pagination", pagination);
			return "mypage/alarmlist";
		}

		// 즐겨찾기
		@RequestMapping("/bookmark")
		public String springView13(HttpServletRequest request, Model model) throws Exception {

			return "mypage/bookmark";
		}

		// 회원탈퇴
		@RequestMapping("/userout")
		public String springView14(HttpServletRequest request, Model model) throws Exception {

			return "mypage/userout";
		}
	}

}
