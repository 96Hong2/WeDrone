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
	
	
}
