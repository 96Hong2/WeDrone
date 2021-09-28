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
				<div class="modal-header" id="modal-header">
					<div id="header1">
						<div id="modalHeader"></div>
						<h5 class="modal-title" id="reviewTitle"></h5>
					</div>
					<div id="header2">
						<button class="btn btn-default" type="button" data-dismiss="modal"
							aria-label="Close" id="close">
							<span aria-hidden="true">X</span>
						</button>
					</div>
				</div>
				<div class="modal-body">
					<div class='revContainer'>
					</div>
					
				<div class="modal-footer">
					<div id='commentArea'>
						<div class="container px-4 my-4" id="rm_commentWrap">
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
						<input type="hidden" id="rmLoginId" name="rmLoginId" value="${sessionScope.loginId}"/>
							<textarea class="form-control" placeholder="Leave a comment here"
								name="commentContent" id="commentContent"
								style="height: 100px; resize: none;" maxlength="150" autocomplete="off"></textarea>
							<div class="invalid-feedback">1자 이상 입력해주세요.</div>
							<label for="commentContent">150자 이내로 입력해주세요.</label>
						</div>
						<a type="button" id="rmCommentBtn" class="btn btn-secondary btn-sm" title="글아이디">등록</a>
					</div>
				</c:if>
				
				<div id="commentLists" class="container py-4 my-4"></div>
				<div class="container px-5 py-4 my-4" id="pagination_area">
					<div class="pageContainer">
								<nav aria-lable="Page navigation" style="text-align:center" id="pageNav">
									<ul class="pagination" id="pagination"></ul>
								</nav>
					</div>
				</div>
		</div>

					</div>

				</div>
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
	
	
	/*
	var fileOX = "";
	
	function readImage(input) {
	    // 인풋 태그에 파일이 있는 경우
	    if(input.files && input.files[0]) {
	        // 이미지 파일인지 검사 (생략)
	        // FileReader 인스턴스 생성
	        const reader = new FileReader()
	        // 이미지가 로드가 된 경우
	        reader.onload = e => {
	            const previewImage = document.getElementById("preview-image")
	            previewImage.src = e.target.result
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0])
	    }
	}
	
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("rmPhoto")
	inputImage.addEventListener("change", e => {
	    readImage(e.target)
	    fileOX = "ok";
	})*/
	
	
	var loginNickName = "${sessionScope.loginNickName}";
	var reviewUserId = "";
	var rmCmtCnt = "";
	
function loadReviewDetail(reviewId, userId, tab){
	$('.revContainer').empty();
	$('#reviewTitle').empty();
	$('#modalHeader').empty();
	
	var currPage = 1;
	
	//console.log("reviewId : ", reviewId);
	//console.log("userId : ", userId);
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
			//console.log("review dto: ",review);
			reviewUserId = review.userId;
			
			var content2 = "";
			content2 += "<div class='revBookMarkContainer'>";
			if(review.isBookMark > 0){
				content2 += "<a href='javascript:undoBookMark("+reviewId+",\""+userId+"\",\""+review.areaName+"\",\""+tab+"\")' class='likeAnchor'>";
				content2 += "<div class='revBookMark'><img src='resources/img/star.png' class='revBookMarkImg'></div></a>";
             }else{
            	content2 += "<a href='javascript:doBookMark("+reviewId+",\""+userId+"\",\""+review.areaName+"\",\""+tab+"\")' class='likeAnchor'>";
            	content2 += "<div class='revBookMark'><img src='resources/img/star2.png' class='revBookMarkImg'></div></a></div>";
             }
			
			//작성날짜, 글쓴이닉네임, 사진, 내용, 평점, 좋아요개수, 내 좋아요여부, 댓글갯수, 내 즐겨찾기여부
			$('#reviewTitle').append("<b>"+review.nickName+" 님의 후기 </b>");
			$('#reviewTitle').append("<b id='addressArea'>"+review.address+"</b>");
			$('#modalHeader').append(content2);
			
			
			//평점(구름아이콘)
			var rating = "";
			for(var i=0; i<review.rating; i++){
			    rating +="<img src='resources/img/thumbs.png' class='revRatingImg'>";
			}
			
			var content = "";
			content = "<input type='hidden' id='reviewId' value='"+reviewId+"' />" 
			+"<div class='revContainer1' id='revContainer1'>"
			+"<img class='reviewImg' id='preview-image' src='/photo/"+review.newFileName+"' />"
			+"</div>"
			+"<div class='revContainer2'>"
			+"<div id='revRating'>"
			+ rating+""
			+"</div>"
			+"<div id='revDate'>"+review.reviewDate+"</div>"
			+"<div id='clearBox'></div>"
			+"<div id='revContent'>"+review.reviewContent+"</div>";
			
				content += "<div class='revContainer2_1' style='margin-top : 10px;'>";
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
			rmCmtCnt = review.commentCnt;
			if(review.userId == userId){
				content += "<div id='btnArea'><span id='buttonArea2'><button type='button' id='updateBtn' class='btn btn-outline-primary myRevBtns' onclick='updateReview("+reviewId+",\""+review.areaName+"\",\""+tab+"\",\""+userId+"\", "+review.rating+", "+review.areaId+")'>수정</button></span>";
				content += "<span id='buttonArea'><button type='button' onclick='deleteReview("+reviewId+",\""+review.areaName+"\",\""+tab+"\")' class='btn btn-outline-danger myRevBtns' id='deleteBtn'>삭제</button></span></div>";
			}
			
			content += "</div></div>"; //end .revContainer2_1, .revContainer2
            
			
			$('.revContainer').append(content);
			
			loadComments(reviewId, currPage);	
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
	
} //end loadReviewDetail()

