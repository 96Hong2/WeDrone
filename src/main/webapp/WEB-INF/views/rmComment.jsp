<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js"></script>
<style></style>

</head>
<body>

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
		</div>

<%@ include file="./common/footer.jsp" %>
</body>
<script>


//var content = "";
var reviewId_1 = $("#reviewId").val();
var currPage = 1;
var content = "";


function loadComments(reviewId_1, currPage) { //댓글 데이터를 불러오는 함수
	console.log(page+"가져오기");
	$.ajax({
				type : "POST",
				url : "loadComments", //글번호를 받아 댓글,대댓글 데이터를 반환
				data : {
					"reviewId" : reviewId_1,
					"page" : page
				},
				dataType : 'JSON',
				success : function(data) {
					
					if (data.list != null) { //DB에서 댓글 데이터를 정상적으로 가져왔다면
						$("#rm_commentWrap").show(); //만약 숨겨져있으면 보이게 한다
						$('#cmtCount').html(data.totalCnt);
						
						drawComments(data.list, data.loginId); //댓글리스트를 브라우저에 그려준다
						
						$("#pagination").twbsPagination({
							startPage : data.currPage, //시작페이지
							totalPages : data.pages, //총 페이지 개수
							visiblePages : 5,
							onPageClick : function(e, page){
								console.log(e, page);
								loadComments(reviewId_1, page);
							}
						});
					}else{
						content += '<div class="text-center text-muted">작성한 댓글이 없습니다</div>';
					
						
						$('#commentLists').empty();
						$('#commentLists').append(content);
					}
				},
				error : function(e) {
					console.log("ajax loadComments() 에러 : " + e);
				}
			})

}//loadComments end


function drawComments(list, loginId) {
	console.log(list);
	var loginId = loginId;

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
		content += '<div class="pageContainer">'+
							'<nav aria-lable="Page navigation" style="text-align:center">'+
							'<ul class="pagination" id="pagination"></ul>'+
							'</nav>'+
							'</div>';
	});
	$('#commentLists').empty();
	$('#commentLists').append(content);

//	content = "";
//	content += "<i id='commenticons' class='bi bi-chat-square-text-fill mt-1' style='font-size: 2.0rem;'></i>"
//	content += "<p  class='ms-2 mt-3 fw-bold'>댓글(" + data.commentCount + ")</p>"
	//$('#commenticon').empty();
	//$('#commenticon').append(content);
	
}//commentList end





</script>
</html>