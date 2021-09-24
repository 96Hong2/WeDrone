package com.gudi.board.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.gudi.board.dto.BoardDTO;
import com.gudi.board.dto.FileDTO;

public interface BoardDAO {

	int fbwrite(BoardDTO dto);

	void fbfileWrite(String key, String string, int postId, String loginNickName);

	BoardDTO fbdetail(String postId);

	ArrayList<FileDTO> fileList(String postId);


	int fbupdate(BoardDTO params);

	int fbdel(String postId);

	int fbcmtwrite(BoardDTO dto);

	ArrayList<BoardDTO> list(int start, int end, int postId);

	int allCount(int postId);

	int fbfileupdate(MultipartFile file);

	int fbcmtupdate(HashMap<String, String> params);

	Object inform(String loginId);

	int fbcmtDel(BoardDTO dto);

	int fbTotalCount(Map<String, Object> map);

	List<Map<String, Object>> fbList(Map<String, Object> map);

	List<Map<String, Object>> fbcmtlist(Map<String, Object> map);

	int fbcmtTotalCount(Map<String, Object> map);

	HashMap<String, Object> getComment(Map<String, Object> map);

	int fbcmtupdate(BoardDTO dto);

	List<String> alarmSendUserList(BoardDTO dto);

	int alarmDelete(Map<String, Object> map);

	int fileDelete(String imgId);

	ArrayList<BoardDTO> newsList();

	ArrayList<BoardDTO> noticeList();

	BoardDTO newsDetail(String postId);

	BoardDTO noticeDetail(String postId);


	
}
