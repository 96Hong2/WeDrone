package com.gudi.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gudi.board.dao.InformDAO;
import com.gudi.board.dto.InformDTO;


@Service
public class InformService {

	@Autowired
	InformDAO dao;

	Logger logger = LoggerFactory.getLogger(this.getClass());

	
	public Integer countInform(String  userid) {
		return dao.countInform(userid);
	}


	public List<Map<String, Object>> selectInform(String userid) {
		return dao.selectInform(userid);
	}


	public List<InformDTO> selectInformDTO(String userid) {
		return dao.selectInformDTO(userid);
	}


	public int informCount(Map<String, Object> map) {
		return dao.informCount(map);
	}


	public List<Map<String, Object>> selectListInform(Map<String, Object> map) {
		return dao.selectListInform(map);
	}


	public int alarmAllRead(Map<String, Object> map) {
		return dao.alarmAllRead(map);		
	}


	public int alarmRead(Map<String, Object> map) {
		return dao.alarmRead(map);				
	}


	public InformDTO selectLsatInform(String userId) {
		return dao.selectLsatInform(userId);
	}
	
	public int insertWeather(Map<String, String> paramMap) {
		return dao.insertWeather(paramMap);		
	}


	public Map<String, String> getWeather() {
		return dao.getWeather();
	}


	public HashMap<String, Object> getReqList(String loginId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<InformDTO> list = dao.getReqList(loginId);
		map.put("list", list);
		return map;
	}
	

}


