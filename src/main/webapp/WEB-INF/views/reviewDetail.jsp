<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous">
	
</script>
<link href="${path}/resources/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500&display=swap"
	rel="stylesheet">

<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css"
	integrity="sha384-wESLQ85D6gbsF459vf1CiZ2+rr+CsxRY0RpiF1tLlQpDnAgg6rwdsUF1+Ics2bni"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<link href="${path}/resources/css/main.css?ver=95" rel="stylesheet">
<link href="${path}/resources/css/reviewDetail.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js"></script>
</head>
<body>
	<div id="detailModal" class="modal revModal fade" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="reviewTitle"></h5>
					<button class="btn btn-default" type="button" data-dismiss="modal"
						aria-label="Close" id="close">
						<span aria-hidden="true">X</span>
					</button>
				</div>
				<div class="modal-body">
					<div class='revContainer'>
						
					</div>

					<hr />
					<div id='commentArea'>
						<div class="container px-4 my-4" id="rm_commentWrap">
		<h3 id="comments" class="fw-bold mt-3">댓글</h3>
				<hr />
				<c:if test="${sessionScope.loginNickName == null}">
					<div class="d-flex align-items-center">
						<div class="form-floating flex-grow-1 px-2">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="commentContent" id="commentContent"
								style="height: 100px; resize: none;"></textarea>
							<div class="invalid-feedback">1자 이상 입력해주세요.</div>
							<label for="commentContent">로그인 후 이용해주세요.</label>
						</div>
					</div>
				</c:if>
				
				<c:if test="${sessionScope.loginNickName != null}">
					<div class="d-flex align-items-center">
						<div class="form-floating flex-grow-1 px-2">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="commentContent" id="commentContent"
								style="height: 100px; resize: none;"></textarea>
							<div class="invalid-feedback">1자 이상 입력해주세요.</div>
							<label for="commentContent">${loginId}님, 이곳에 댓글을 작성하세요</label>
						</div>
						<a type="button" id="rmCommentBtn" class="btn btn-secondary btn-sm" title="글아이디">등록</a>
					</div>
				</c:if>
				
				<div id="commentLists" class="container px-5 py-4 my-4">
					<!--<c:forEach items="123456789" var="commentLists">
						<div class="updateCheck">
							<p class="fw-bold">dddddddd</p>
							<p class="lh-sm">
								dddddddd
								<c:if test="${sessionScope.loginId eq sessionScope.loginId}">
									<a id="commentDelBtn"
										class='commentDelBtn ms-2 float-end btn btn-secondary btn-sm'
										title="123456789">삭제</a>
									<a class='commentUpdateBtn float-end btn btn-secondary btn-sm'>수정</a>
								</c:if>
							</p>
							<hr />
						</div>
						<div class="updateForm visually-hidden" id="updateForm">
							<p class="fw-bold">123456789$</p>
							<div class="form-floating flex-grow-1 px-2">
								<textarea class="commentUpdateContent form-control"
									placeholder="Leave a comment here" name="commentUpdateContent"
									id="commentUpdateContent" style="height: 100px; resize: none;">123456789</textarea>
								<label for="commentUpdateContent">수정할 댓글을 작성하세요</label>
								<div class="invalid-feedback">1자 이상 입력해주세요</div>
							</div>
							<div class="d-flex justify-content-end mt-2"
								id="commentUpdateOut">
								<a class='commentUpdateContentBtn btn btn-secondary btn-sm mx-2'
									id="commentUpdateContentBtn" title="123456789">등록</a>
								<a class='cmUpdateCancel btn btn-secondary btn-sm'>취소</a>
							</div>
							<hr />
						</div>
					</c:forEach>-->
				</div>
				<div class="container px-5 py-4 my-4" id="pagination_area">
					<div class="pageContainer">
								<nav aria-lable="Page navigation" style="text-align:center">
									<ul class="pagination" id="pagination"></ul>
								</nav>
								</div>
				</div>
		</div>

					</div>

				</div>
				<div class="modal-footer">
					<!-- <a class="btn" id="modalY" href="#">예</a>
					<button class="btn" type="button" data-dismiss="modal">아니요</button> -->
					<!-- <button type="button" class="btn btn-default"
						data-dismiss="modal" id="close">닫기</button> -->
				</div>
			</div>
		</div>
	</div>
</body>
<script>

	//모달창 닫기
	$('#close').click(function(e) {
		$('#detailModal').modal('hide');
	});
	

	