function reloadMarkers(areaName, tab){
	if(tab == "reviewMK"){
		//후기마커 탭이라면? 해당지역 후기마커리스트 새로고침
		loadReviews(areaName, 'default');
	}else if(tab == "myReviewMK"){
		//내후기마커 탭이라면? 내 후기마커리스트 새로고침
		loadMyReviews("${sessionScope.loginId}");
	}else{
		//즐겨찾기 탭이라면? 즐겨찾기한 후기마커 리스트 새로고침
		loadBookMarks("${sessionScope.loginId}");
	}
}

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

				//새로고침
				reloadMarkers(areaName, tab);
				
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
	//console.log("좋아요 reviewId/userId : "+reviewId+"/"+userId);
	
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
			//console.log("좋아요 알림 보내기 : ", data.informSuccess);
			var contents = "<a href='javascript:undoLike("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
			+"<div class='revLike'>"
			+"<img src='resources/img/like2_full.png' class='revLikeImg'> 좋아요 "
            +"<b>"+data.likeCnt+"</b></div></a></div>";
			
			$('.revLikeContainer').empty();
			$('.revLikeContainer').append(contents);
			
			mySocket.send("좋아요 알림,"+reviewUserId+","+loginNickName+"님이 당신의 후기마커에 좋아요를 눌렀습니다!,"+"#");
			
			reloadMarkers(areaName, tab);
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
}

