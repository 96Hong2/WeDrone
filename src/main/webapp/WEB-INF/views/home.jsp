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

body, html {
	font-family: 'Do Hyeon', sans-serif;
}

</style>
</head>
<title>드론2</title>
<body>

<!-- 상단 메뉴바 -->
	<!-- 아이디가 있다면 -->
	<%-- <c:if test="${sessionScope.userId ne null}">
		<jsp:include page="${path}/lognav"></jsp:include>
	</c:if>
	<!-- 아이디가 없을때 네비바-->
	<c:if test="${sessionScope.userId eq null}">
		<jsp:include page="${path}/navbar"></jsp:include>
	</c:if> --%>

	<div class="wrap">
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
						<li class="nav-item dropdown "><a
							class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"
							href="#" role="button" aria-expanded="false"><h4>Map</h4></a>
							<ul class="dropdown-menu active">
								<li><a class="dropdown-item" href="#">비행지역 조회</a></li>
								<li><a class="dropdown-item" href="${path}/map">지도 보기</a></li></li>
					</ul>
					<li class="nav-item"><a class="nav-link active text-center "
						href="${path}/calendar"><h4>Calendar</h4></a></li> <a
						class="nav-link active" href="${path}/news"><h4>News</h4></a>
					</li>
					<li class="nav-item"><a class="nav-link active text-center "
						href="${path}/notice"><h4>Notice</h4></a></li>
					<li class="nav-item"><a class="nav-link active text-center "
						href="${path}/board"><h4>Board</h4></a></li>
					<li class="nav-item"></li>
					</ul>
					<div class="d-flex" id="alarmalert">
						<i id="bell" class="bi bi-bell-fill"
							style="font-size: 1.8rem; color: white"></i><br> <span
							id="cartalertnum"
							class="border border-dark position-absolute top-0 mx-3 badge bg-white text-white rounded-pill mt-2"></span>
					</div>
					<div class="d-flex">
						<a class="btn btn-sm btn-outline-light mx-3 me-1"
							href="${path}/login" role="button">로그인</a> <a
							class="btn btn-sm btn-outline-light me-1 mx-1"
							href="${path}/signup" role="button">회원가입</a> <a
							class="btn btn-sm btn-outline-light mx-1 me-1"
							href="${path}/mypages" role="button">마이페이지</a>
						<button class="btn btn-sm btn-outline-light mx-1 " type="button"
							data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
							aria-controls="offcanvasRight">메시지</button>
					</div>
				</div>
		</nav>



	
		<!--메인 슬라이드바  -->
		<div id="carouselExampleCaptions" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleCaptions"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="resources/img/c2.jpg" height="850" class="d-block w-100"
						alt="...">
					<div class="carousel-caption d-none d-md-block">
						<h2>드론 세상에 오신 것을 환영합니다</h2>
						<hr style="border: groove 3px white">

						<h4>우리는 드론을 사랑하는 사람들입니다. 드론에 관심 있는 사람이라면 언제든 환영합니다</h4>
					</div>
				</div>
				<div class="carousel-item">
					<img src="resources/img/c1.jpg" height="850" class="d-block w-100"
						alt="...">
					<div class="carousel-caption d-none d-md-block">
						<h2>비행 정보를 나누어보세요</h2>
						<hr style="border: groove 3px white">
						<h4>비행 후기를 들려주세요. 그것은 모든 사람들에게 즐거운 일이 될 것입니다</h4>
					</div>
				</div>
				<div class="carousel-item">
					<img src="resources/img/c3.jpg" height="850" class="d-block w-100"
						alt="...">
					<div class="carousel-caption d-none d-md-block">
						<h2>비행관련 실시간 기상정보를 확인하세요</h2>
						<hr style="border: groove 3px white">
						<h4>드론 비행에 있어 안전보다 중요한 일은 없습니다. 비행 전에 자기장 지수와 풍속, 미세먼지 등을
							확인하세요</h4>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>

		<!-- 퀵메뉴 -->
		<div class="position-relative">
			<div id="quick" class="position-fixed bottom-0 end-0">
				<a href="${path}/confusion"
					class="rounded-pill btn btn-success fw-bold"> <i
					class="bi bi-info-circle"></i> 실시간 정보
				</a>
			</div>
		</div>


		<!-- 오른쪽 슬라이드바 -->
		<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight"
			data-bs-backdrop="false">
			<div class="offcanvas-header">
				<h3 id="offcanvasRightLabel">Message</h3>
				<button type="button" class="btn-close text-reset"
					data-bs-dismiss="offcanvas" aria-label="Close"></button>
			</div>
			<div class="offcanvas-body">

				<!-- 메시지 UI 샘플-->
				<body>
					<div class="list-group">
						<a href="#" class="list-group-item list-group-item-action"
							aria-current="true">
							<div class="d-flex w-100 justify-content-between">
								<h5 class="mb-1">드로니</h5>
								<span class=" badge bg-secondary rounded-pill"
									style="text-align: right">14</span> <small class="text-muted">4
									days ago</small>
							</div>
							<p class="mb-1" style="text-align: left">지난 비행에서 사용하신 드론 모델명이
								무엇인가요?</p>
						</a> <a href="#" class="list-group-item list-group-item-action">
							<div class="d-flex w-100 justify-content-between">
								<h5 class="mb-1">김광배</h5>
								<span class="badge bg-secondary rounded-pill">2</span> <small
									class="text-muted">6 days ago</small>
							</div>
							<p class="mb-1" style="text-align: left">다음 비행모임에 오실거죠?</p>

						</a> <a href="#" class="list-group-item list-group-item-action">
							<div class="d-flex w-100 justify-content-between">
								<h5 class="mb-1">한솔</h5>
								<span class="badge bg-secondary rounded-pill">7</span> <small
									class="text-muted">1 days ago</small>
							</div>
							<p class="mb-1" style="text-align: left">다음에도 같이 비행하러 가실거죠? 꼭
								오세요!</p>
						</a> <a href="#" class="list-group-item list-group-item-action">
							<div class="d-flex w-100 justify-content-between">
								<h5 class="mb-1">드론왕</h5>
								<span class="badge bg-secondary rounded-pill">7</span> <small
									class="text-muted">1 days ago</small>
							</div>
							<p class="mb-1" style="text-align: left">구매하신 드론 부품 구매처가
								어디신가요? 저도 알려주세요</p>
						</a>
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
							<button class="btn btn-warning btn-sm" type="button">방나가기</button>
						</div>
					</div>


					</div>
		</div>
			</div>
		</div>

</body>


<!-- 하단 푸터 -->
</div>
<footer class="py-3 bg-dark bg-gradient">
	<p class="m-0 text-center text-white">구디아카데미 프로젝트 1조</p>
	<p class="m-0 text-center text-white">Copyright &copy; Website 2021</p>
</footer>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}
</script>
</html>