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
					<a class="ps-4  list-group-item list-group-item-action active fs-5"
						href="${path}/memberInfo" style="cursor: pointer;">내 정보</a> <a
						class="ps-4  list-group-item list-group-item-action fs-5"
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
				<button type="button" id="sidebarCollapse"
					class="me-2 btn btn-warning">
					<i class="bi bi-info-circle"></i>
				</button>
				<h2 class="fw-bold my-3 fs-2">내 정보 수정</h2>
			</div>
			<hr />
			<div class="cont container w-50">
				<!-- 내 정보 수정 폼 -->
				<form id="myinfoform" action="${path}/memberupdate" method="post"
					class="needs-validation py-3" novalidate>
					<div class="form-control col-md-9 mb-3">
						<label for="validationTooltip01" class="fw-bold">닉네임</label> <input
							type="text" class="nullchecks nullcheck form-control"
							name="nickName" title="${updateSuc}
							id="nickName" placeholder="닉네임" value="${dto.nickName}"
							required>
						<div id="check1" class="invalid-feedback">중복확인을 다시 해주세요</div>
						<div id="check2" class="invalid-feedback visually-hidden">필수
							정보입니다(100자 이하만 가능)</div>

						<input type="button" class="btn btn-secondary btn-sm mt-2"
							id="nickCheck" value="중복확인">
						<!-- 중복확인 끝 -->
						<p class="visually-hidden text-success mt-1" id="pass">"사용가능합니다"</p>
						<p class="visually-hidden text-danger mt-1" id="fail">"사용불가"</p>
					</div>

					<div class="form-control col-md-9 mb-3">
					<label for="validationTooltip02" class="fw-bold">비밀번호</label>
						<input type="password" class="form-control" name="UserPw"
							id="UserPw" placeholder="비밀번호" value="" required>
						<div class="invalid-feedback">10자 이상 입력해주세요</div>
					</div>
					<div class="form-control col-md-9 mb-3">
					<label for="validationTooltip02" class="fw-bold">비밀번호 변경확인</label>
						<input type="password" class="form-control" id="UserPwchs"
							name="UserPwchs" placeholder="비밀번호확인" value="" required>
						<div class="invalid-feedback">동일한지 확인해주세요</div>
						<input id="infopwchange" class="btn btn-secondary btn-sm mt-2"
							type="button" value="비밀번호 변경">
					</div>

					<div class="col-md-9 mb-3">
						<label for="checks" class="fw-bold" id="chkAlert" name="chkAlert">알림
							수신</label>
						<div class="form-check form-check-inline mx-3">
							<label class="form-check-label" for="alarmcheckchange">
								동의 </label> <input class="form-check-input" type="radio" value="Y"
								name="chkAlert" id="chkAlert"
								<c:if test="${dto.chkAlert eq 'Y'}">checked</c:if>>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="alarmcheckchange" id="chkAlert2" value="N"
								<c:if test="${dto.chkAlert eq 'N'}">checked</c:if>> <label
								class="form-check-label" for="alarmcheckchange2"> 거부 </label>
						</div>
					</div>
					<hr/>
					<div class="col text-center">
						<input id="infochange" class="btn btn-dark" type="submit"
							onclick="go_submit()" value="정보수정">
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>
	</div>
	</div>
	<script>

	$("#nickCheck").click(function() {
			
			console.log("nickName");
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
	
		$('#infopwchange').click(function() {
							if ($('#UserPw').val().trim() == "") {
								$('#UserPw').attr('class','nullchecks form-control is-invalid');
							}
							
							if ($('#UserPw').attr('class') == 'form-control is-valid'
									&& $('#UserPwchs').attr('class') == 'form-control is-valid') {
								//UserName 요소의 class 속성의 값을 가져온다.
								console.log("안녕 비번바뀌었어");
								$(this).attr('type', 'submit');
								//inforchange 요소에 type 속성을 추가하고 속성의 값은 submit으로 적용합니다.		
							}
						})
						$("#UserPwchs").on("propertychange change keyup paste input",function() {
												if ($("#UserPw").val() == $(this).val()) {
													$(this).attr("class","form-control is-valid");
												} else {
													$(this).attr("class","form-control is-invalid");
												}
											});
	
		$('#infochange').click(function() {
							if ($('#nickName').attr('class') != 'form-control is-invalid'
									&& $('#pw').attr('class') != 'form-control is-invalid') {
								//nkckName 요소의 class 속성의 값을 가져온다.
								console.log("정보 바뀜");
								$(this).attr('type', 'submit');
								//inforchange 요소에 type 속성을 추가하고 속성의 값은 submit으로 적용한다.		
							}
						})
		

		
		</script>

	<script src="${path}/resources/js/js.js"></script>
	<script src="${path}/resources/js/common.js"></script>
</body>
</html>
