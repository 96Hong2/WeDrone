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
	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="../fixmenu/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="../fixmenu/lognav.jsp" />
	</c:if>

	<!-- 들어갈 내용 -->
	<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="${path}/">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Calendar</li>
  </ol>
</nav>

	<div class='row'>
		<!-- 사이드바 -->
		<div class="d-flex col-sm-2"
			style="height: auto; width: 200px; min-height: 100vh;">
			<nav id="sidebar" style="transition: all 0.3s;">
				<div class="list-group list-group-flush mt-3 ">
					<h2 class="fst-italic ms-3 fw-bold  item-align-center fs-2">마이페이지</h2>
					<a class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/myinfo" style="cursor: pointer;">내 정보</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/mypost" style="cursor: pointer;">내가 쓴 글</a><a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/mycomment" style="cursor: pointer;">내가 쓴 댓글</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/myreview" style="cursor: pointer;">내 후기 마커</a> <a
						class="ps-4 list-group-item list-group-item-action active fs-5"
						href="${path}/alarmlist" style="cursor: pointer;">알림 리스트</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/bookmark" style="cursor: pointer;">즐겨찾기</a> <a
						class="ps-4 list-group-item list-group-item-action fs-5"
						href="${path}/userout" style="cursor: pointer;">회원탈퇴</a>
				</div>
			</nav>
		</div>
		<div class="cont container mx-10 py-5 col-sm-8">
			<div class="d-flex align-items-center">
				<button type="button" id="sidebarCollapse"
					class="me-2 btn btn-warning">
					<i class="bi bi-bell"></i>
				</button>
				<h2 class="fw-bold my-3 fs-2">알림 리스트</h2>
			</div>
			<hr />
			<div class="cont container w-50">
				<!-- 알림리스트 -->
				<div id="alarmBox" class="cont container w-50">
					<c:if test="${alarmList[0].alarmContent ne null}">
						<c:forEach items="${alarmList}" var="alarmLists">
							<div class="d-flex form-check align-items-center m-0 p-0">
								<input class="form-check-input me-2" type="checkbox"
									value="${alarmLists.alarmNum}" id="flexCheckChecked"
									name="alarmDelNum">
								<div class="mt-3 flex-grow-1 alert alert-warning" role="alert">${alarmLists.alarmContent}</div>
							</div>
						</c:forEach>
						<div class="form-check my-1">
							<input class="form-check-input" type="checkbox" value="1"
								id="allCheck"> <label class="form-check-label fw-bold"
								for="defaultCheck1">전체선택</label>
							<div class="invalid-feedback">약관에 동의해주세요</div>
						</div>
						<div class="col text-center">
							<button id="cafeAlarmDelBtn" class="btn btn-dark" type="button">삭제</button>
						</div>
					</c:if>
					<c:if test="${AlarmList[0].alarmContent eq null}">
						<div class="text-center text-muted">
							<h3>등록된 알림이 없습니다</h3>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>



	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${path}/resources/js/js.js"></script>
	<script src="${path}/resources/js/common.js"></script>
</body>

<script>
	
</script>
</html>
