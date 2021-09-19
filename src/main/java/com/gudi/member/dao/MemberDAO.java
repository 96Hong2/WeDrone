package com.gudi.member.dao;

import java.util.HashMap;

import com.gudi.member.dto.MemberDTO;

public interface MemberDAO {

	int join(MemberDTO dto);

	int idCheck(String userId);
	int nickCheck(String nickName);

	HashMap<String, String> login(String userId);	
}
