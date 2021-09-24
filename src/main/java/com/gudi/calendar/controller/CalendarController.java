package com.gudi.calendar.controller;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gudi.board.controller.BoardController;
import com.gudi.calendar.dto.CalendarDTO;
import com.gudi.calendar.service.CalendarService;

@Controller
public class CalendarController {
	
	private Logger logger = LoggerFactory.getLogger(CalendarController.class);
	
	@Autowired
	private CalendarService calendarService;

	@RequestMapping("/calendar")
	public String calendar(HttpServletRequest request, Model model) throws Exception {
		return "navbar/calendar";
	}

	
	//스케줄 작성
	@ResponseBody
	@RequestMapping(value = "/addSchedule", method = RequestMethod.POST)
	public int addSchedule(CalendarDTO calendarDTO) throws Exception {
		return calendarService.addSchedule(calendarDTO);
	}

	
	//스케줄 리스트
	@ResponseBody
	@RequestMapping(value = "/selectEventList")
	public List<CalendarDTO>  selectEventList(@RequestParam Map<String, Object> map) throws Exception {
		logger.info(" select EventList , {} " ,  map.toString());
		return calendarService.selectEventList(map);		
	}

	
	//하나의 스케줄 정보 불러오기
	@ResponseBody
	@RequestMapping(value = "/getEvent")
	public CalendarDTO  getEvent(@RequestParam  Map<String, Object> map) throws Exception {
		return calendarService.getEvent(map);		
	}

	//스케줄 수정
	@ResponseBody
	@RequestMapping(value = "/deleteSch", method = RequestMethod.POST)
	public int deleteSch(CalendarDTO calendarDTO) throws Exception {
		return calendarService.deleteSch(calendarDTO);
	}
	
	//스케줄 수정
	@ResponseBody
	@RequestMapping(value = "/updateSch", method = RequestMethod.POST)
	public int updateSch(CalendarDTO calendarDTO) throws Exception {
		return calendarService.updateSch(calendarDTO);
	}

	
	
}
