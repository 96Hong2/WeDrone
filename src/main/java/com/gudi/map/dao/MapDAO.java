package com.gudi.map.dao;

import java.util.ArrayList;

import com.gudi.map.dto.MapDTO;

public interface MapDAO {
	
	int getReviewCnt(String areaName);

	int getAreaRating(String areaName);

	ArrayList<MapDTO> getReviewList(String areaName, String order, String loginId);
}






