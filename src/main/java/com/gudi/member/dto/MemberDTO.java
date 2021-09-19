package com.gudi.member.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("member")
public class MemberDTO {

	private String userId;
	private String pw;
	private String nickName;
	private Date regdate;  
	private String chkAlert;
	private String isDel;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getChkAlert() {
		return chkAlert;
	}
	public void setChkAlert(String chkAlert) {
		this.chkAlert = chkAlert;
	}
	public String getIsDel() {
		return isDel;
	}
	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
}
