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
<link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
</head>
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
<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="../fixmenu/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="../fixmenu/lognav.jsp" />
	</c:if>

<!-- 들어갈 내용 -->
	

		<!-- 사이드바 -->
		<div class="d-flex"
			style="height: auto; width: auto; min-height: 100vh;">

			<nav id="sidebar" style="transition: all 0.3s;">
				<div class="list-group list-group-flush mt-3 ">
					<h3 class="fst-italic ms-3 fw-bold text-decoration-none">마이페이지</h3>
					<a class="ps-4 fw-bold list-group-item list-group-item-action"
						href="${path}/myinfo" style="cursor: pointer;"><h5>내 정보</h5></a> <a
						class="ps-4 fw-bold list-group-item list-group-item-action"
						href="${path}/mypost" style="cursor: pointer;"><h5>내가 쓴 글</h5></a><a
						class="ps-4 fw-bold list-group-item list-group-item-action"
						href="${path}/mycomment" style="cursor: pointer;"><h5>내가
							쓴 댓글</h5></a> <a
						class="ps-4 fw-bold list-group-item list-group-item-action"
						href="${path}/myreview" style="cursor: pointer;"><h5>내 후기
							마커</h5></a> <a class="ps-4 fw-bold list-group-item list-group-item-action"
						href="${path}/alarmlist" style="cursor: pointer;"><h5>알림
							리스트</h5></a> <a
						class="ps-4 fw-bold list-group-item list-group-item-action"
						href="${path}/bookmark" style="cursor: pointer;"><h5>즐겨찾기</h5></a>
					<a class="ps-4 fw-bold list-group-item list-group-item-action"
						href="${path}/userout" style="cursor: pointer;"><h5>회원탈퇴</h5></a>
				</div>
			</nav>


			<!--들어갈 내용-->
			<div class="cont container mx-10 py-5">
				<div class="d-flex align-items-center">
					<button type="button" id="sidebarCollapse"
						class="me-2 btn btn-warning">
						<i class="bi bi-book"></i>
					</button>
					<h2 class="fw-bold my-3">마이 페이지</h2>
				</div>
				<hr />
				<div class="cont container w-50">
					<!-- 내 정보 수정 폼 -->

				</div>
			</div>
		</div>
	</div>

</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
<!-- 하단 푸터 -->
<jsp:include page="../fixmenu/footer.jsp"></jsp:include>
<script>
</script>
</html>
