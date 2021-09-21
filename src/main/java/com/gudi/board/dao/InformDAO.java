package com.gudi.board.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.gudi.board.dto.BoardDTO;
import com.gudi.board.dto.InformDTO;

@Repository//handler를 사용할 수 있게 repository 설정
public interface InformDAO {

	public Integer countInform(String userid);

	public List<Map<String, Object>> selectInform(String userid);

	public List<InformDTO> selectInformDTO(String userid);

	public int insertInform(BoardDTO dto);

	public int informCount(Map<String, Object> map);

	public List<Map<String, Object>> selectListInform(Map<String, Object> map);

	public int alarmAllRead(Map<String, Object> map);

	public int alarmRead(Map<String, Object> map);

	public InformDTO selectLsatInform(String userId);


	
}


