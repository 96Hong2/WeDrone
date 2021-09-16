package com.gudi.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.gudi.board.dto.BoardDTO;
import com.gudi.board.dto.FileDTO;

public interface BoardDAO {

	int fbwrite(BoardDTO dto);

	void fbfileWrite(String key, String string, int postId, String loginNickName);

	BoardDTO fbdetail(String postId);

	ArrayList<FileDTO> fileList(String postId);


	int fbupdate(HashMap<String, String> params);

	int fbdel(String postId);

	int fbcmtwrite(BoardDTO dto);

	ArrayList<BoardDTO> list(int start, int end);

	int allCount();

	void fbfileupdate(MultipartFile file);




	
}
