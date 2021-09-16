<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js"></script>
<style>
/* 푸터 위의 내용 감싸서 내용 없어도 푸터 하단으로 가도록 */
.wrap {
	text-align: center;
	display: flex;
	flex-direction: column;
	height: 100%
}

footer {
	width: 100%;
	height: 80px;
	background-color: #3c3c3c;;
	margin-top: auto
}
body,html {
	font-family: 'Do Hyeon', sans-serif;
}


	table, th, td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 6px;
		text-align: left;
	}

    table{
      width:80%;
      margin-left: auto; 
      margin-right: auto;
      height:300px;
     

   }
</style>
</head>
<title>드론</title>
<body>
	<!-- 상단 메뉴바 -->
	<!-- 아이디가 있다면 -->
	<%-- <c:if test="${sessionScope.userId ne null}">
		<jsp:include page="${path}/lognav"></jsp:include>
	</c:if>
	<!-- 아이디가 없ㅇ 네비바-->
	<c:if test="${sessionScope.userId eq null}">
		<jsp:include page="${path}/navbar"></jsp:include>
	</c:if> --%>

	<div class="wrap">
		<!-- 네비게이션바 -->
		<nav class="navbar navbar-expand-lg navbar-dark"
			style="background-color: #3c3c3c;">
			<div class="container-fluid">
				<a
					class="fs-3 text-center navbar-brand fw-bold text-color: #003399;"
					href="${path}/"> <img src="resources/img/LOGO.png"
					class="rounded float-end rounded mx-auto d-block mx-2" alt=""
					width="50" height="50">WeDron
				</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active text-center"
							aria-current="page" href="${path}/map"><h4>Map</h4></a></li>
						<li class="nav-item"><a class="nav-link active text-center "
							href="${path}/calendar"><h4>Calendar</h4></a></li>
						<a class="nav-link active" href="${path}/news"><h4>News</h4></a>
						</li>
						<li class="nav-item"><a class="nav-link active text-center "
							href="${path}/notice"><h4>Notice</h4></a></li>
						<li class="nav-item"><a class="nav-link active text-center "
							href="${path}/board"><h4>Board</h4></a></li>

</ul>
</div>
</div>
</nav>

 


	<h1>자유 게시판 상세보기</h1>	
	<table>
	
	<tr>
			<th>게시판 번호</th>
			<td>${post.postId}</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>${sessionScope.loginNickName}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${post.postDate}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${post.postContent}</td>
		</tr>
		
		
		<tr>
			<td colspan="2">
				<button onclick="location.href='./'" class = "btn btn-dark" >리스트</button>
				<button onclick="location.href='./fbupdateForm?postId=${post.postId}'" class = "btn btn-dark" >수정</button>
				<button onclick="location.href='./fbdel?postId=${post.postId}'" class = "btn btn-dark" >삭제</button>			
			</td>
		</tr>
	</table>
		
