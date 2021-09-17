package com.gudi.map.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.map.dao.MapDAO;
import com.gudi.map.dto.MapDTO;

@Service
public class MapService {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired(required=false) MapDAO dao;
	@Value("#{config['Globals.filePath']}")String root;
	
	public HashMap<String, Object> getAreaInfo(String areaName) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("서비스로 들어온(DAO에 넘겨주는) areaName : {}", areaName);
		// 지역의 후기개수
		int cnt = dao.getReviewCnt(areaName);
		map.put("reviewCnt", cnt);
		// 지역평점
		int rating = dao.getAreaRating(areaName);
		map.put("areaRating", rating);
		return map;
	}

	public HashMap<String, Object> getReviewList(String areaName, String order, HttpSession session) {
		//후기마커 번호, 닉네임, 상세주소, 별점, 썸네일path, 썸네일뉴네임, 댓글 개수, 좋아요 개수, 좋아요 여부, 즐겨찾기 여부
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<MapDTO> list = new ArrayList<MapDTO>();
		
		//정렬기준
		if(order.equals("like")) { //좋아요
			order = "likeCnt";
		}else { //최신순(default)
			order = "reviewDate";
		}
		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId 세션 : ", loginId);
		
		list = (ArrayList<MapDTO>)dao.getReviewList(areaName, order, loginId);
		logger.info("리뷰리스트 개수 : {}",list.size());
		logger.info("리뷰리스트 : {}",list);
		map.put("list", list);
		return map;
	}
	
		@Transactional
		public HashMap<String, Object> rmWrite(MapDTO dto) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			logger.info("작성 서비스 접근");
			boolean success = false;
			int reviewId = 0;
			
			if(dao.rmWrite(dto)>0) {
				HashMap<String, Object> params = new HashMap<String, Object>();
				params.put("areaId", dto.getAreaId());
				params.put("rating", dto.getRating());
				int result = dao.updateAreaRating(params);
				logger.info("지역평점 갱신 성공여부 : {}",result);
				success = true;
				reviewId = dto.getReviewId();
			}
			logger.info("success : {}",success);
			map.put("success", success);		
			map.put("reviewId", reviewId);
			return map;
		}

public HashMap<String, Object> rmFileUpload(MapDTO dto) {
			
			String fileName = dto.getFile().getOriginalFilename();
			String newFileName = System.currentTimeMillis()+fileName.substring(fileName.lastIndexOf("."));	
			int reviewId = dto.getReviewId();
			HashMap<String, Object> map = new HashMap<String, Object>();
			boolean success = false;
			
			try {
				byte[] bytes = dto.getFile().getBytes();
				Path filePath = Paths.get(root+newFileName);
				Files.write(filePath, bytes);
				
				 String path = "/photo/"+newFileName;
				 logger.info("upload path : "+path);
				
				if(dao.rmFileUpload(fileName, newFileName, reviewId)>0) {
					success = true;
				}
				 
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			map.put("success", success);			
			return map;
			
		}
		
		public MapDTO getReviewDetail(int reviewId, String userId) {
			//작성날짜, 글쓴이닉네임, 사진, 내용, 평점, 좋아요개수, 내 좋아요여부, 댓글갯수, 내 즐겨찾기여부
			MapDTO dto = dao.getReviewDetail(reviewId, userId);
			logger.info("상세보기 dto : {}", dto);
			logger.info("댓글수/사진/좋아요수/좋아요여부 : "+dto.getCommentCnt()+"/"+dto.getNewFileName()+"/"+dto.getLikeCnt()+"/"+dto.getIsLike());
			return dto;
		}
		
		public HashMap<String, Object> loadComments(int reviewId, int page, HttpSession session) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int end = page*5;
			int start = end-5+1;

			ArrayList<MapDTO> list = dao.cmtList(start, end, reviewId); 
			
			String loginId = (String) session.getAttribute("loginId");
			logger.info("loginId 세션 : ", loginId);
			
			int totalCnt = dao.allCount();
			logger.info(list.size()+"/"+totalCnt);
			map.put("list", list);
			map.put("totalCnt", totalCnt);
			map.put("currPage", page);
			map.put("loginId", loginId);
			
			int pages = (int) (totalCnt%5 > 0 
					? Math.floor(totalCnt/5)+1 : Math.floor(totalCnt/5));
			
			map.put("pages", pages);
			
			return map;
		}

		public HashMap<String, Object> doLike(int reviewId, String userId) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int success = dao.doLike(reviewId, userId);
			int likeCnt = dao.getLikeCnt(reviewId);
			map.put("success", success);
			map.put("likeCnt", likeCnt);
			return map;
		}

		public HashMap<String, Object> undoLike(int reviewId, String userId) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int success = dao.undoLike(reviewId, userId);
			int likeCnt = dao.getLikeCnt(reviewId);
			map.put("success", success);
			map.put("likeCnt", likeCnt);
			return map;
		}

		public HashMap<String, Object> doBookMark(int reviewId, String userId) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int success = dao.doBookMark(reviewId, userId);
			map.put("success", success);
			return map;
		}

		public HashMap<String, Object> undoBookMark(int reviewId, String userId) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int success = dao.undoBookMark(reviewId, userId);
			map.put("success", success);
			return map;
		}


}
