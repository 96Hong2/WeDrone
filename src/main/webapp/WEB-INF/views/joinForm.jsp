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
<%--<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">--%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<%-- 공통 css --%>
<link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
</head>
<style>
<
style> /* 푸터 위의 내용 감싸서 내용 없어도 푸터 하단으로 가도록 */ .wrap {
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

<script>
	$(document).ready(function() {
		var idCheck = false;
		var nickCheck = false;

		$("#joinBtn").on("click", function() {
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
			if ($("#nickName").val() == "") {
				alert("닉네임을 입력해주세요.");
				$("#nickName").focus();
				return false;
			}
			if ($("#pw").val() != $("#UserPwch").val()){
				alert("비밀번호를 다시한번 확인해주세요.")
				$("#UserPwch").val("");
				$("#UserPwch").focus();
				return false;
			}
			if ($("#userId").val().length < 3) {
				alert("아이디는 4글자 이상이어야 합니다.")				
				$("#userId").focus();
				return false;
			}
			if ($("#pw").val().length < 5) {
				alert("비밀번호는 6글자 이상이어야 합니다.")				
				$("#pw").focus();
				return false;
			}
			if ($("#nickName").val().length < 1) {
				alert("닉네임은 2글자 이상이어야 합니다.")				
				$("#nickname").focus();
				return false;
			}
			
		});
	})
</script>
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
	<div class="wrap">
		<div class="container px-4 py-4 my-4 border shadow-lg" id="cont">
			<h4 class="mb-3 fw-bold">회원가입</h4>
			<hr />
			<form action="join" method="post" class="needs-validation"
				onsubmit="return check();" novalidate>

				<div class="form-floating col-md-9 mb-3">
					<input type="text" class="form-control" name="userId" id="userId"
						placeholder="아이디(4~10자)" maxlength="10" value="" required>
					<label for="validationTooltip01" class="fw-bold"></label> <input
						type="button" class="btn btn-dark btn-sm mt-2" id="idCheck"
						value="중복확인">

				</div>
				<div class="form-floating col-md-9 mb-3">
					<input type="password" class="nullchecks form-control" name="pw"
						id="pw" placeholder="비밀번호(6~20자)" maxlength="20" value="" required>
					<label for="validationTooltip02" class="fw-bold"></label>
					<div class="invalid-feedback">필수 정보입니다</div>
				</div>
				<div class="form-floating col-md-9 mb-3">
					<input type="password" class="form-control" id="UserPwch"
						name="pwch" placeholder="비밀번호확인" maxlength="20" value="" required>
					<label for="validationTooltip02" class="fw-bold"></label>
					<div class="invalid-feedback">동일한지 확인해주세요</div>
				</div>
				<div class="form-floating col-md-9 mb-3">
					<input type="text" class="nullchecks nullcheck form-control"
						id="nickName" name="nickName" placeholder="닉네임(2~7자)"
						maxlength="7" required> <label for="validationTooltip04"
						class="fw-bold"></label> <input type="button"
						class="btn btn-dark btn-sm mt-2" id="nickCheck" value="중복확인">
						
				</div>

				<div class="col-md-9 mb-3">
					<label for="validationTooltip05" class="fw-bold">메시지 좋아요 알림
						수신 여부</label>
					<div class="form-check form-check-inline mx-3">
						<input class="form-check-input" type="radio" name="chkAlert"
							id="alertradio1" value="Y" checked> <label
							class="form-check-label" for="alertradio">동의 </label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="chkAlert"
							id="alertradio2" value="N"> <label
							class="form-check-label" for="alertradio2"> 거부 </label>
					</div>
				</div>

				<hr />
				<div class="col text-center">
					<input class="btn btn-dark" type="submit" id="joinBtn" value="가입하기">
				</div>

			</form>
		</div>
	</div>
	<script>
		$("#idCheck").click(function() {
			console.log(userId);
			$.ajax({
				type : 'post',
				url : 'idCheck',
				data : {
					"userId" : $("#userId").val()
				},
				dataType : 'JSON',
				success : function(data) {
					console.log(data);
					if (data == 1) {
						alert("중복된 아이디입니다.");
					} else if (data == 0) {
						alert("사용 가능한 아이디입니다.");
						$("#idCheckOk").attr("value", "Y");
					}
				}
			})
		})

		$("#nickCheck").click(function() {
			;
			console.log(nickName);
			$.ajax({
				type : 'post',
				url : 'nickCheck',
				data : {
					"nickName" : $("#nickName").val()
				},
				dataType : 'JSON',
				success : function(data) {
					console.log(data);
					if (data == 1) {
						alert("중복된 닉네임입니다.");
					} else if (data == 0) {
						alert("사용 가능한 닉네임입니다.");
						$("#nickCheckOk").attr("value", "Y");
					}
				}
			})
		})
	</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/js.js"></script>
<script src="${path}/resources/js/common.js"></script>
</body>
</html>
