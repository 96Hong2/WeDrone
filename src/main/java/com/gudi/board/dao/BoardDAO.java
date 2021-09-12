package com.gudi.board.dao;

import java.util.ArrayList;

import com.gudi.board.dto.BoardDTO;
import com.gudi.board.dto.FileDTO;

public interface BoardDAO {

	int fbwrite(BoardDTO dto);

	void fbfileWrite(String key, String string, int postId);

	BoardDTO fbdetail(String postId);

	ArrayList<FileDTO> fileList(String postId);

}
