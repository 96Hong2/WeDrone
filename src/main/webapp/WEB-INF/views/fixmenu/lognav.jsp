<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<%-- 부트 스트랩 메타태그 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%-- 부트 스트랩 아이콘 --%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<!-- 부트스트랩 css 추가 -->
<%--<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">--%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<%-- 공통 css --%>
<link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
</head>
<style>
<
style> /* 푸터 위의 내용 감싸서 내용 없어도 푸터 하단으로 가도록 */ .wrap {
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
</style>

<script>
	$('.dropdown').hover(
			function() {
				$(this).find('.dropdown-menu active').stop(true, true).delay(
						200).fadeIn();
			},
			function() {
				$(this).find('.dropdown-menu active').stop(true, true).delay(
						200).fadeOut();
			});

	$('.dropdown-menu active').hover(function() {
		$(this).stop(true, true);
	}, function() {
		$(this).stop(true, true).delay(200).fadeOut();
	});
</script>
</head>

<title>드론</title>
<body>
	<div class="wrap">
		<nav class="navbar navbar-expand-lg navbar-dark"
			style="background-color: #3c3c3c;">
			<div class="d-flex justify-content-end">

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
						<button class="btn btn-sm btn-outline-light mx-1 me-1">로그인</button>
						<button class="btn btn-sm btn-outline-light me-1 mx-1"
							type="submit">로그아웃</button>

						<a class="btn btn-sm btn-outline-light  mx-1" role="button"
							href="${path}/mypage">마이페이지</a>
						<button class="btn btn-sm btn-outline-light mx-1 " type="button"
							data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
							aria-controls="offcanvasRight">기타</button>
					</div>
				</div>
		</nav>
	</div>


	</script>