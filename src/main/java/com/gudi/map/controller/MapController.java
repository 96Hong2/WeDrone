package com.gudi.map.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gudi.map.service.MapService;

@Controller
public class MapController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired(required=false) MapService service;

	//해당 지역의 후기개수, 평점을 Ajax로 map.jsp에 돌려주는 메소드
	@RequestMapping(value = "/getAreaInfo", method=RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> getAreaInfo(@RequestParam String areaName) {
		logger.info("컨트롤러로 들어온(서비스에 넘겨주는) areaName : ", areaName);
		return service.getAreaInfo(areaName);
	}
	
	@RequestMapping(value = "/getReviewlist", method=RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> getReviewlist(@RequestParam String areaName) {
		logger.info("컨트롤러로 들어온(서비스에 넘겨주는) areaName : ", areaName);
		return service.getAreaInfo(areaName);
	}

}
