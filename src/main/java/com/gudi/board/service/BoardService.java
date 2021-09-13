package com.gudi.board.service;

import java.io.File;
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
import org.springframework.web.servlet.ModelAndView;

import com.gudi.board.dao.BoardDAO;
import com.gudi.board.dto.BoardDTO;
import com.gudi.board.dto.FileDTO;

@Service
public class BoardService {

@Autowired BoardDAO dao;

Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Value("#{config['Globals.filePath']}")String root;
	
	

	@Transactional
	public ModelAndView fbwrite(HashMap<String, String> params, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/fbwriteForm";		
		HashMap<String, String> fileList 
			= (HashMap<String, String>) session.getAttribute("fileList");
		
		
		BoardDTO dto = new BoardDTO();
		dto.setTitle(params.get("title"));
		dto.setPostContent(params.get("postContent"));
		dto.setNickName(params.get("nickName"));
		
		if(dao.fbwrite(dto)>0) {
			page = "redirect:/fbdetail?postId="+dto.getPostId();			
			if(fileList.size()>0) {
				for(String key : fileList.keySet()) {
					dao.fbfileWrite(key, fileList.get(key), dto.getPostId());
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
		
		return mav;
	}

	public ModelAndView fbfileUpload(MultipartFile file, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("fbuploadForm");
		
		//1. 파일명 추출
		String fileName = file.getOriginalFilename();		
		//2. 신규 파일명
		String newFileName = System.currentTimeMillis()+fileName.substring(fileName.lastIndexOf("."));
				
		//3.파일 다운로드
		try {
			byte[] bytes = file.getBytes();
			//이 저장 방법은 java 7 부터 가능(java.nio)
			Path filePath = Paths.get(root+newFileName);//경로 지정
			Files.write(filePath, bytes);//저장
			//4. 저장된 파일 호출 경로 추출
			String path = "/photo/"+newFileName;			
			logger.info("upload path : "+path);		
			//5. mav 에 저장하여 전송
			mav.addObject("path", path);	
			
			//업로드된 파일목록을 세션에 저장
			HashMap<String, String> fileList 
				= (HashMap<String, String>) session.getAttribute("fileList");
			fileList.put(newFileName, fileName);
			logger.info("업로드된 파일 수 : "+fileList.size());
			session.setAttribute("fileList", fileList);
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}		
		return mav;
	}

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

	@Transactional
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
	
}
