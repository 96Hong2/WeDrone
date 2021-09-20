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
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<%-- 공통 css --%>
<link href="${path}/resources/css/common.css?var=3" rel="stylesheet">
</head>
<title>드론</title>
<body>
	<!-- 아이디 있을 때 네비바 -->
	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="fixmenu/lognav.jsp" />
	</c:if>

	<!-- 아이디 없을때 네비바 -->
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="fixmenu/navbar.jsp" />
	</c:if>


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
				<img src="resources/img/c2.jpg" height="700" class="d-block w-100"
					alt="...">
				<div class="carousel-caption d-none d-md-block">
					<h2>드론 세상에 오신 것을 환영합니다</h2>
					<hr style="border: groove 3px white">

					<h4>우리는 드론을 사랑하는 사람들입니다. 드론에 관심 있는 사람이라면 언제든 환영합니다</h4>
				</div>
			</div>
			<div class="carousel-item">
				<img src="resources/img/c1.jpg" height="700" class="d-block w-100"
					alt="...">
				<div class="carousel-caption d-none d-md-block">
					<h2>비행 정보를 나누어보세요</h2>
					<hr style="border: groove 3px white">
					<h4>비행 후기를 들려주세요. 그것은 모든 사람들에게 즐거운 일이 될 것입니다</h4>
				</div>
			</div>
			<div class="carousel-item">
				<img src="resources/img/c3.jpg" height="700" class="d-block w-100"
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
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
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
	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="fixmenu/msgbar.jsp" />
	</c:if>


</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
<script>
	
</script>
</html>