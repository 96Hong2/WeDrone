package com.gudi.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.gudi.board.dto.BoardDTO;
import com.gudi.board.service.BoardService;
import com.gudi.board.service.InformService;
import com.gudi.util.PageMaker;



@Controller
public class FbController {

	Logger logger = LoggerFactory.getLogger(BoardController.class);
//자유 게시판 컨트롤러 입니다~~
	@Autowired BoardService service;
	
	@Autowired
	InformService informService;
	
	@RequestMapping(value = "/fbList")
	public String fbList(PageMaker pageMaker,  Model model, Map<String, Object> map, HttpServletRequest request) {
		int totalCount=service.fbTotalCount(map);
		pageMaker.setTotPage(totalCount);
		map.put("pageBegin", pageMaker.getPageBegin());
		map.put("pageEnd", pageMaker.getPageEnd());
		List<Map<String, Object>> list=service.fbList(map);
		String pagination=pageMaker.bootStrapPagingHTML(request.getContextPath()  +"/fbList");
		
		model.addAttribute("list",list);
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("pagination", pagination);
		return "fbList";
	}
	

	// 글쓰기//지윤쓰
	@RequestMapping(value = "/fbwriteForm")
	public String fbwriteForm(Model model, HttpSession session) {
		HashMap<String, String> list = new HashMap<String, String>();
		session.setAttribute("fileList", list);
		logger.info("fbwriteForm 요청");
		return "fbwriteForm";
	}

	// 지윤쓰
	@RequestMapping(value = "/fbwrite" ,method = RequestMethod.POST)
	public String fbwrite(@RequestParam(value="file",required=false) List<MultipartFile> file ,BoardDTO param , HttpSession session) {
		BoardDTO result=service.fbwrite(param, session);		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("postId", result.getPostId());
		service.fbfileUpload(file, session ,map);		
		return "redirect:/fbList";
	}

	// 업로드//지윤쓰
	@RequestMapping(value = "/fbuploadForm")
	public String fbuploadForm() {
		return "fbuploadForm";
	}

	// 지윤쓰
//	@RequestMapping(value = "/fbupload", method = RequestMethod.POST)
//	public ModelAndView fbupload(MultipartFile file, HttpSession session) {
//		logger.info("업로드 요청");
//		return service.fbfileUpload(file, session);
//	}

	// 삭제//지윤쓰
	@RequestMapping(value = "/fbfileDelete")
	public @ResponseBody HashMap<String, Object> fbfileDelete(@RequestParam String fileName, HttpSession session) {
		logger.info("파일 삭제 요청 : " + fileName);
		return service.fbfileDelete(fileName, session);
	}

	// 상세보기//지윤쓰
	@RequestMapping(value = "/fbdetail")
	public ModelAndView fbdetail(@RequestParam String postId) {
		logger.info("상세보기 요청 : " + postId);
		return service.fbdetail(postId);
	}

	// 게시판 업데이트//지윤쓰
	@RequestMapping(value = "/fbupdateForm")
	public ModelAndView fbupdateForm(MultipartFile file, @RequestParam String postId, HttpSession session) {
		logger.info("업데이트 폼 요청");

		return service.fbupdateForm(file, postId, session);
	}


	@Transactional
	@RequestMapping(value = "/fbupdate" ,method = RequestMethod.POST)
	public String fbupdate(@RequestParam(value="file",required=false) List<MultipartFile> file ,BoardDTO param , HttpSession session) {
		int result=service.fbupdate(param, session);
		if(result==1) {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("postId", param.getPostId());
			service.fbfileUpload(file, session ,map);			
		}		
		return "redirect:/fbdetail?update=ok&postId="+param.getPostId();	
	}

	
	
	
	@RequestMapping(value = "/fileDelete")
	@ResponseBody
	public int fileDelete(@RequestParam String imgId) {
		logger.info("파일 삭제 : " + imgId);
		return service.fileDelete(imgId);
	}
	
	

	@RequestMapping(value = "/fbdel")
	public ModelAndView fbdel(Model model, @RequestParam String postId) {
		logger.info("삭제 요청 : " + postId);
		return service.fbdel(postId);
	}

	
	@RequestMapping("/alarmAllRead")
	public String alarmAllRead(Map<String, Object> map, HttpSession session) throws Exception {
		map.put("userid", (String)session.getAttribute("loginId") );
		informService.alarmAllRead(map);
		return "redirect:alarmlist";
	}
		
		
	@RequestMapping("/alarmLinkMove")
	public String alarmLinkMove(@RequestParam Map<String, Object> map, HttpSession session) throws Exception {
		String postId=(String)map.get("postId");			
		map.put("userid", (String)session.getAttribute("loginId") );
		informService.alarmRead(map);
		return "redirect:fbdetail?postId="+postId;
	}
	
	@RequestMapping(value = "/alarmDelete", method = RequestMethod.POST)
	@ResponseBody
	public int alarmDelete(@RequestParam Map<String, Object> map) {							
		return service.alarmDelete(map);
	}
		
		
	
		
		
}