function undoLike(reviewId, userId, areaName, tab){
	//console.log("좋아요취소 reviewId/userId : "+reviewId+"/"+userId);
	
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
			
			reloadMarkers(areaName, tab);
		},
		error : function(e) {
			console.log("에러 e : ", e);
		}
	}); //end ajax()
}
	
	function doBookMark(reviewId, userId, areaName, tab){
		//console.log("즐겨찾기 reviewId/userId : "+reviewId+"/"+userId);
		
		$.ajax({
			url : 'doBookMark',
			type : 'GET',
			data : {
				"reviewId" : reviewId,
				"userId" : userId
			},
			dataType : 'JSON',
			success : function(data) {
				//console.log("data.success : ",data.success);
				var contents = "<a href='javascript:undoBookMark("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
				+ "<div class='revBookMark'><img src='resources/img/star.png' class='revBookMarkImg'></div></a>";
				
				$('.revBookMarkContainer').empty();
				$('.revBookMarkContainer').append(contents);
				
				mySocket.send("즐겨찾기 알림,"+reviewUserId+","+loginNickName+"님이 당신의 후기마커를 즐겨찾기 했습니다!,"+"#");
				
				reloadMarkers(areaName, tab);
			},
			error : function(e) {
				console.log("에러 e : ", e);
			}
		}); //end ajax()

	}

	function undoBookMark(reviewId, userId, areaName, tab){
		//console.log("즐겨찾기 취소 reviewId/userId : "+reviewId+"/"+userId);
		
		$.ajax({
			url : 'undoBookMark',
			type : 'GET',
			data : {
				"reviewId" : reviewId,
				"userId" : userId
			},
			dataType : 'JSON',
			success : function(data) {
				//console.log("data.success : ",data.success);
				var contents = "<a href='javascript:doBookMark("+reviewId+",\""+userId+"\")' class='likeAnchor'>"
				+ "<div class='revBookMark'><img src='resources/img/star2.png' class='revBookMarkImg'></div></a>";
				
				$('.revBookMarkContainer').empty();
				$('.revBookMarkContainer').append(contents);
				
				reloadMarkers(areaName, tab);
			},
			error : function(e) {
				console.log("에러 e : ", e);
			}
		}); //end ajax()
	}
	
	
	function updateReview(reviewId, areaName, tab, userId, rating, areaId){
		//console.log("후기마커 수정하기 버튼 클릭");
		$("#revContent").attr('contenteditable', 'true');
		$("#revContent").focus();
		$("#updateBtn").hide();
		$("#deleteBtn").hide();
		$("#revRating").empty();
		
		var selectRate = '<select name="rating" id="rating" style="width:100px; height:30px;">'+
            '<option value="5">5</option>'+
            '<option value="4">4</option>'+
            '<option value="3">3</option>'+
            '<option value="2">2</option>'+
            '<option value="1">1</option>'+
         	'</select>';
		
		$("#revRating").append(selectRate);
		$('#rating option[value='+rating+']').prop('selected', 'selected').change();
		
		$("#revContainer1").append('<input type="file" name="rmPhoto" id="rmPhoto" accept="image/*"/>');
		
		var cancelBtn = '<button type="button" class="btn btn-outline-danger myRevBtns" onclick="loadReviewDetail('+reviewId+',\''+userId+'\',\''+tab+'\')">취소</button>';
		var updateBtn2 = '<button type="button" class="btn btn-outline-primary myRevBtns" id="reviewUpdateSubmitBtn">수정</button>';
		
		$("#buttonArea").append(cancelBtn);
		$("#buttonArea2").append(updateBtn2);
		
		
		var fileOX = "";
		
		function readImage(input) {
		    // 인풋 태그에 파일이 있는 경우
		    if(input.files && input.files[0]) {
		        // 이미지 파일인지 검사 (생략)
		        // FileReader 인스턴스 생성
		        const reader = new FileReader()
		        // 이미지가 로드가 된 경우
		        reader.onload = e => {
		            const previewImage = document.getElementById("preview-image")
		            previewImage.src = e.target.result
		        }
		        // reader가 이미지 읽도록 하기
		        reader.readAsDataURL(input.files[0])
		    }
		}
		
		
		// input file에 change 이벤트 부여
		const inputImage = document.getElementById("rmPhoto")
		inputImage.addEventListener("change", e => {
		    readImage(e.target)
		    fileOX = "ok";
		})
		$("#rmPhoto2").click(function(e){
		console.log("파일 미리보기");
	    readImage(e.target)
	    fileOX = "ok";
	});
		
		$("#reviewUpdateSubmitBtn").click(function(){
			
			if(confirm("수정하시겠습니까?")){
				
				var reviewUpdateContent = $("#revContent").html();
				var updateRating = $("#rating option:selected").val();
				
				//console.log("수정된 내용 : "+reviewUpdateContent);
				//console.log("수정된 평점 : "+updateRating);
				
				$.ajax({
	                url:'rmUpdate',
	               type:'POST',
	               data : {
	                  "reviewContent" : reviewUpdateContent,
	                  "rating" : updateRating,
	                  "reviewId" : reviewId,
	                  "areaId" : areaId
	                  },
	               dataType:'JSON',
	               success:function(data){
	               
	                  //console.log("수정 성공 여부 : "+data.success);
	                  
	                   if(fileOX != ""){
	                	   
	                	   const file = $("#rmPhoto")[0];
	                	   
	                	   //console.log("file : "+file.files[0].name);
	                	   
	                	   const formData = new FormData();
	                	   formData.append("reviewId", reviewId);
	                	   formData.append("file", file.files[0]);
	                	   
		                  $.ajax({
		                        url:'rmFileUpdate',
		                       type:'POST',
		                       processData: false,
		                       contentType: false,
		                       data : formData,
		                       dataType:'JSON',
		                       success:function(data){
		                          ////console.log(data);
		                          alert("수정이 완료되었습니다!+이미지");
		                          loadReviews(areaName, 'default');
		                          loadReviewDetail(reviewId, userId, tab);
		                       },
		                       error:function(e){
		                           console.log("에러발생 : ", e);
		                           alert("등록에 실패하였습니다!");
		                        }  
		                  }); // end ajax  
	                   }else{
	                	   alert("수정이 완료되었습니다.");
	                	   loadReviews(areaName, 'default');
	                       loadReviewDetail(reviewId, userId, tab);
	                   }
	               },
	               error:function(e){
	                   console.log("에러발생 : ", e);
	                   alert("등록에 실패하였습니다!");
	                }  
	          }); // end ajax */
			}
			
		});
		
		
		
		
	}// updateReview end
	
	
	
	


	//댓글


	function loadComments(reviewId, currPage) { //댓글 데이터를 불러오는 함수
		
		//console.log("loadComments 실행 : "+reviewId+"/"+currPage);
		$("#pagination").twbsPagination('destroy');
		
		$.ajax({
					type : "POST",
					url : "loadComments", //글번호를 받아 댓글 데이터를 반환
					data : {
						"reviewId" : reviewId,
						"page" : currPage
					},
					dataType : 'JSON',
					success : function(data) {
						
						if(data.list != null){
							//console.log("리스트 값이 null이 아닐 떄");
							$("#rm_commentWrap").show(); //만약 숨겨져있으면 보이게 한다
							//$('#cmtCount').html(data.totalCnt);
							
							drawComments(data.list, data.loginId); //댓글리스트를 브라우저에 그려준다

								$("#pagination").twbsPagination({
									startPage : data.currPage, //시작페이지
									totalPages : data.pages, //총 페이지 개수
									visiblePages : 5,
									initiateStartPageClick: false,
									first : "<<",	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
								    prev : "<",	// 이전 페이지 버튼에 쓰여있는 텍스트
								    next : ">",	// 다음 페이지 버튼에 쓰여있는 텍스트
								    last : ">>",
									onPageClick : function(e, page){
										//console.log("twbsPagination 에서 onPageClick 실행");
										//console.log(page+"번째 페이지 출력중");
										loadComments(reviewId, page);
									}
								});
							}else{
								$("#pagination").twbsPagination({
									startPage : 1, //시작페이지
									totalPages : 1, //총 페이지 개수
									visiblePages : 1,
									initiateStartPageClick: false,
									first : "<<",	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
								    prev : "<",	// 이전 페이지 버튼에 쓰여있는 텍스트
								    next : ">",	// 다음 페이지 버튼에 쓰여있는 텍스트
								    last : ">>",
									onPageClick : function(e, page){
										//console.log("nothing");
									}
								});
							}
					},
					error : function(e) {
						console.log("ajax loadComments() 에러 : " + e);
					}
				})

	}//loadComments end


	function drawComments(list, loginId) {
		//console.log(list);
		var loginId = loginId;
		var content="";

		list.forEach(function(item, idx) {
			var check = loginId == item.userId;
			var checkT = loginId;
			content += "<div class='updateCheck'>"
			content += "<p class='fw-bold'>" + item.nickName + "</p>";
			//content += "<p class='fw-bold'>" + item.cmtDate + "</p>";
			content += "<p class='lh-sm'>";
			content += item.cmtContent;
			if(check){
				content += "<a class='commentDelBtn mx-2 float-end btn btn-secondary btn-sm' title='"+item.cmtId+"' onclick='rmCmtDelete("+item.cmtId+")'>삭제</a>";
				content += "<a class='commentUpdateBtn float-end btn btn-secondary btn-sm' onclick='updateFormSet("+item.cmtId+")'>수정</a>";
			}
			
			content += "</p>";
			content += "<hr/>";
			content += "</div>";
			content += "<div class='updateForm visually-hidden' id='updateForm"+item.cmtId+"'>";
			content += "<div class='form-floating flex-grow-1 px-2'>";
			content += "<textarea class='commentUpdateContent form-control' placeholder='Leave a comment here'";
			content += "name='commentUpdateContent' id='commentUpdateContent' style='height: 100px'>" + item.cmtContent + "</textarea>";//댓글내용
			content += "<div class='invalid-feedback'>1자 이상 입력해주세요</div>";//수정폼
			content += "<label for='commentUpdateContent'>수정할 내용을 작성하세요</label>";
			content += "</div>";
			content += "<div class='d-flex justify-content-end mt-2' id='commentUpdateOut'>";
			content += "<a id='commentUpdateContentBtn' class='commentUpdateContentBtn btn btn-secondary btn-sm mx-2' title='" + item.cmtId + "' onclick='rmCmtUpdate("+item.cmtId+")'>등록</a>";
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
	
	
	//댓글 작성
	$("#rmCommentBtn").click(function(){
		var reviewId_1 = $("#reviewId").val();
		var cmtContent = $("#commentContent").val();
		var rmLoginId = $("#rmLoginId").val();
		//console.log("댓글 내용 : "+cmtContent);
		//console.log("댓글 달 후기마커 아이디 : "+reviewId_1);
		//console.log("로그인된 아이디 : "+rmLoginId);
		
		if(cmtContent.length != 0){
			
			$("#commentContent").removeClass("is-invalid");
			
			$.ajax({
				type: 'POST',
				url: 'rmCmtWrite',
				data: {
					"cmtContent" : cmtContent,
					"reviewId" : reviewId_1,
					"userId" : rmLoginId
				},
				dataType: 'JSON',
				success: function(data){
					//console.log("댓글 작성 성공 여부 : "+data.success);
					//console.log("댓글 알림 보내기 : ", data.informSuccess);
					$("#commentContent").val("");
					alert("댓글을 등록했습니다.");
					mySocket.send("댓글 알림,"+reviewUserId+","+loginNickName+"님이 당신의 후기마커에 댓글을 달았습니다!,"+"#");
					loadComments(reviewId_1, 1);
					
					rmCmtCnt += 1;
					var contents = "<b id='rm_cmtCnt'>"+rmCmtCnt+"</b>";
					$('#rm_cmtCnt').empty();
					$('#rm_cmtCnt').append(contents);
				},
				error: function(e){
					console.log("댓글 작성 실패 :"+e);
					alert("댓글을 등록하지 못했습니다.");
				}
			});
			
			
		}else{
			$("#commentContent").addClass("is-invalid");
			alert("내용을 입력해주세요!");
		}
		
	});
	
	//댓글 삭제
	function rmCmtDelete(cmtId){
		
		var reviewId_1 = $("#reviewId").val();
		
		if(confirm("이 댓글을 삭제하시겠습니까?")){
		
			$.ajax({
				type: 'POST',
				url: 'rmCmtDelete',
				data: {
					"cmtId" : cmtId,
				},
				dataType: 'JSON',
				success: function(data){
					//console.log("댓글 삭제 성공 여부 : "+data.success);
					$("#commentContent").val("");
					alert("댓글을 삭제했습니다.");
					loadComments(reviewId_1, 1);
					
					rmCmtCnt -= 1;
					var contents = "<b id='rm_cmtCnt'>"+rmCmtCnt+"</b>";
					$('#rm_cmtCnt').empty();
					$('#rm_cmtCnt').append(contents);
				},
				error: function(e){
					console.log("댓글 삭제 실패 :"+e);
					alert("댓글을 삭제하지 못했습니다.");
				}
			});
			
		}
	}
	
	//댓글 수정
	function rmCmtUpdate(cmtId){
		var reviewId_1 = $("#reviewId").val();
		var cmtContent = $("#commentUpdateContent").val();
		var rmLoginId = $("#rmLoginId").val();
		
		//console.log("수정할 댓글 내용 : "+cmtContent);
		
		if(cmtContent.length != 0){
			$("#commentUpdateContent").removeClass("is-invalid");
				if(confirm("댓글을 수정하시겠습니까?")){
					
					$.ajax({
						type: 'POST',
						url: 'rmCmtUpdate',
						data: {
							"cmtContent" : cmtContent,
							"cmtId" : cmtId,
						},
						dataType: 'JSON',
						success: function(data){
							//console.log("댓글 수정 성공 여부 : "+data.success);
							//$("#commentContent").val("");
							alert("댓글을 수정했습니다.");
							loadComments(reviewId_1, 1);
						},
						error: function(e){
							console.log("댓글 수정 실패 :"+e);
							alert("댓글을 수정하지 못했습니다.");
						}
					});
				}
		}else{
			$("#commentUpdateContent").addClass("is-invalid");
		}
	}
	
	function updateFormSet(cmtId){
		$("#updateForm"+cmtId).toggleClass("visually-hidden");
	}

</script>
</html>