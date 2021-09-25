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
<style type="text/css">
table{
 font-family: "Do Hyeon", sans-serif;
}
.table-striped tbody tr:hover{
	background: #e9ecef;
	cursor: pointer;
}
.pagination{
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
.h1-title{
 font-family: "Do Hyeon", sans-serif;
 font-style: normal;
 font-weight: 500;
 color: #212529; 
 font-size: 2.5rem;
 margin-top: 30px;
 margin-bottom: 20px;
}
tbody a{
	text-decoration: none;
	color: #212529;
}
.page-link:focus, .page-link:hover {   
  outline:none;
}
nav {
    margin: 0;
    padding: 0;
    font-family: 'Do Hyeon', sans-serif;
    font-size: large;
    scroll-behavior: smooth;
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
	
	<!-- 날씨 위젯 시작 -->
<div style="position: fixed; bottom: 150px;  right: 0px;width: 100%;">
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

<div class="wrap">
		<div class="container bs-docs-container">
			<div class="row">
				<div class="col-md-12" style="margin-top: 30px">
					<h1 class="text-center h1-title">공지사항 게시판 목록</h1>
				</div>
				
 <div class="table-responsive">
					<table class="table table-striped">
					<thead>
		<tr>
			<th>No.</th>
			<th>제목</th>			
			<th>작성일</th>
		</tr>
		</thead>

		<c:if test="${noticeList eq null || noticeList eq ''}">
			<tr>
				<td colspan="5">해당 데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${noticeList}" var="post">
			<tr>
				<td>${post.postId}</td>
				<td><a href="noticeDetail?postId=${post.postId}">${post.title}</a></td>			
				<td>${post.postDate}</td>
			</tr>
		</c:forEach>
	</table>
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