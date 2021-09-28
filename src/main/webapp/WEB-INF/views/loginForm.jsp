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
<%--<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">--%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<%-- 공통 css --%>
<link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script>
$(document).ready(function() {
	$("#loginBtn").on("click", function() {
		
			if ($("#userId").val() == "") {
				alert("아이디를 입력해주세요.");
				$("#userId").focus();
				return false;
			}
			if ($("#pw").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#pw").focus();
				return false;
			}
	});
})
</script>

<title>WeDrone</title>
<body>
	<!-- 상단 메뉴바 -->
	<!-- 섹션에 아이디가 있다면 -->
	<c:if test="${sessionScope.userId ne null}">

	</c:if>
	<!-- 섹션에 아이디가 없다면 -->
	<c:if test="${sessionScope.userId eq null}">

	</c:if>
	<!-- 들어갈 내용 -->
	
	<div class="cont container mx-10 py-5 col-sm-8">
			<div class="d-flex align-items-center">
		<div class="container px-4 py-4 my-4 border shadow-lg" id="cont">
			<h4 class="mb-3 fw-bold">로그인</h4>
			<hr />
			<div class="container w-50">
				<form id="login" action="login" method="post">
					<div class="form-group">
						<label for="InputId" class="fw-bold">아이디</label> <input
							type="text" class="form-control" name="userId" id="userId" cheked
							<c:if test="${cookie.userId ne null}"> value="${cookie.userId.value}" </c:if>
							placeholder="아이디를 입력해주세요">
						<div class="invalid-feedback">아이디를 입력해주세요</div>
					</div>
					<div class="form-group my-2">
						<label for="InputPassword" class="fw-bold">비밀번호</label> <input
							type="password" class="form-control" name="pw"
							id="pw" placeholder="비밀번호를 입력해주세요">
						<div class="invalid-feedback">비밀번호를 입력해주세요</div>	</div>
					
				
				<c:if test='${success eq "fail"}'>
					<div id="redalert"
						class=" alert alert-danger d-flex align-items-center" role="alert">
						<svg class="bi flex-shrink-0 me-2" width="24" height="24"
							role="img" aria-label="Danger:">
						<use xlink:href="#exclamation-triangle-fill" /></svg>
						<div>없는 아이디거나 비밀번호가 틀립니다</div>
					</div>
				</c:if>
				<hr />
				<div>					
						<button class="btn btn-dark"  name="login" id="loginBtn">로그인</button>
				</div>
			</form>
			</div>
			</div>
		</div>
	</div>	
</body>
<script>
var msg = "${msg}";
if(msg != ""){
	alert(msg);
}

</script>

<script src="${path}/resources/js/js.js"></script>
<script src="${path}/resources/js/common.js"></script>
</body>
</html>

