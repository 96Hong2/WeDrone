package com.gudi.calendar.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gudi.calendar.dao.CalendarDAO;
import com.gudi.calendar.dto.CalendarDTO;

@Service
public class CalendarService {

	@Autowired
	private CalendarDAO calendarDAO;
	
	public List<CalendarDTO> showSchedule() throws Exception {
		return calendarDAO.showSchedule();
	}
	
	public int addSchedule(CalendarDTO dto) throws Exception{
		return calendarDAO.addSchedule(dto);
	}

	public List<CalendarDTO> selectEventList(Map<String, Object> map) throws Exception{
		return calendarDAO.selectEventList(map);
	}

	public CalendarDTO getEvent(Map<String, Object> map) throws Exception{
		return calendarDAO.getEvent(map);
	}

	public int deleteSch(CalendarDTO calendarDTO) throws Exception{
		return calendarDAO.deleteSch(calendarDTO);
	}

	public int updateSch(CalendarDTO calendarDTO) throws Exception{
		return calendarDAO.updateSch(calendarDTO);
	}
	
	
}