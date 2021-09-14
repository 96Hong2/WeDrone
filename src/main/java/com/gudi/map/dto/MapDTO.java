package com.gudi.map.dto;

public class MapDTO {
	//후기마커 번호, 닉네임, 상세주소, 별점, 썸네일, 댓글 개수, 좋아요 개수, 좋아요 여부, 즐겨찾기 여부
	private String nickName;
	private String newFileName;
	private String imgPath;
	private String address;
	private int rating;
	private int reviewCnt;
	private int likeCnt;
	private int reviewId;
	private int isLike;
	private int isBookMark;
	private int commentCnt;

	
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
	
	
}
