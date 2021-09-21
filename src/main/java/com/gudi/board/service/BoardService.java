package com.gudi.board.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.gudi.board.dao.BoardDAO;
import com.gudi.board.dao.InformDAO;
import com.gudi.board.dto.BoardDTO;
import com.gudi.board.dto.FileDTO;


@Service
public class BoardService {

@Autowired BoardDAO dao;

@Autowired
InformDAO informDAO;


Logger logger = LoggerFactory.getLogger(this.getClass());
	
//자유 게시판 서비스 입니다~~
	@Value("#{config['Globals.filePath']}")
	String root;
	

	//게시판 글쓰기//지윤쓰
	@Transactional
	public BoardDTO fbwrite(BoardDTO  dto, HttpSession session) {
		//상대 경로 업로드
		root=session.getServletContext().getRealPath("/")+"resources" +File.separator+"upload"+File.separator;
		File file=new File(root);
		if(!file.isDirectory()) {
			file.mkdir();
		}
		
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/fbwriteForm";		
		HashMap<String, String> fileList 
			= (HashMap<String, String>) session.getAttribute("fileList");
		
		
		//session.setAttribute("loginNickName","jiyun");//테스트 용
		String loginNickName= (String) session.getAttribute("loginNickName");
		dto.setNickName(loginNickName);
		dto.setUserId((String) session.getAttribute("loginId"));
		logger.info("loginNickName : ",loginNickName);
		
		if(dao.fbwrite(dto)>0) {
			//page = "redirect:/fbdetail?postId="+dto.getPostId();
			page="redirect:/fbList";
			if(fileList.size()>0) {
				for(String key : fileList.keySet()) {
					dao.fbfileWrite(key, fileList.get(key), dto.getPostId(),loginNickName);
				}
			}			
		}else {	
			if(fileList.size()>0) {
				//업로드된 파일 삭제
				for(String key : fileList.keySet()) {
					new File(root+key).delete();
				}				
			}			
			//세션에서 파일리스트 삭제
			session.removeAttribute("fileList");
		}				
		mav.setViewName(page);
		
		return dto;
	}