<!-- 	<div class="container px-4 my-4">
		<h3 id="comments" class="fw-bold mt-3">댓글</h3>
				<hr />
				<c:if test="${loginId==null}">
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
				 -->
				 
			<h3 id="comments" class="fw-bold mt-3">댓글</h3>	 
	      <select id="pagePerNum" style="display:none">
			<option value="5" >5</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="20">20</option>
		</select>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>내용</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody id="list">
				<!-- 리스트가 출력될 내용 -->
			</tbody>
			<tr>
				<td colspan="6">
					<!-- 페이징이 표시될 부분 -->
					<div class="container">
						<nav aria-lable="Page navigation" style="text-align: center">
							<ul class="pagination" id="pagination"  style = "justify-content: center;"></ul>
						</nav>
					</div>
				</td>
			</tr>
		</table>	
		
		<div class="container px-4 my-4">
				<hr />
				<c:if test="${loginId==null}">
					<div class="d-flex align-items-center">
						<div class="form-floating flex-grow-1 px-2">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="cmtContent" id="cmtContent"
								style="height: 100px; resize: none;"></textarea>
							<div class="invalid-feedback">1자 이상 입력해주세요.</div>
							<label for="cmtContent">로그인 후 이용해주세요.</label>
						</div>
						
					</div>
				</c:if>
				 </div>
				
				<c:if test="${loginId != null}">
					<div class="d-flex align-items-center">
						<div class="form-floating flex-grow-1 px-2">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="cmtContent" id="cmtContent"
								style="height: 80px; resize:none; margin:auto;width:80%;"></textarea>
								
							<div class="invalid-feedback">1자 이상 입력해주세요.</div>
							<label for="cmtContent" style= "justify-content: center;">${loginId}님, 이곳에 댓글을 작성하세요</label>
						</div>
						<a type="button" id="proCommentBtn" class="btn btn-secondary btn-sm" title="${dto.cmtId}">등록</a>
					</div>
				</c:if>
				<br/>
			
			<!--  	<div id="fbcmtlist" class="container px-5 py-4 my-4">
					<c:forEach items="${list.fbcmtlist}" var="commentLists">
						<div class="updateCheck">
							<p class="lh-sm">
								${list.cmtContent}
								<c:if test="${loginId ne fbcmtlist.memberKey && sessionScope.loginId ne null}">
								</c:if>
								<c:if test="${loginId eq fbcmtlist.memberKey}">
									<a id="commentDelBtn"
										class='commentDelBtn ms-2 float-end btn btn-secondary btn-sm'
										title="${list.cmtId}">삭제</a>
									<a class='commentUpdateBtn float-end btn btn-secondary btn-sm'>수정</a>
								</c:if>
							</p>
							<hr />
						</div>
						<div class="updateForm visually-hidden" id="fbcmtupdateForm">
							<div class="form-floating flex-grow-1 px-2">
								<textarea class="fbcmtupdateForm form-control"
									placeholder="Leave a comment here" name="commentUpdateContent"
									id="fbcmtupdateForm" style="height: 100px; resize: none;">${list.cmtContent} </textarea>
								<label for="fbcmtupdateForm">수정할 댓글을 작성하세요</label>
								<div class="invalid-feedback">1자 이상 입력해주세요</div>
							</div>
							<div class="d-flex justify-content-end mt-2"
								id="commentUpdateOut">
								<a class='commentUpdateContentBtn btn btn-secondary btn-sm mx-2'
									id="commentUpdateContentBtn" title="${list.cmtId}">등록</a>
								<a class='cmUpdateCancel btn btn-secondary btn-sm'>취소</a>
							</div>
							<hr />
						</div>
					</c:forEach>
				</div>
				
				<ul id="paginations" class="pagination justify-content-center">
					<c:if test="${dto.startPage ne 1}">
						<li class="page-item"><a class="page-link pageNum"
							title="${dto.startPage-1} ${dto.cmtId}" role="button"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach var="i" begin="${dto.startPage}" end="${dto.endPage}">
						<c:if test="${i ne dto.currPage}">
							<li class="page-item"><a role="button"
								class="page-link pageNum" title="${i} ${dto.cmtId}">${i}</a></li>
						</c:if>
						<c:if test="${i eq dto.currPage}">
							<li class="page-item active"><a class="page-link">${i}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${dto.totalPage ne dto.endPage}">
						<li class="page-item"><a class="page-link pageNum"
							role="button" title="${dto.endPage+1} ${dto.cmtId}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
	</div>
		
			-->

		
				
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous">
	
</script>
<script src="resources/js/jquery.twbsPagination.js"></script>
</body>
<script type="text/javascript">
	
		
$(document).on('click', '#proCommentBtn', function() {
	var cmtContent = $('#cmtContent').val();
		console.log(cmtContent);
		if (cmtContent.trim() != "") {
			$('#cmtContent').removeClass('is-invalid');			
			$.ajax({
				type: 'POST',//방식
				url: 'fbcmtwrite',//주소
				data: {
					cmtContent: cmtContent,
					
				},
				dataType: 'JSON',
				success: function(data) { //성공시
					fbcmtlist(data);
					$('#cmtContent').val("");
					console.log("성공!");
				},
				error: function(e) { //실패시
					console.log(e);
				}
			});
		} else {
			$('#cmtContent').addClass('is-invalid');
		}			
		
	})
		
	var currPage = 1;
	
	listCall(currPage);
	
	$("#pagePerNum").change(function(){
		//페이징 초기화
		$("#pagination").twbsPagination('destroy');
		listCall(currPage);
	});
	
	function listCall(page){		
		//{pagePerNum}/{page}
		var reqUrl = 'list/'+$("#pagePerNum").val()+'/'+page;
		console.log('request url : '+reqUrl);
		console.log(page+" page 가져오기");		
		$.ajax({
			url:reqUrl,
			type:'get',
			dataType:'json',
			success:function(data){
				console.log(data);
				listPrint(data.list);//리스트 그리기
				currPage = data.currPage;
				//페이징 처리
				$("#pagination").twbsPagination({
					startPage: data.currPage,//시작페이지
					totalPages: data.pages,  //총 페이지 갯수
					visiblePages:5, //보여줄 페이지 갯수
					onPageClick: function(e,page){
						//console.log(e,page);
						listCall(page);
					}
				});				
			},
			error:function(error){
				console.log(error);
			}			
		});		
	}
	
	function listPrint(list){
		var content = "";
		
		for(var i=0; i<list.length; i++){
			content +="<tr>";
			content += "<td>"+list[i].cmtId+"</td>";
			content += "<td>"+list[i].cmtContent+"</td>";
			var date = new Date(list[i].cmtDate);			
			content += "<td>"+date.toLocaleDateString("ko-KR")+"</td>";
			content +="</tr>";
		}
		$("#list").empty();
		$("#list").append(content);
		
	}
	
	
		</script>



<!-- 하단 푸터 -->



</html>
