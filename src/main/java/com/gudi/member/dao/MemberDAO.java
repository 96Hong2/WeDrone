package com.gudi.member.dao;

import java.util.HashMap;

import com.gudi.member.dto.MemberDTO;

public interface MemberDAO {

	int join(MemberDTO dto);

	int idCheck(String userId);
	int nickCheck(String nickName);

	HashMap<String, String> login(String userId);	
	
	//수빈 내정보, 회원탈퇴
	MemberDTO memberInfo(String id);
	//수빈 내정보, 회원탈퇴
	int memberDel(String id);
	//수빈 내정보, 회원탈퇴
	int update(HashMap<String, String> params);

}
