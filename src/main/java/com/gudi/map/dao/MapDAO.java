package com.gudi.map.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.gudi.map.dto.MapDTO;

public interface MapDAO {
	
	int getReviewCnt(String areaName);

	int getAreaRating(String areaName);

	ArrayList<MapDTO> getReviewList(String areaName, String order, String loginId);

	int rmFileUpload(String fileName, String newFileName, int reviewId);

	int rmWrite(MapDTO dto);

	int updateAreaRating(int areaId, int rating);

	int updateAreaRating(HashMap<String, Object> params);

	MapDTO getReviewDetail(int reviewId, String userId);
	
	int allCount(int reviewId);

	ArrayList<MapDTO> cmtList(int start, int end, int reviewId);

	int doLike(int reviewId, String userId);

	int getLikeCnt(int reviewId);

	int undoLike(int reviewId, String userId);

	int doBookMark(int reviewId, String userId);

	int undoBookMark(int reviewId, String userId);

	int deleteReview(int reviewId);
}