	//파일 업로드//지윤쓰
	public ModelAndView fbfileUpload(List<MultipartFile> multipartFile, HttpSession session,Map<String, Object> map) {
		//상대 경로 업로드
		root=session.getServletContext().getRealPath("/")+"resources" +File.separator+"upload"+File.separator;
		File rootDir=new File(root);
		if(!rootDir.isDirectory()) {
			rootDir.mkdir();
		}
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("fbuploadForm");
		
		// 파일이 있을때 탄다.
	    if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
		
				for (MultipartFile file : multipartFile) {
		
						
					//1. 파일명 추출
					String fileName = file.getOriginalFilename();
					if(fileName!=null && !fileName.equals("")) {
						//2. 신규 파일명
						String newFileName = System.currentTimeMillis()+fileName.substring(fileName.lastIndexOf("."));
								
						//3.파일 다운로드
						try {
							byte[] bytes = file.getBytes();
							//이 저장 방법은 java 7 부터 가능(java.nio)
							Path filePath = Paths.get(root+newFileName);//경로 지정
							Files.write(filePath, bytes);//저장
							String ext = fileName.substring(fileName.lastIndexOf(".") + 1);
							map.put("oriFileName", fileName);
							map.put("newFileName", newFileName);
							map.put("imgField", "post");
							map.put("imgPath", "upload");
							map.put("ext", ext.toUpperCase());
							informDAO.fileWrite(map);
							
							
						} catch (IOException e) {
							e.printStackTrace();
						}
					}				
				}		
	    }
		return mav;
	}

	//파일 삭제//지윤쓰
	public HashMap<String, Object> fbfileDelete(String fileName, HttpSession session) {		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		boolean success = false;		
		File delFile = new File(root+fileName);
		
		if(delFile.exists()) {
			success = delFile.delete();
		}
		
		if(success) {
			HashMap<String, String> fileList 
				= (HashMap<String, String>) session.getAttribute("fileList");			
			fileList.remove(fileName);			
			logger.info("업로드된 파일 수 : "+fileList.size());
			session.setAttribute("fileList", fileList);
		}
		
		
		logger.info("file delete success : "+success);
		map.put("success", success);
		
		return map;
	}

	//게시판 상세보기//지윤쓰
	public ModelAndView fbdetail(String postId) {		
		ModelAndView mav = new ModelAndView();
		BoardDTO dto = dao.fbdetail(postId);//글의 상세 정보
		mav.addObject("post", dto);
		
		ArrayList<FileDTO> fileList = dao.fileList(postId);
		mav.addObject("fileList",fileList);
		
		//해당 글의 파일 정보		
		mav.setViewName("fbdetail");

		return mav;
	}

	       //게시판 수정 폼//지윤쓰
			public ModelAndView fbupdateForm(MultipartFile file, String postId, HttpSession session) {
				ModelAndView mav = new ModelAndView();
				mav.addObject("post", dao.fbdetail(postId));
				mav.setViewName("fbupdateForm");
				dao.fbfileupdate(file);
				
				
				ArrayList<FileDTO> fileList = dao.fileList(postId);
				mav.addObject("fileList",fileList);
				
				return mav;
			}

			//게시판 수정//지윤쓰
			public int fbupdate(BoardDTO params, HttpSession session) {				
				return dao.fbupdate(params);		
			}

			//게시판 삭제//지윤쓰
			public ModelAndView fbdel(String postId) {
				int success = dao.fbdel(postId);
				ModelAndView mav = new ModelAndView();
				mav.setViewName("redirect:/fbList");
				
				return mav;
			}

			public HashMap<String, Object> fbcmtwrite(BoardDTO dto) {
				HashMap<String, Object> map = new HashMap<String, Object>();				
				int success = dao.fbcmtwrite(dto);
				logger.info("dto :"+dto);
				logger.info("자유 게시판 댓글 쓰기 성공 여부 "+success);
				map.put("success", success);

				dto.setInformField("Fbpost");
				dto.setRelateId(dto.getPostId());
				dto.setInformContent(" '" +dto.getPostedTitle() +"' 의 게시글에 댓글이 달렸습니다.");
								
				if(success==1) {
					/** 현재 댓글 작성자는 제외 발송 */
					dto.setRegUserid(dto.getUserId());
					List<String> alarmSendUserList=dao.alarmSendUserList(dto);
					
					/** 게시글 작성자와 댓글 작성자가 같지 않으면 알림 발송 */
					if(!dto.getUserId().equals(dto.getPostedUserId())) {											
						/** 1.게시판 글 작성자 PostedUserId 에게 발송  */
						logger.info("1.게시판 글 작성자 PostedUserId 에게 발송 ");
						dto.setUserId(dto.getPostedUserId());
						informDAO.insertInform(dto);
					}
					
										
					for(String str:alarmSendUserList){
						if(!str.equals(dto.getPostedUserId())) {
							/** 2.댓글 작성자  에게 발송  */
							logger.info("2.댓글 작성자  에게 발송 :  {} ", str);
							dto.setUserId(str);
							informDAO.insertInform(dto);
						}						
					}			
				}
								
				return map;
			}
					
										
				

			public HashMap<String, Object> list(int page,HttpSession session, int postId) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				
				int end = page*5;
				int start = end-5+1;
				int pages = 0;

				ArrayList<BoardDTO> list = dao.list(start, end, postId); 
				
				String loginId = (String) session.getAttribute("loginId");
				logger.info("loginId 세션 : ", loginId);
				
				int totalCnt = dao.allCount(postId);
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

			//게시판 댓글 수정//지윤쓰
			public HashMap<String, Object> fbcmtupdate(BoardDTO dto, HttpSession session) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				int success = dao.fbcmtupdate(dto);
				logger.info("dto :"+dto);
				logger.info("자유 게시판 글 수정 성공 여부 "+success);
				map.put("success", success);
				return map;

			}

		
			

			public HashMap<String, Object> fbcmtDel(BoardDTO dto, HttpSession session) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				int success = dao.fbcmtDel(dto);
				logger.info("게시판 댓글 dto:"+dto);
				logger.info("자유 게시판 댓글 삭제 성공 여부 "+success);
				map.put("success", success);
				return map;
			}

			public int fbTotalCount(Map<String, Object> map) {				
				return dao.fbTotalCount(map);
			}

			public List<Map<String, Object>> fbList(Map<String, Object> map) {
				return dao.fbList(map);
			}

			public List<Map<String, Object>> fbcmtlist(Map<String, Object> map) {
				return dao.fbcmtlist(map);
			}

			public int fbcmtTotalCount(Map<String, Object> map) {
				return dao.fbcmtTotalCount(map);
			}

			public HashMap<String, Object> getComment(Map<String, Object> map) {
				return dao.getComment(map);
			}

			public List<String> alarmSendUserList(BoardDTO dto) {
				return dao.alarmSendUserList(dto);
			}

			public int alarmDelete(Map<String, Object> map) {
				return dao.alarmDelete(map);
			}

			public int fileDelete(String imgId) {
				return dao.fileDelete(imgId);
			}

		
			
	
}











