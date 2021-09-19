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
			//logger.info("댓글수/사진/좋아요수/좋아요여부 : "+dto.getCommentCnt()+"/"+dto.getNewFileName()+"/"+dto.getLikeCnt()+"/"+dto.getIsLike());
			return dto;
		}
		
		public HashMap<String, Object> loadComments(int reviewId, int page, HttpSession session) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int end = page*5;
			int start = end-5+1;
			int pages = 0;

			ArrayList<MapDTO> list = dao.cmtList(start, end, reviewId); 
			
			String loginId = (String) session.getAttribute("loginId");
			logger.info("loginId 세션 : ", loginId);
			
			int totalCnt = dao.allCount(reviewId);
			logger.info("리스트 사이즈 : "+list.size()+"/ 댓글 총 개수"+totalCnt);
			map.put("list", list);
			map.put("totalCnt", totalCnt);
			map.put("currPage", page);
			map.put("loginId", loginId);
			
			
			pages = (int) (totalCnt%5 > 0 
					? Math.floor(totalCnt/5)+1 : Math.floor(totalCnt/5));
			
			
			map.put("pages", pages);
			
			return map;
		}

		public HashMap<String, Object> doLike(int reviewId, String userId) {
			HashMap<String, Object> map = new HashMap<String, Object>(); //리턴할 해시맵
			HashMap<String, Object> informMap = new HashMap<String, Object>(); //알림정보가 들어갈 해시맵
			
			//좋아요 추가
			int success = dao.doLike(reviewId, userId);
			map.put("success", success);
			//좋아요 개수 가져오기
			int likeCnt = dao.getLikeCnt(reviewId);
			map.put("likeCnt", likeCnt);
			
			//알림 보내기
			int informSuccess = 0;
			//알림을 보내기 위해 reviewId를 통해 글작성자의 아이디와 닉네임, 알림수신여부를 가져온다.
			informMap = dao.getWriterInform(reviewId);
			if((informMap.get("CHKALERT")).equals("Y")) {
				String informContent = informMap.get("NICKNAME")+"님의 후기마커에 좋아요가 달렸습니다!";
				String writerId = (String) informMap.get("USERID");
				logger.info(writerId + "의 알림수신 : 수신함 , "+informContent);
				
				//알림수신자의 알림 개수가 20개 이상이면 가장 오래된 알림 제거 후 INSERT
				int informCnt = dao.getInformCnt(writerId);
				//logger.info(writerId+"의 현재 알림개수 "+informCnt+" 개");
				if(informCnt >= 2) {
					int oldInformDel = dao.deleteOldInform(writerId);
					logger.info("현재 알림개수 "+informCnt+"개, 가장 오래된 알림 제거 성공여부: "+oldInformDel);
				}
				
				MapDTO dto = new MapDTO();
				dto.setUserId(writerId); //알림대상유저
				dto.setInformField("likes"); //댓글일 경우 comments
				dto.setRelatedId(reviewId); //후기마커 또는 게시글아이디
				dto.setInformContent(informContent); //알림내용
				
				informSuccess = dao.sendInform(dto);
				if(informSuccess > 0) {
					logger.info("알림 보내기 성공");
					map.put("informSuccess", "success");
				}else {
					logger.info("알림 보내기 실패");
					map.put("informSuccess", "failed");
				}
				
			}else {
				logger.info(informMap.get("USERID") + "의 알림 수신 : X");
				map.put("informSuccess", "blocked");
			}
			
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

		public int deleteReview(int reviewId) {
			int success = dao.deleteReview(reviewId);
			return success;
		}

		public HashMap<String, Object> getMyReviewList(String userId) {
			//후기마커 번호, 닉네임, 상세주소, 별점, 썸네일path, 썸네일뉴네임, 댓글 개수, 좋아요 개수, 좋아요 여부, 즐겨찾기 여부
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			ArrayList<MapDTO> list = new ArrayList<MapDTO>();
			
			list = (ArrayList<MapDTO>)dao.getMyReviewList(userId);
			logger.info("리뷰리스트 개수 : {}",list.size());
			logger.info("리뷰리스트 : {}",list);
			map.put("list", list);
			return map;
		}

		public HashMap<String, Object> rmCmtWrite(MapDTO dto) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			HashMap<String, Object> informMap = new HashMap<String, Object>(); //알림정보가 들어갈 해시맵
            boolean success = false; 
            
            if(dao.rmCmtWrite(dto) > 0) {
            	success = true;
            }
            logger.info("dto :"+dto);
            logger.info("후기마커 댓글 작성 : "+success);
            map.put("success", success);
            
          //알림 보내기
			int informSuccess = 0;
			//알림을 보내기 위해 reviewId를 통해 글작성자의 아이디와 닉네임, 알림수신여부를 가져온다.
			informMap = dao.getWriterInform(dto.getReviewId());
			if((informMap.get("CHKALERT")).equals("Y")) {
				String informContent = informMap.get("NICKNAME")+"님의 후기마커에 댓글이 달렸습니다!";
				String writerId = (String) informMap.get("USERID");
				logger.info(writerId + "의 알림수신 : 수신함 , "+informContent);
				
				//알림수신자의 알림 개수가 20개 이상이면 가장 오래된 알림 제거 후 INSERT
				int informCnt = dao.getInformCnt(writerId);
				//logger.info(writerId+"의 현재 알림개수 "+informCnt+" 개");
				if(informCnt >= 2) {
					int oldInformDel = dao.deleteOldInform(writerId);
					logger.info("현재 알림개수 "+informCnt+"개, 가장 오래된 알림 제거 성공여부: "+oldInformDel);
				}
				
				MapDTO dto2 = new MapDTO();
				dto2.setUserId(writerId); //알림대상유저
				dto2.setInformField("comments"); //댓글일 경우 comments
				dto2.setRelatedId(dto.getReviewId()); //후기마커 또는 게시글아이디
				dto2.setInformContent(informContent); //알림내용
				
				informSuccess = dao.sendInform(dto2);
				if(informSuccess > 0) {
					logger.info("알림 보내기 성공");
					map.put("informSuccess", "success");
				}else {
					logger.info("알림 보내기 실패");
					map.put("informSuccess", "failed");
				}
				
			}else {
				logger.info(informMap.get("USERID") + "의 알림 수신 : X");
				map.put("informSuccess", "blocked");
			}
            
            
            return map;
		}

		public HashMap<String, Object> rmCmtDelete(int cmtId) {
			HashMap<String, Object> map = new HashMap<String, Object>();
            boolean success = false; 
            
            if(dao.rmCmtDelete(cmtId) > 0) {
            	success = true;
            }
            
            map.put("success", success);
            return map;
		}

		public HashMap<String, Object> rmCmtUpdate(MapDTO dto) {
			HashMap<String, Object> map = new HashMap<String, Object>();
            boolean success = false; 
            
            if(dao.rmCmtUpdate(dto) > 0) {
            	success = true;
            }
            logger.info("dto :"+dto);
            logger.info("후기마커 댓글 수정 : "+success);
            map.put("success", success);
			return map;
		}


}
