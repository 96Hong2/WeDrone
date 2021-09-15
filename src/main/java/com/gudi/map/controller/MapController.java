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
		public ModelAndView rmWrite(@ModelAttribute MapDTO dto) {
			logger.info("리뷰마커 작성 메소드 실행");
			logger.info(dto.getAddress()+"/"+dto.getReviewContent()+"/"+dto.getLat()+"/"+dto.getLon());

			return service.rmWrite(dto);
		}

}
