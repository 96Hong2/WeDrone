package com.gudi.map.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gudi.map.dao.MapDAO;

@Service
public class MapService {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired(required=false) MapDAO dao;
	
	public HashMap<String, Object> getAreaInfo(String areaName) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("서비스로 들어온(DAO에 넘겨주는) areaName : ", areaName);
		// 지역의 후기개수
		int cnt = dao.getReviewCnt(areaName);
		map.put("reviewCnt", cnt);
		// 지역평점
		int rating = dao.getAreaRating(areaName);
		map.put("areaRating", rating);
		return map;
	}

}
