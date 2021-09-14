package com.gudi.member.dao;

import com.gudi.member.dto.MemberDTO;

public interface MemberDAO {

	int join(MemberDTO dto);

	int idCheck(String userId);
	int nickCheck(String nickName);

	MemberDTO login(MemberDTO info);	
}