function loadReviewDetail(reviewId, userId, tab){
	$('.revContainer').empty();
	$('#reviewTitle').empty();
	
	var currPage = 1;
	
	console.log("reviewId : ", reviewId);
	console.log("userId : ", userId);
	//상세정보 불러오기 
	$.ajax({
		url : 'getReviewDetail',
		type : 'POST',
		data : {
			"reviewId" : reviewId,
			"userId" : userId
		},
		dataType : 'JSON',
		success : function(review) {
			console.log("review dto: ",review);
			//작성날짜, 글쓴이닉네임, 사진, 내용, 평점, 좋아요개수, 내 좋아요여부, 댓글갯수, 내 즐겨찾기여부
			$('#reviewTitle').append("<b>"+review.nickName+" 님의 후기마커</b>");
			
			//평점(구름아이콘)
			var rating = "";
			for(var i=0; i<review.rating; i++){
			    rating +="<img src='resources/img/cloud.png' class='revRatingImg'>";
			}
			
			var content = "";
			content = "<input type='hidden' id='reviewId' value="+reviewId+"/>" 
			+"<div class='revContainer1'>"
			+"<img class='reviewImg' src='/photo/"+review.newFileName+"' />"
			+"</div>"
			+"<div class='revContainer2'>"
			+"<div id='revContent'>"+review.reviewContent+"</div>"
			+"<div id='revRating'>"
			+ rating
			+"</div>"
			+"<div id='revAddress'>"+review.address+"</div>"
			+"<div id='revDate'>"+review.reviewDate+"</div>";
			
			if(review.userId == userId){
				content += "<div style='margin:10px;'><span><button type='button' class='btn btn-outline-primary myRevBtns'>수정하기</button></span>";
				content += "<span><button type='button' onclick='deleteReview("+reviewId+",\""+review.areaName+"\",\""+tab+"\")' class='btn btn-outline-danger myRevBtns'>삭제하기</button></span></div>";
				content += "<div class='revContainer2_1' style='margin-top : 10px;'>";
			}else{
				content += "<div class='revContainer2_1' style='margin-top : 60px;'>";
			}
			content += "<div class='revLikeContainer'>";
			
			if(review.isLike > 0){
				content += "<a href='javascript:undoLike("+reviewId+",\""+userId+"\",\""+review.areaName+"\",\""+tab+"\")' class='likeAnchor'>";
                content += "<div class='revLike'>";
                content += "<img src='resources/img/like2_full.png' class='revLikeImg'> 좋아요 ";
                content += "<b>"+review.likeCnt+"</b></div></a>";
             }else{
            	content += "<a href='javascript:doLike("+reviewId+",\""+userId+"\",\""+review.areaName+"\",\""+tab+"\")' class='likeAnchor'>";
                content += "<div class='revLike'>";
                content += "<img src='resources/img/like2_empty.png' class='revLikeImg'> 좋아요 ";
                content += "<b>"+review.likeCnt+"</b></div></a>";
             }
			
			content += "</div>";
			content += "<div id='revCmt'><img src='resources/img/comment.png' class='revCommentImg'> 댓글 <b id='rm_cmtCnt'>"+review.commentCnt+"</b></div>";
			
			content += "<div class='revBookMarkContainer'>";
			if(review.isBookMark > 0){
				content += "<a href='javascript:undoBookMark("+reviewId+",\""+userId+"\",\""+review.areaName+"\",\""+tab+"\")' class='likeAnchor'>";
				content += "<div class='revBookMark'><img src='resources/img/star.png' class='revBookMarkImg'></div></a>";
             }else{
            	content += "<a href='javascript:doBookMark("+reviewId+",\""+userId+"\",\""+review.areaName+"\",\""+tab+"\")' class='likeAnchor'>";
            	content += "<div class='revBookMark'><img src='resources/img/star2.png' class='revBookMarkImg'></div></a>";
             }
			
			content += "</div></div></div>"; //end .revContainer2_1, .revContainer2
            
			
			$('.revContainer').append(content);
			
			loadComments(reviewId, currPage);	
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
	
} //end loadReviewDetail()

function deleteReview(reviewId, areaName, tab){
	//console.log("reviewId/areaName 삭제: "+reviewId+"/"+areaName);
	
	$.ajax({
		url : 'deleteReview',
		type : 'GET',
		data : {
			"reviewId" : reviewId,
		},
		dataType : 'JSON',
		success : function(data) {
			//console.log("data : ",data);
			if(data > 0){
				alert("후기마커 삭제가 완료되었습니다.");

				if(tab == "reviewMK"){
					//후기마커 탭이라면? 해당지역 후기마커리스트 새로고침
					loadReviews(areaName, 'default');
				}else if(tab == "myReviewMK"){
					//내후기마커 탭이라면? 내 후기마커리스트 새로고침
					loadMyReviews("${sessionScope.loginId}");
				}else{
					//즐겨찾기 탭이라면? 즐겨찾기한 후기마커 리스트 새로고침
					alert("즐겨찾기 탭 새로고침!");
				}
				
				//모달창 닫기
				$('#detailModal').modal('hide');
			}else{
				alert("후기마커 삭제에 실패했습니다.");
			}
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
	
}

function doLike(reviewId, userId, areaName, tab){
	console.log("좋아요 reviewId/userId : "+reviewId+"/"+userId);
	
	$.ajax({
		url : 'doLike',
		type : 'GET',
		data : {
			"reviewId" : reviewId,
			"userId" : userId
		},
		dataType : 'JSON',
		success : function(data) {
			//console.log("data.success : ",data.success);
			//console.log("data.likeCnt : ",data.likeCnt);
			console.log("좋아요 알림 보내기 : ", data.informSuccess);
			var contents = "<a href='javascript:undoLike("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
			+"<div class='revLike'>"
			+"<img src='resources/img/like2_full.png' class='revLikeImg'> 좋아요 "
            +"<b>"+data.likeCnt+"</b></div></a></div>";
			
			$('.revLikeContainer').empty();
			$('.revLikeContainer').append(contents);
			
			if(tab == "reviewMK"){
				//후기마커 탭이라면? 해당지역 후기마커리스트 새로고침
				loadReviews(areaName, 'default');
			}else if(tab == "myReviewMK"){
				//내후기마커 탭이라면? 내 후기마커리스트 새로고침
				loadMyReviews("${sessionScope.loginId}");
			}else{
				//즐겨찾기 탭이라면? 즐겨찾기한 후기마커 리스트 새로고침
				alert("즐겨찾기 탭 새로고침!");
			}
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
}

function undoLike(reviewId, userId, areaName, tab){
	console.log("좋아요취소 reviewId/userId : "+reviewId+"/"+userId);
	
	$.ajax({
		url : 'undoLike',
		type : 'GET',
		data : {
			"reviewId" : reviewId,
			"userId" : userId
		},
		dataType : 'JSON',
		success : function(data) {
			//console.log("data.success : ",data.success);
			//console.log("data.likeCnt : ",data.likeCnt);
			var contents = "<a href='javascript:doLike("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
			+"<div class='revLike'>"
			+"<img src='resources/img/like2_empty.png' class='revLikeImg'> 좋아요 "
            +"<b>"+data.likeCnt+"</b></div></a></div>";
			
			$('.revLikeContainer').empty();
			$('.revLikeContainer').append(contents);
			
			if(tab == "reviewMK"){
				//후기마커 탭이라면? 해당지역 후기마커리스트 새로고침
				loadReviews(areaName, 'default');
			}else if(tab == "myReviewMK"){
				//내후기마커 탭이라면? 내 후기마커리스트 새로고침
				loadMyReviews("${sessionScope.loginId}");
			}else{
				//즐겨찾기 탭이라면? 즐겨찾기한 후기마커 리스트 새로고침
				alert("즐겨찾기 탭 새로고침!");
			}
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
}
	
	function doBookMark(reviewId, userId, areaName, tab){
		console.log("즐겨찾기 reviewId/userId : "+reviewId+"/"+userId);
		
		$.ajax({
			url : 'doBookMark',
			type : 'GET',
			data : {
				"reviewId" : reviewId,
				"userId" : userId
			},
			dataType : 'JSON',
			success : function(data) {
				console.log("data.success : ",data.success);
				var contents = "<a href='javascript:undoBookMark("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
				+ "<div class='revBookMark'><img src='resources/img/star.png' class='revBookMarkImg'></div></a>";
				
				$('.revBookMarkContainer').empty();
				$('.revBookMarkContainer').append(contents);
				
				if(tab == "reviewMK"){
					//후기마커 탭이라면? 해당지역 후기마커리스트 새로고침
					loadReviews(areaName, 'default');
				}else if(tab == "myReviewMK"){
					//내후기마커 탭이라면? 내 후기마커리스트 새로고침
					loadMyReviews("${sessionScope.loginId}");
				}else{
					//즐겨찾기 탭이라면? 즐겨찾기한 후기마커 리스트 새로고침
					alert("즐겨찾기 탭 새로고침!");
				}
			},
			error : function(e) {
				console.log("에러 e : ", e);
			}
		}); //end ajax()

	}

	function undoBookMark(reviewId, userId, areaName, tab){
		console.log("즐겨찾기 취소 reviewId/userId : "+reviewId+"/"+userId);
		
		$.ajax({
			url : 'undoBookMark',
			type : 'GET',
			data : {
				"reviewId" : reviewId,
				"userId" : userId
			},
			dataType : 'JSON',
			success : function(data) {
				console.log("data.success : ",data.success);
				var contents = "<a href='javascript:doBookMark("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
				+ "<div class='revBookMark'><img src='resources/img/star2.png' class='revBookMarkImg'></div></a>";
				
				$('.revBookMarkContainer').empty();
				$('.revBookMarkContainer').append(contents);
				
				if(tab == "reviewMK"){
					//후기마커 탭이라면? 해당지역 후기마커리스트 새로고침
					loadReviews(areaName, 'default');
				}else if(tab == "myReviewMK"){
					//내후기마커 탭이라면? 내 후기마커리스트 새로고침
					loadMyReviews("${sessionScope.loginId}");
				}else{
					//즐겨찾기 탭이라면? 즐겨찾기한 후기마커 리스트 새로고침
					alert("즐겨찾기 탭 새로고침!");
				}
			},
			error : function(e) {
				console.log("에러 e : ", e);
			}
		}); //end ajax()
	}
	
	
	


	//댓글


	function loadComments(reviewId, currPage) { //댓글 데이터를 불러오는 함수
		
		//$("#pagination").twbsPagination('destroy');
		
		//var reviewId_1 = $("#reviewId").val();
		
		console.log("loadComments 실행 : "+reviewId+"/"+currPage);
		
		$.ajax({
					type : "POST",
					url : "loadComments", //글번호를 받아 댓글 데이터를 반환
					data : {
						"reviewId" : reviewId,
						"page" : currPage
					},
					dataType : 'JSON',
					success : function(data) {
						
							console.log("리스트 값이 null이 아닐 떄");
							$("#rm_commentWrap").show(); //만약 숨겨져있으면 보이게 한다
							//$('#cmtCount').html(data.totalCnt);
							
							$("#pagination").twbsPagination('destroy');
							
							drawComments(data.list, data.loginId); //댓글리스트를 브라우저에 그려준다

								$("#pagination").twbsPagination({
									startPage : data.currPage, //시작페이지
									totalPages : data.pages, //총 페이지 개수
									visiblePages : 5,
									initiateStartPageClick: false,
									onPageClick : function(e, page){
										console.log("twbsPagination 에서 onPageClick 실행");
										console.log(page+"번째 페이지 출력중");
										loadComments(reviewId, page);
									}
								});
					},
					error : function(e) {
						console.log("ajax loadComments() 에러 : " + e);
					}
				})

	}//loadComments end


	function drawComments(list, loginId) {
		console.log(list);
		var loginId = loginId;
		var content="";

		list.forEach(function(item, idx) {
			var check = loginId == item.userId;
			var checkT = loginId;
			content += "<div class='updateCheck'>"
			content += "<p class='fw-bold'>" + item.nickName + "</p>";
			content += "<p class='lh-sm'>";
			content += item.cmtContent;
			if(check){
				content += "<a class='commentDelBtn mx-2 float-end btn btn-secondary btn-sm' title='" + item.cmtId + "'>삭제</a>";
				content += "<a class='commentUpdateBtn float-end btn btn-secondary btn-sm'>수정</a>";
			}
			
			content += "</p>";
			content += "<hr/>";
			content += "</div>";
			content += "<div class='updateForm visually-hidden'>";
			content += "<p class='fw-bold'>" + item.nickName + "</p>";
			content += "<div class='form-floating flex-grow-1 px-2'>";
			content += "<textarea class='commentUpdateContent form-control' placeholder='Leave a comment here'";
			content += "name='commentUpdateContent' id='commentUpdateContent' style='height: 100px'>" + item.cmtContent + "</textarea>";//댓글내용
			content += "<div class='invalid-feedback'>1자 이상 입력해주세요</div>";//수정폼
			content += "<label for='commentUpdateContent'>수정할 댓글을 작성하세요</label>";
			content += "</div>";
			content += "<div class='d-flex justify-content-end mt-2' id='commentUpdateOut'>";
			content += "<a id='commentUpdateContentBtn' class='commentUpdateContentBtn btn btn-secondary btn-sm mx-2' title='" + item.cmtId + "'>등록</a>";
			content += "<a class='cmUpdateCancel btn btn-secondary btn-sm'>취소</a>";
			content += "</div>";
			content += "<hr />";
			content += "</div>";

		});
		$('#commentLists').empty();
		$('#commentLists').append(content);

//		content = "";
//		content += "<i id='commenticons' class='bi bi-chat-square-text-fill mt-1' style='font-size: 2.0rem;'></i>"
//		content += "<p  class='ms-2 mt-3 fw-bold'>댓글(" + data.commentCount + ")</p>"
		//$('#commenticon').empty();
		//$('#commenticon').append(content);
		
	}//commentList end

</script>
</html>