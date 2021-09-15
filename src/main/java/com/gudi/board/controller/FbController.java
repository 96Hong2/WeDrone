package com.gudi.board.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.board.dto.BoardDTO;
import com.gudi.board.service.BoardService;



@Controller
public class FbController {

	Logger logger = LoggerFactory.getLogger(BoardController.class);
//자유 게시판 컨트롤러 입니다~~
	@Autowired BoardService service;
	
	
	
	 //글쓰기//지윤쓰
		@RequestMapping(value="/fbwriteForm")
		public String fbwriteForm(Model model, HttpSession session) {
			HashMap<String, String> list = new HashMap<String, String>();
			session.setAttribute("fileList", list);
			logger.info("fbwriteForm 요청");		
			return "fbwriteForm";
		}
		
		//지윤쓰
		@RequestMapping(value="/fbwrite")
		public ModelAndView fbwrite(
				@RequestParam HashMap<String, String> params, HttpSession session) {
			logger.info("params : {}",params);
			return service.fbwrite(params,session);
		}
		
		//업로드//지윤쓰
		@RequestMapping(value="/fbuploadForm")
		public String fbuploadForm() {
			return "fbuploadForm";
		}
		
		//지윤쓰
		@RequestMapping(value="/fbupload", method=RequestMethod.POST)
		public ModelAndView fbupload(MultipartFile file, HttpSession session) {
			logger.info("업로드 요청");
			return service.fbfileUpload(file, session);
		}
		
		//삭제//지윤쓰
		@RequestMapping(value="/fbfileDelete")
		public @ResponseBody HashMap<String, Object> 
			fbfileDelete(@RequestParam String fileName, HttpSession session){
			logger.info("파일 삭제 요청 : "+fileName);
			return service.fbfileDelete(fileName, session);
		}
		
		//상세보기//지윤쓰
		@RequestMapping(value="/fbdetail")
		public ModelAndView fbdetail(@RequestParam String postId) {
			logger.info("상세보기 요청 : "+postId);
			return service.fbdetail(postId);
		}
		
		
		//게시판 업데이트//지윤쓰
		@RequestMapping(value = "/fbupdateForm")
		public ModelAndView fbupdateForm(@RequestParam String postId) {
		   logger.info("업데이트 폼 요청");
	        	
		   
		 return service.fbupdateForm(postId);
		}
		
		
		//지윤쓰
		@RequestMapping(value = "/fbupdate")
		public ModelAndView fbupdate(@RequestParam HashMap<String, String> params) {
		    logger.info("업데이트  : {} ",params);
		   
		    
			return service.fbupdate(params);
		}
		
		
		
		
		//지윤쓰
		@RequestMapping(value = "/fbdel")
		public ModelAndView fbdel(Model model, @RequestParam String postId) {
		    logger.info("삭제 요청 : "+postId);
		    
			return service.fbdel(postId);
		}
		
		
		
		
		
		
		
}