<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<style type="text/css">
.pagination {
	display: inline-flex !important;
}

.page-item.active .page-link {
	background-color: #41464b;
	border-color: #41464b;
}

.page-link {
	color: #41464b;
}

.page-link:hover {
	color: #212529;
	background-color: #e9ecef;
	border-color: #dee2e6;
}

tbody a {
	text-decoration: none;
	color: #212529;
}

.unread {
	color: #0d6efd;
}

.alarm-btn {
	background: #484747;
	color: #ffffff;
}

.alarm-btn:hover {
	background: black;
	color: #ffffff;
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
	<nav
		style="-bs-breadcrumb-divider: url(&amp; #34; data: image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&amp;#34;);"
		aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item fs-4"><a href="${path}/">Home</a></li>
			<li class="breadcrumb-item active fs-4" aria-current="page">Mypage</li>
		</ol>
	</nav>

	<div class='row'>
		<!-- 사이드바 -->
		<div class="d-flex col-sm-2"
			style="height: auto; width: 200px; min-height: 100vh;">

			<nav id="sidebar" style="transition: all 0.3s;">
				<div class="list-group list-group-flush mt-3 ">
					<h2 class="fst-italic ms-3 fw-bold text-decoration-none fs-2">마이페이지</h2>
					<a class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/memberInfo" style="cursor: pointer;">내 정보</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/pwchange" style="cursor: pointer;">비밀번호 변경</a> <a
						class="ps-4 list-group-item list-group-item-action fs-5"
						href="${path}/mypost" style="cursor: pointer;">내가 쓴 글</a><a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/mycomment" style="cursor: pointer;">내가 쓴 댓글</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/myreview" style="cursor: pointer;">내 후기 마커</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/alarmlist" style="cursor: pointer;">알림 리스트</a> <a
						class="ps-4 list-group-item list-group-item-action fs-5"
						href="${path}/bookmark" style="cursor: pointer;">즐겨찾기</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/memberDel" style="cursor: pointer;">회원탈퇴</a>
				</div>
			</nav>
		</div>

		<!--들어갈 내용-->
		<div class="cont container mx-12 py-5 col-sm-8">
			<div class="d-flex align-items-center">
				<button type="button" id="sidebarCollapse"
					class="me-2 btn btn-warning">
					<i class="bi bi-book"></i>
				</button>
				<h2 class="fw-bold my-3 fs-2">알림 리스트</h2>
			</div>
			<hr />

			<div class="col-md-12 ">
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th width="10%">#</th>
								<th width="40%">알림 내용</th>
								<th width="25%">날짜</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="row" varStatus="status">
								<tr onclick="alarmMove('${row.RELATEDID}')">
									<th scope="row">${totalCount-row.RN +1}</th>
									<td><a
										href="${pageContext.request.contextPath}/alarmLinkMove?type=fbdetail&postId=${row.RELATEDID}&informid=${row.INFORMID}">
											${row.INFORMCONTENT} <span class='unread'>${row.ISREAD  eq 'N' ? '(읽지않음)':''}</span>
									</a></td>
									<td>${row.INFORMDATE}</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="4" class="text-center">
									<nav aria-label="...">${pagination}</nav>

								</td>
							</tr>
						</tfoot>
					</table>
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

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${path}/resources/js/js.js"></script>
	<script src="${path}/resources/js/common.js"></script>
	<%@ include file="../common/footer.jsp"%>
</body>

<script>
	
</script>
</html>
