package com.gudi.map.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.map.dto.MapDTO;
import com.gudi.map.service.MapService;

@Controller
public class MapController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired(required=false) MapService service;

	//은홍
	//해당 지역의 후기개수, 평점을 map.jsp에 돌려주는 메소드
	@RequestMapping(value = "/getAreaInfo", method=RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> getAreaInfo(@RequestParam String areaName) {
		logger.info("areaName : {}", areaName);
		return service.getAreaInfo(areaName);
	}
	
	//은홍 //해당 지역의 후기리스트를 가져오는 메소드
	@RequestMapping(value = "/getReviewList", method=RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> getReviewList(@RequestParam String areaName, @RequestParam String order, HttpSession session) {
		logger.info("areaName/order : {}"+areaName+"/"+order);
		return service.getReviewList(areaName, order, session);
	}
		
		//지현//후기마커 작성 메소드
		@RequestMapping(value = "/rmWrite", method = RequestMethod.POST)
		public @ResponseBody HashMap<String, Object> rmWrite(@ModelAttribute MapDTO dto) {
			logger.info("리뷰마커 작성 메소드 실행");
			logger.info(dto.getAddress()+"/"+dto.getReviewContent()+"/"+dto.getLat()+"/"+dto.getLon()+"/"+dto.getRating());
			
			//logger.info("file : "+dto.getFile().getOriginalFilename());
			return service.rmWrite(dto);
		}
		
		//지현//후기마커 이미지 업로드 메소드

		@RequestMapping(value = "/rmFileUpload", method = RequestMethod.POST)
		public @ResponseBody HashMap<String, Object> rmFileUpload(@ModelAttribute MapDTO dto) {
			logger.info("리뷰마커 이미지 첨부 메소드 실행");
			logger.info("file : "+dto.getFile().getOriginalFilename());
			
			return service.rmFileUpload(dto);
		}

		//은홍
		//후기마커 상세정보 모달창에 넣을 jsp로 이동 (임시로 만듬)
		@RequestMapping(value = "/modal", method=RequestMethod.GET)
		public String modal() {
			return "reviewDetail";
		}
		
		//은홍
		//후기마커의 상세정보를 가져오는 메소드
		@RequestMapping(value = "/getReviewDetail", method=RequestMethod.GET)
		@ResponseBody
		public HashMap<String, Object> getReviewDetail(@RequestParam String areaName) {
			logger.info("areaName : {}", areaName);
			return service.getAreaInfo(areaName);
		}
}
