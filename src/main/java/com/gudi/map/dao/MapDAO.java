package com.gudi.map.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gudi.map.dto.MapDTO;

public interface MapDAO {
	
	int getReviewCnt(String areaName);

	int getAreaRating(String areaName);

	ArrayList<MapDTO> getReviewList(String areaName, String order, String loginId);

	int rmFileUpload(String fileName, String newFileName);

	int rmWrite(MapDTO dto);

	int updateAreaRating(int areaId, int rating);

	int updateAreaRating(HashMap<String, Object> params);
}






