<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>드론</title>
<!-- 부트스트랩 파일 -->
<link href="${path}/resources/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500&display=swap">
<!-- 아이콘 -->
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link href="${path}/resources/css/main.css?ver=99" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

<script src="resources/js/jquery.twbsPagination.js"></script>
<link href="${path}/resources/css/common.css?var=3" rel="stylesheet">

<script>
if("${sessionScope.loginId}"== null || "${sessionScope.loginId}"== ""){
   alert("로그인이 필요한 서비스 입니다.");
   location.href = "${pageContext.request.contextPath}/loginForm";
}
</script>

<style type="text/css">

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
    font-size: large;
    scroll-behavior: smooth;
}
</style>

</head>
<body>
		<!-- 네비게이션바 -->
		<c:if test="${sessionScope.loginId eq null}">
			<jsp:include page="./fixmenu/navbar.jsp" />
		</c:if>
		<c:if test="${sessionScope.loginId ne null}">
			<jsp:include page="./fixmenu/lognav.jsp" />
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
<%@ include file="common/weather-widget.jsp" %>
<!--// 날씨 위젯 끝 -->

	<div class="wrap">
		<div class="container bs-docs-container">
			<div class="row">
				<div class="col-md-12" style="margin-top: 30px">
					<h1 class="text-center h1-title">자유 게시판 목록</h1>
				</div>
				
				<c:if test="${not empty loginId }">
					<div class="col-md-12">
					<div class="page-item active" style="float: right; cursor: pointer;">
					 	<a class="page-link" href="${pageContext.request.contextPath}/fbwriteForm">글작성</a>
					 </div>	
					</div>
				</c:if>
				
				<div class="col-md-12 " role="main" style="margin-top: 30px">	
				 
				 		
				 <div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th width="10%">#</th>
								<th width="40%">제목</th>
								<th width="25%">작성자</th>
								<th width="25%">작성일</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${list}" var="row" varStatus="status">
							<tr onclick="detailMove('${row.POSTID}')">
								<th scope="row">${totalCount-row.RN +1}</th>
								<td><a href="${pageContext.request.contextPath}/fbdetail?postId=${row.POSTID}" >${row.TITLE}</a>
								&nbsp;&nbsp;&nbsp;
								<small>
								 <c:if test="${row.CMTCOUNT >0}">
								    <i class="fa fa-comments" title="댓글" ></i>&nbsp;${row.CMTCOUNT}
								 </c:if>
								 </small>
								</td>
								<td>${row.NICKNAME}</td>
								<td>${row.POSTDATE}</td>
							</tr>	
						</c:forEach>						
						</tbody>
						<tfoot>
							<tr><td colspan="4" class="text-center">
							<nav aria-label="...">${pagination}</nav>
							
							</td>
							</tr>
						</tfoot>
					</table>
					<form name="form" method="post" action="board">

							<select name="search_option">
								<option value="nickName"
									<c:if test="${map.search_option == 'm.nickName'}">selected</c:if>>작성자</option>

								<option value="title"
									<c:if test="${map.search_option == 'title'}">selected</c:if>>제목</option>
							</select>
							 <input name="keyword" value="${map.keyword}"> 
							<input type="submit" value="조회">
						</form>
				 </div>
				
				</div>
			</div>
		</div>
		
  </div>
  
<script>
function detailMove(postid){
	location.href='${pageContext.request.contextPath}/fbdetail?postId='+postid;	
}	
</script>  
  
  <%@ include file="./common/footer.jsp" %>
</body>
</html>
