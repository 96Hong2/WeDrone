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
<link href="https://fonts.googleapis.com/css2?family=Acme&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<!--폰트-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500&display=swap" rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css"
	integrity="sha384-wESLQ85D6gbsF459vf1CiZ2+rr+CsxRY0RpiF1tLlQpDnAgg6rwdsUF1+Ics2bni"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<link href="${path}/resources/css/main.css?ver=95" rel="stylesheet">
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
			<th>작성자</th>
			<td>${post.nickName}</td>
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
</body>




<!-- 하단 푸터 -->
</div>
</body>
<footer class="py-3 bg-dark bg-gradient">
	<p class="m-0 text-center text-white">구디아카데미 프로젝트 1조</p>
	<p class="m-0 text-center text-white">Copyright &copy; Website 2021</p>
</footer>

</html>
