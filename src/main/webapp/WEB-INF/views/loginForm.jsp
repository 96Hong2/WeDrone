<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<title>위드론</title>
<body>
	<!-- 상단 메뉴바 -->
	<!-- 섹션에 아이디가 있다면 -->
	<c:if test="${sessionScope.loginId ne null}">

	</c:if>
	<!-- 섹션에 아이디가 없다면 -->
	<c:if test="${sessionScope.loginId eq null}">

	</c:if>
	<!-- 들어갈 내용 -->
	<div class="wrap d-flex align-items-center">
		<div class="container px-4 py-4 my-4 border shadow-lg" id="cont">
			<h4 class="mb-3 fw-bold">로그인</h4>
			<hr />
			<div class="container w-75">
				<form id="login" action="login" method="post">
					<div class="form-group">
						<label for="InputId" class="fw-bold">아이디</label> <input
							type="text" class="form-control" name="userId" id="userId"
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
						<button class="btn btn-dark"  name="login">로그인</button>
				</div>
			</form>
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
</html>