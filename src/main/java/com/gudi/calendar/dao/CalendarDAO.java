package com.gudi.calendar.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.gudi.calendar.dto.CalendarDTO;

@Repository
public interface CalendarDAO {

	public List<CalendarDTO> showSchedule() throws Exception;

	public int addSchedule(CalendarDTO dto) throws Exception;

	public List<CalendarDTO> selectEventList(Map<String, Object> map) throws Exception;

	public CalendarDTO getEvent(Map<String, Object> map) throws Exception;

	public int deleteSch(CalendarDTO calendarDTO) throws Exception;

	public int updateSch(CalendarDTO calendarDTO) throws Exception;

	
}