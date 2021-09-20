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
<link href="https://fonts.googleapis.com/css2?family=Acme&display=swap" rel="stylesheet">

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


</style>
</head>
<title>드론</title>
<body>
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