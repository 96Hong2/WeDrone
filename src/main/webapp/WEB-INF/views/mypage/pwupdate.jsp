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
<link rel = "icon" href = "resources/img/dron1.ico">
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>WeDrone</title>
<body>

	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="../fixmenu/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="../fixmenu/lognav.jsp" />
	</c:if>
	<!-- 들어갈 내용 -->
	<div class='row'>
		<!-- 사이드바 -->
		<div class="d-flex col-sm-2"
			style="height: auto; width: 200px; min-height: 100vh;">
			<nav id="sidebar" style="transition: all 0.3s;">
				<div class="list-group list-group-flush mt-3 ">
					<h2 class="fst-italic ms-3 fw-bold text-decoration-none fs-2">마이페이지</h2>
					<a class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/memberInfo" style="cursor: pointer;">내 정보</a> <a
						class="ps-4  list-group-item list-group-item-action active fs-5"
						href="${path}/pwchange" style="cursor: pointer;">비밀번호 변경</a><a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/mypost" style="cursor: pointer;">내가 쓴 글</a><a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/mycomment" style="cursor: pointer;">내가 쓴 댓글</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/myreview" style="cursor: pointer;">내 후기 마커</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/alarmlist" style="cursor: pointer;">알림 리스트</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/bookmark" style="cursor: pointer;">즐겨찾기</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/userout" style="cursor: pointer;">회원탈퇴</a>
				</div>
			</nav>
		</div>
		<!--들어갈 내용-->
		<div class="cont container mx-10 py-5 col-sm-8">
			<div class="d-flex align-items-center">
				<button type="button" id="sidebarCollapse"
					class="me-2 btn btn-warning">
					<i class="bi bi-info-circle"></i>
				</button>
				<h2 class="fw-bold my-3 fs-2">비밀번호 변경</h2>
			</div>
			<hr />
			<div class="cont container w-50">
				<!-- 내 정보 수정 폼 -->
				<form id="myinfoform" action="${path}/update" method="post"
					class="needs-validation py-3" novalidate>
					<div class="form-control col-md-9 mb-3">
						<label for="validationTooltip01" class="fw-bold">변경할 비밀번호</label>
						<input type="text" class="nullchecks nullcheck form-control"
							name="nickName" title="${updateSuc}" id="nickName"
							placeholder="비밀번호 입력" value="" required>
						<div id="check1" class="invalid-feedback">필수 정보입니다(20자 이하만
							가능)</div>
						<p class="visually-hidden text-success mt-1" id="pass">"사용가능합니다"</p>
						<p class="visually-hidden text-danger mt-1" id="fail">"사용불가"</p>
					</div>
					<hr />
					<div class="col text-center">
						<input id="infochange" class="btn btn-dark" type="submit"
							value="변경">
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>
	</div>
	</div>
	
			<!-- 날씨 위젯 시작 -->
<div style="position: fixed; bottom: 150px;  right: 0px;width: 100%; z-index: 3">
<div class="position-relative" class="modal hide fade" id="btn-weather"   tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div id="quick" class="position-absolute top-50 end-0 translate-middle-y" style="margin-right:0px;">
		<a href="#weather-layer1" 
			class="rounded-pill btn btn-success fw-bold" data-toggle="modal" class="btn" data-target="#myModal"> <i
			class="bi bi-info-circle"></i> 실시간 정보
		</a>
	</div>
</div>
</div>
<%@ include file="../common/weather-widget.jsp" %>
<!--// 날씨 위젯 끝 -->

	<script src="${path}/resources/js/js.js"></script>
	<script src="${path}/resources/js/common.js"></script>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>
