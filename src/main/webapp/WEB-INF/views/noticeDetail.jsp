<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="${path}/resources/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500&display=swap"
	rel="stylesheet">

<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="${path}/resources/css/main.css?ver=95" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js">
	
</script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.css" />
<script
	src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.js"></script>
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

body, html {
	font-family: 'Do Hyeon', sans-serif;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 6px;
	text-align: left;
}

table {
	width: 80%;
	margin-left: auto;
	margin-right: auto;
	height: 300px;
}

.h1-title {
	font-family: "Do Hyeon", sans-serif;
	font-style: normal;
	font-weight: 500;
	color: #212529;
	font-size: 2.5rem;
	margin-top: 30px;
	margin-bottom: 20px;
}

#proCommentBtn {
	margin: 20px 0px;
}

.left-td {
	border: 0px;
	width: 73%;
	padding: 30px !important;
}

.right-td {
	border: 0px;
	width: 10%;
}

.td-nickname {
	border: 0px;
	width: 17%;
}

#commentList-row {
	margin-bottom: 230px
}

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

table {
	border: 0px;
	height: auto;
}

.td-180 {
	padding-left: 120px !important;
}

.span-file a {
	text-decoration: none;
	color: black;
}
</style>
<link href="${path}/resources/css/common.css?var=3" rel="stylesheet">

</head>
<title>드론</title>
<body>
	<!-- 상단 메뉴바 -->
	<!-- 아이디가 있다면 -->
	<%-- <c:if test="${sessionScope.userId ne null}">
		<jsp:include page="${path}/lognav"></jsp:include>
	</c:if>
	<!-- 아이디가 없ㅇ 네비바-->
	<c:if test="${sessionScope.userId eq null}">
		<jsp:include page="${path}/navbar"></jsp:include>
	</c:if> --%>

	<div class="wrap">
		<!-- 네비게이션바 -->
		<c:if test="${sessionScope.loginId eq null}">
			<jsp:include page="./fixmenu/navbar.jsp" />
		</c:if>
		<c:if test="${sessionScope.loginId ne null}">
			<jsp:include page="./fixmenu/lognav.jsp" />
		</c:if>

		<h1 class="h1-title">공지사항 게시판 상세보기</h1>
		<table>

			<tr>
				<th>게시판 번호</th>
				<td>${post.postId}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${post.title}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${post.postDate}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${post.postContent}</td>
			</tr>
			<tr>
				<td colspan="2"><c:choose>
						<c:when test="${param.update eq 'ok' }">
							<button onclick="location.href='${path}/news'"
								class="btn btn-dark">리스트</button>
						</c:when>
						<c:otherwise>
							<button onclick="history.back();" class="btn btn-dark">리스트</button>
						</c:otherwise>
					</c:choose></td>
			</tr>
		</table>

	</div>
	<%@ include file="./common/footer.jsp"%>
</body>
</html>
