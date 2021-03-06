package com.gudi.board.dto;

import java.sql.Date;

public class InformDTO {

	private Integer informId; 
	private String userId;
	private Date informDate;
	private String informField;
	private Integer relatedId;
	private String informContent;
	private String isRead;
	private int countInform;
	private String regUserId;
	private String msgDate;
	
	
	public String getMsgDate() {
		return msgDate;
	}
	public void setMsgDate(String msgDate) {
		this.msgDate = msgDate;
	}
	public String getRegUserId() {
		return regUserId;
	}
	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}
	public Integer getInformId() {
		return informId;
	}
	public void setInformId(Integer informId) {
		this.informId = informId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getInformDate() {
		return informDate;
	}
	public void setInformDate(Date informDate) {
		this.informDate = informDate;
	}
	public String getInformField() {
		return informField;
	}
	public void setInformField(String informField) {
		this.informField = informField;
	}
	public Integer getRelatedId() {
		return relatedId;
	}
	public void setRelatedId(Integer relatedId) {
		this.relatedId = relatedId;
	}
	public String getInformContent() {
		return informContent;
	}
	public void setInformContent(String informContent) {
		this.informContent = informContent;
	}
	public String getIsRead() {
		return isRead;
	}
	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}
	
	public int getCountInform() {
		return countInform;
	}
	public void setCountInform(int countInform) {
		this.countInform = countInform;
	}
	@Override
	public String toString() {
		return "InformDTO [informId=" + informId + ", userId=" + userId + ", informDate=" + informDate
				+ ", informField=" + informField + ", relatedId=" + relatedId + ", informContent=" + informContent
				+ ", isRead=" + isRead + ", countInform=" + countInform + "]";
	}


	
	
	
}

