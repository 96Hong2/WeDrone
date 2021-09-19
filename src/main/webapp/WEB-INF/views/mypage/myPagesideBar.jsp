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

	<div class='row'>
		<!-- 사이드바 -->
		<div class="d-flex col-sm-2"
			style="height: auto; width: 500px; min-height: 100vh;">

			<nav id="sidebar" style="transition: all 0.3s;">
				<div class="list-group list-group-flush mt-3 ">
					<h3 class="fst-italic ms-3 fw-bold text-decoration-none ">마이페이지</h3>
					<a
						class="ps-4 fw-bold list-group-item list-group-item-action active fs-5"
						href="${path}/myinfo" style="cursor: pointer;">내 정보</a> <a
						class="ps-4 fw-bold list-group-item list-group-item-action fs-5"
						href="${path}/mypost" style="cursor: pointer;">내가 쓴 글</a><a
						class="ps-4 fw-bold list-group-item list-group-item-action fs-5"
						href="${path}/mycomment" style="cursor: pointer;">내가 쓴 댓글</a> <a
						class="ps-4 fw-bold list-group-item list-group-item-action fs-5"
						href="${path}/myreview" style="cursor: pointer;">내 후기 마커</a> <a
						class="ps-4 fw-bold list-group-item list-group-item-action fs-5"
						href="${path}/alarmlist" style="cursor: pointer;">알림 리스트</a> <a
						class="ps-4 fw-bold list-group-item list-group-item-action fs-5"
						href="${path}/bookmark" style="cursor: pointer;">즐겨찾기</a> <a
						class="ps-4 fw-bold list-group-item list-group-item-action fs-5"
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
				<h2 class="fw-bold my-3">내정보</h2>
			</div>
			<hr />
			<div class="cont container w-50">
				<!-- 내 정보 수정 폼 -->
				<form id="myinfoform" action="/Project/memberupdate" method="post"
					class="needs-validation py-3" novalidate>
					<div class="form-floating col-md-9 mb-3">
						<input type="text" class="nullchecks form-control"
							value="${dto.name}" title="${updateSuc}" id="UserName"
							name="UserName" placeholder="이름" required> <label
							for="validationTooltip04" class="fw-bold">닉네임</label>
						<div class="invalid-feedback">필수 정보입니다</div>
					</div>

					<div class="form-floating col-md-9 mb-3">
						<input type="text" class="nullchecks form-control" id="UserEmail"
							name="UserEmail" placeholder="이메일" value="${dto.email}"
							aria-describedby="validationTooltipUsernamePrepend" required>
						<label for="validationTooltipUsername" class="fw-bold">비밀번호</label>
						<div class="invalid-feedback">필수 정보입니다</div>
					</div>

					<div class="col-md-9 mb-3">
						<label for="checks" class="fw-bold" id="emailsusin"
							name="emailsusin">알림 수신</label>
						<div class="form-check form-check-inline mx-3">
							<label class="form-check-label" for="emailcheckchange1">
								동의 </label> <input class="form-check-input" type="radio" value="Y"
								name="emailcheckchange" id="emailcheckchange1"
								<c:if test="${dto.emailCheck eq 'Y'}">checked</c:if>>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="emailcheckchange" id="emailcheckchange2" value="N"
								<c:if test="${dto.emailCheck eq 'N'}">checked</c:if>> <label
								class="form-check-label" for="emailcheckchange2"> 거부 </label>
						</div>
					</div>
					<hr />
					<div class="col text-center">
						<input id="infochange" class="btn btn-dark" type="button"
							value="정보수정">
					</div>

				</form>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${path}/resources/js/js.js"></script>
	<script src="${path}/resources/js/common.js"></script>
	<%@ include file="../common/footer.jsp" %>
</body>

<script>
</script>
</html>
