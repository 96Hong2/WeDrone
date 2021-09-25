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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
						href="${path}/memberDel" style="cursor: pointer;">회원탈퇴</a>
				</div>
			</nav>
		</div>
		<!--들어갈 내용-->
		<div class="cont container mx-10 py-5 col-sm-8">
			<div class="d-flex align-items-center">
				<div class="container px-4 py-4 my-4 border shadow-lg" id="cont">
					<p class= fs-3>본인 확인</p>
					<hr />
					<div class="container w-50">
						<form id="login2" action="${path}/pwupdate" method="post">
							<div class="form-group">
								<label for="InputId" class="fw-bold">아이디</label> <input
									type="text" class="form-control" name="userId" id="userId"
									<c:if test="${cookie.userId ne null}"> value="${cookie.userId.value}" </c:if>
									placeholder="아이디를 입력해주세요">
								<div class="invalid-feedback">아이디를 입력해주세요</div>
							</div>
							<div class="form-group my-2">
								<label for="InputPassword" class="fw-bold">비밀번호</label> <input
									type="password" class="form-control" name="pw" id="pw"
									placeholder="비밀번호를 입력해주세요">
								<div class="invalid-feedback">비밀번호를 입력해주세요</div>
							</div>


							<c:if test='${success eq "fail"}'>
								<div id="redalert"
									class=" alert alert-danger d-flex align-items-center"
									role="alert">
									<svg class="bi flex-shrink-0 me-2" width="24" height="24"
										role="img" aria-label="Danger:">
						<use xlink:href="#exclamation-triangle-fill" /></svg>
									<div>없는 아이디거나 비밀번호가 틀립니다</div>
								</div>
							</c:if>
							<hr />
							<div>
								<button class="btn btn-dark" name="pwupdate">로그인</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="${path}/resources/js/js.js"></script>
	<script src="${path}/resources/js/common.js"></script>
</body>
</html>
