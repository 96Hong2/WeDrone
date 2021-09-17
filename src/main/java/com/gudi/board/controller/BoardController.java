package com.gudi.board.controller;



import javax.servlet.http.HttpServletRequest;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class BoardController {

	Logger logger = LoggerFactory.getLogger(BoardController.class);

	
	@RequestMapping(value = "/")
	public String home(Model model) {

		return "home";
	}
	
	
	
	@RequestMapping(value = "/warnmap")
	public String warnmap(Model model) {

		return "/warnmap";
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

		// 알림리스트
		@RequestMapping("/alarmlist")
		public String springView12(HttpServletRequest request, Model model) throws Exception {

			return "mypage/alarmlist";
		}

		// 즐겨찾기
		@RequestMapping("/bookmark")
		public String springView13(HttpServletRequest request, Model model) throws Exception {

			return "mypage/bookmark";
		}

		//회원탈퇴
		@RequestMapping("/userout")
		public String springView14(HttpServletRequest request, Model model) throws Exception {

			return "mypage/userout";
		}
	}

}
