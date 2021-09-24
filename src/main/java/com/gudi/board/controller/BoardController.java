package com.gudi.board.controller;

import java.util.ArrayList;
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
import org.springframework.web.servlet.ModelAndView;

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

		@RequestMapping(value = "/board")
		public String fbList(PageMaker pageMaker,  Model model, Map<String, Object> map, HttpServletRequest request) {
			int totalCount=service.fbTotalCount(map);
			pageMaker.setTotPage(totalCount);
			map.put("pageBegin", pageMaker.getPageBegin());
			map.put("pageEnd", pageMaker.getPageEnd());
			List<Map<String, Object>> list=service.fbList(map);
			String pagination=pageMaker.bootStrapPagingHTML(request.getContextPath()  +"/board");
			
			model.addAttribute("list",list);
			model.addAttribute("totalCount",totalCount);
			model.addAttribute("pageMaker",pageMaker);
			model.addAttribute("pagination", pagination);
			return "fbList";
		}


		// news 페이지
		@RequestMapping(value = "/news", method = RequestMethod.GET)
		public ModelAndView newsList(HttpSession session) {
			logger.info("컨트롤 newsList 요청");
			return service.newsList(session);
		}
		
		// news 상세보기
		@RequestMapping(value = "/newsDetail")
		public ModelAndView newsDetail(@RequestParam String postId) {
			logger.info("상세보기 요청 : " + postId);
			return service.newsDetail(postId);
		}

		// notice 페이지
		@RequestMapping(value = "/notice", method = RequestMethod.GET)
		public ModelAndView noticeList(HttpSession session) {
			logger.info("컨트롤 newsList 요청");
			return service.noticeList(session);
		}
		// notice 상세보기
		@RequestMapping(value = "/noticeDetail")
		public ModelAndView noticeDetail(@RequestParam String postId) {
			logger.info("상세보기 요청 : " + postId);
			return service.noticeDetail(postId);
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
		public ModelAndView myPost(HttpSession session) throws Exception {
			return service.getMyPost(session);
		}

		// 내가 쓴 댓글
		@RequestMapping("/mycomment")
		public ModelAndView myComment(HttpSession session) throws Exception {
			return service.getMyComment(session);
		}

		// 내 후기마커
		@RequestMapping("/myreview")
		public String springView11(HttpServletRequest request, Model model) throws Exception {
			model.addAttribute("requestTab", "myReview");
			return "navbar/map";
		}

		// 내 알림리스트
		@RequestMapping("/alarmlist")
		public String springView12(PageMaker pageMaker, Model model, Map<String, Object> map,
				HttpServletRequest request) throws Exception {
			map.put("userid", (String) request.getSession().getAttribute("loginId"));
			int totalCount = informService.informCount(map);

			pageMaker.setTotPage(totalCount);
			map.put("pageBegin", pageMaker.getPageBegin());
			map.put("pageEnd", pageMaker.getPageEnd());
			List<Map<String, Object>> list = informService.selectListInform(map);
			String pagination = pageMaker.bootStrapPagingHTML(request.getContextPath() + "/alarmlist");

			model.addAttribute("list", list);
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("pagination", pagination);
			return "mypage/alarmlist";
		}

		// 즐겨찾기
		@RequestMapping("/bookmark")
		public String springView13(HttpServletRequest request, Model model) throws Exception {
			model.addAttribute("requestTab", "bookmark");
			return "navbar/map";
		}

		// 회원탈퇴
		@RequestMapping("/userout")
		public String springView14(HttpServletRequest request, Model model) throws Exception {

			return "mypage/userout";
		}

		// 실시간정보
		@RequestMapping(value = "/confusion")
		public String confusion(Model model) {

			return "confusion";
		}

		

	

	}

}
