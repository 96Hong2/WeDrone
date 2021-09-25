package com.gudi.board.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("board")
public class BoardDTO {
	
	private int postId;
	private String title;
	private String postContent;
	private Date postDate;
	private String postField;
	private String postDel;
	private String nickName;
	private String userId;
	private String cmtId;
	private String cmtContent;
	private Date cmtDate;
	private String isDel;
	private String cmtField;
	private int informId;
	private Date informDate;
	private String informField;
	private int relateId;
	private String informContent;
	private String postedUserId;
	private String postedTitle;
	private String regUserid;
	private int cmtCnt;
	
	
	public int getCmtCnt() {
		return cmtCnt;
	}
	public void setCmtCnt(int cmtCnt) {
		this.cmtCnt = cmtCnt;
	}
	public int getInformId() {
		return informId;
	}
	public void setInformId(int informId) {
		this.informId = informId;
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
	public int getRelateId() {
		return relateId;
	}
	public void setRelateId(int relateId) {
		this.relateId = relateId;
	}
	public String getInformContent() {
		return informContent;
	}
	public void setInformContent(String informContent) {
		this.informContent = informContent;
	}
	public String getCmtId() {
		return cmtId;
	}
	public void setCmtId(String cmtId) {
		this.cmtId = cmtId;
	}
	public String getCmtContent() {
		return cmtContent;
	}
	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}
	public Date getCmtDate() {
		return cmtDate;
	}
	public void setCmtDate(Date cmtDate) {
		this.cmtDate = cmtDate;
	}
	public String getIsDel() {
		return isDel;
	}
	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}
	public String getCmtField() {
		return cmtField;
	}
	public void setCmtField(String cmtField) {
		this.cmtField = cmtField;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPostContent() {
		return postContent;
	}
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	public Date getPostDate() {
		return postDate;
	}
	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}
	public String getPostField() {
		return postField;
	}
	public void setPostField(String postField) {
		this.postField = postField;
	}
	public String getPostDel() {
		return postDel;
	}
	public void setPostDel(String postDel) {
		this.postDel = postDel;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPostedUserId() {
		return postedUserId;
	}
	public void setPostedUserId(String postedUserId) {
		this.postedUserId = postedUserId;
	}	
	public String getPostedTitle() {
		return postedTitle;
	}
	public void setPostedTitle(String postedTitle) {
		this.postedTitle = postedTitle;
	}
	
	public String getRegUserid() {
		return regUserid;
	}
	public void setRegUserid(String regUserid) {
		this.regUserid = regUserid;
	}
	
	@Override
	public String toString() {
		return "BoardDTO [postId=" + postId + ", title=" + title + ", postContent=" + postContent + ", postDate="
				+ postDate + ", postField=" + postField + ", postDel=" + postDel + ", nickName=" + nickName
				+ ", userId=" + userId + ", cmtId=" + cmtId + ", cmtContent=" + cmtContent + ", cmtDate=" + cmtDate
				+ ", isDel=" + isDel + ", cmtField=" + cmtField + ", informId=" + informId + ", informDate="
				+ informDate + ", informField=" + informField + ", relateId=" + relateId + ", informContent="
				+ informContent + ", postedUserId=" + postedUserId + ", postedTitle=" + postedTitle + ", regUserid="
				+ regUserid + "]";
	}
	
	
	
	
}
