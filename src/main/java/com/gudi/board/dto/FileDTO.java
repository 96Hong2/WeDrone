package com.gudi.board.dto;

import org.apache.ibatis.type.Alias;

@Alias("file")
public class FileDTO {
	
	private int imgId;
	private String oriFileName;
	private String newFileName;
	private String imgField;
	private String postId;
	private String imgPath;
	
	public int getImgId() {
		return imgId;
	}
	public void setImgId(int imgId) {
		this.imgId = imgId;
	}
	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}
	public String getImgField() {
		return imgField;
	}
	public void setImgField(String imgField) {
		this.imgField = imgField;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	
	
}
