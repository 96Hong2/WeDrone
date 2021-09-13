package com.gudi.board.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.ui.Model;

import com.gudi.board.dto.BoardDTO;
import com.gudi.board.dto.FileDTO;

public interface BoardDAO {

	int fbwrite(BoardDTO dto);

	void fbfileWrite(String key, String string, int postId);

	BoardDTO fbdetail(String postId);

	ArrayList<FileDTO> fileList(String postId);


	int fbupdate(HashMap<String, String> params);

	int fbdel(String postId);

	int fileupdate(HashMap<String, String> params);

}
