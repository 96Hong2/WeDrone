package com.gudi.map.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class MapDTO {
	private String nickName;
	private String newFileName;
	private String imgPath;
	private String address;
	private String reviewContent;
	private String userId;
	private double lat;
	private double lon;
	private int reviewCnt;
	private int likeCnt;
	private int reviewId;
	private int isLike;
	private int isBookMark;
	private int commentCnt;
	private int rating;
	private int areaId;
	private String reviewDate;
	private String myLocTime;
	private int myLocId;
	
	private String cmtContent;
	private Date cmtDate;
	private int cmtId;
	
	private String areaName;
	
	private MultipartFile file;

	//알림관련
	private String informField;
	private int relatedId;
	private String informContent;
	
	
	public int getMyLocId() {
		return myLocId;
	}
	public void setMyLocId(int myLocId) {
		this.myLocId = myLocId;
	}
	public String getMyLocTime() {
		return myLocTime;
	}
	public void setMyLocTime(String myLocTime) {
		this.myLocTime = myLocTime;
	}
	public String getInformField() {
		return informField;
	}
	public void setInformField(String informField) {
		this.informField = informField;
	}
	public int getRelatedId() {
		return relatedId;
	}
	public void setRelatedId(int relatedId) {
		this.relatedId = relatedId;
	}
	public String getInformContent() {
		return informContent;
	}
	public void setInformContent(String informContent) {
		this.informContent = informContent;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	public int getIsLike() {
		return isLike;
	}
	public void setIsLike(int isLike) {
		this.isLike = isLike;
	}
	public int getIsBookMark() {
		return isBookMark;
	}
	public void setIsBookMark(int isBookMark) {
		this.isBookMark = isBookMark;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}
	public String getImgPath() {
		return imgPath;
	}
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getReviewCnt() {
		return reviewCnt;
	}
	public void setReviewCnt(int reviewCnt) {
		this.reviewCnt = reviewCnt;
	}
	public int getLikeCnt() {
		return likeCnt;
	}
	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}
	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	public int getAreaId() {
		return areaId;
	}
	public void setAreaId(int areaId) {
		this.areaId = areaId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
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
	public int getCmtId() {
		return cmtId;
	}
	public void setCmtId(int cmtId) {
		this.cmtId = cmtId;
	}

	
	
}
