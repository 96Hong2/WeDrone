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
</head>
<body>
	<!-- 테스트 후 옮기거나 통째로 import하기 -->
	<button id="testBtn" class="btn">모달 열기</button>
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
						<h5>댓글</h5>
					</div>

				</div>
				<div class="modal-footer">
					<!-- <a class="btn" id="modalY" href="#">예</a>
					<button class="btn" type="button" data-dismiss="modal">아니요</button> -->
					<button type="button" class="btn btn-default"
						data-dismiss="modal" id="close">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	var reviewId = 26; //테스트용 리뷰아이디  //리뷰아이디 받아와야함
	var userId = "${sessionScope.loginId}";

	//버튼 클릭 시 모달창 나옴 >> 테스트 후 지울 부분
	$('#testBtn').click(function(e) {
		e.preventDefault();
		loadReviewDetail(reviewId, userId);
		$('#detailModal').modal("show");
	});

	//모달창 닫기
	$('#close').click(function(e) {
		$('#detailModal').modal('hide');
	});

	
function loadReviewDetail(reviewId, userId){
	$('.revContainer').empty();
	$('#reviewTitle').empty();
	
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
			content = "<div class='revContainer1'>" 
			+"<img class='reviewImg' src='/photo/"+review.newFileName+"' />"
			+"</div>"
			+"<div class='revContainer2'>"
			+"<div id='revContent'>"+review.reviewContent+"</div>"
			+"<div id='revRating'>"
			+ rating
			+"</div>"
			+"<div id='revAddress'>"+review.address+"</div>"
			+"<div id='revDate'>"+review.reviewDate+"</div>"
			+"<div class='revContainer2_1'>"
			+"<div class='revLikeContainer'>";
			
			if(review.isLike > 0){
				content += "<a href='javascript:undoLike("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
                content += "<div class='revLike'>";
                content += "<img src='resources/img/like2_full.png' class='revLikeImg'> 좋아요 ";
                content += "<b>"+review.likeCnt+"</b></div></a></div>";
             }else{
            	content += "<a href='javascript:doLike("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
                content += "<div class='revLike'>";
                content += "<img src='resources/img/like2_empty.png' class='revLikeImg'> 좋아요 ";
                content += "<b>"+review.likeCnt+"</b></div></a></div>";
             }
			
			content += "<div id='revCmt'><img src='resources/img/comment.png' class='revCommentImg'> 댓글 <b>"+review.commentCnt+"</b></div>";
			
			if(review.isBookMark > 0){
				content += "<div class='revBookMark'><img src='resources/img/star.png' class='revBookMarkImg'></div>";
             }else{
            	content += "<div class='revBookMark'><img src='resources/img/star2.png' class='revBookMarkImg'></div>";
             }
			
			
			content += "</div></div>"; //end .revContainer2_1, .revContainer2
            
			
			$('.revContainer').append(content);
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
	
} //end loadReviewDetail()

function doLike(reviewId, userId){
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
			var contents = "<a href='javascript:undoLike("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
			+"<div class='revLike'>"
			+"<img src='resources/img/like2_full.png' class='revLikeImg'> 좋아요 "
            +"<b>"+data.likeCnt+"</b></div></a></div>";
			
			$('.revLikeContainer').empty();
			$('.revLikeContainer').append(contents);
			//loadReviewDetail(reviewId, userId);
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
	
	
}

function undoLike(reviewId, userId){
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
			//$('.revContainer').append(content);
			//loadReviewDetail(reviewId, userId);
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
	
}
</script>
</html>