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
	<div id="detailModal" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">닉네임 님의 후기마커</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
				</div>
				<div class="modal-body">



					<h3>♥바디!!!!!!!!♥</h3>
					<div class='revContainer1'>
						<div class='revContainer1_1'>
							<img class='reviewImg' src='/photo/"+review.newFileName+"' />
						</div>
						<div class='revContainer1_2'>
							<div id='revContent'>review.content내용내용~~~~~~~~~~~~~~~~~~~~~~~~~</div>
							<div id='revRating'>
								♧ ♧ ♧
								<%-- //평점(구름아이콘)
                  var rating = "";
                  for(var i=0; i<review.rating; i++){
                     rating +="<img src='resources/img/cloud.png' class='revRatingImg'>";
                  } --%>
							</div>
							<div class='revContainer1_2_1'>
								<div id='revLike'>♥ 좋아요(review.likeCnt)</div>
								<div id='revCmt'>■ 댓글(review.CommentCnt)</div>
								<div id='revBookMark'>★ 즐겨찾기 review.isBookMark</div>
							</div>
						</div>
					</div>

					<hr />
					<div id='commentArea'>
						<h5>댓글</h5>
					</div>

				</div>
				<div class="modal-footer">
					<a class="btn" id="modalY" href="#">예</a>
					<button class="btn" type="button" data-dismiss="modal">아니요</button>
					<button id="close" type="button" class="btn btn-default"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	//버튼 클릭 시 모달창 나옴 >> 테스트 후 지울 부분
	$('#testBtn').click(function(e) {
		e.preventDefault();
		$('#detailModal').modal("show");
	});

	//모달창 닫기
	$('.close').click(function(e) {
		$('#detailModal').modal('hide');
	});

	//상세정보 불러오기
	$.ajax({
		url : 'getReviewDetail',
		type : 'POST',
		data : {
			"lat" : rmLat
		},
		dataType : 'JSON',
		success : function(data) {

			
			}); // end ajax     
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	});
</script>
</html>