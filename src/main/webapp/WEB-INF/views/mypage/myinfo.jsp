<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous">
	
</script>
<link href="${path}/resources/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Acme&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<!--폰트-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500&display=swap"
	rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css"
	integrity="sha384-wESLQ85D6gbsF459vf1CiZ2+rr+CsxRY0RpiF1tLlQpDnAgg6rwdsUF1+Ics2bni"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<link href="${path}/resources/css/main.css?ver=95" rel="stylesheet">
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
</style>
</head>
<title>드론</title>
<body>
	<!-- 상단 메뉴바 -->
	<!-- 아이디가 있다면 -->
	<%-- <c:if test="${sessionScope.userId ne null}">
		<jsp:include page="${path}/lognav"></jsp:include>
	</c:if>
	<!-- 아이디가 없을때 네비바-->
	<c:if test="${sessionScope.userId eq null}">
		<jsp:include page="${path}/navbar"></jsp:include>
	</c:if> --%>

	<div class="wrap">
		<!-- 네비게이션바 -->
		<nav class="navbar navbar-expand-lg navbar-dark"
			style="background-color: #3c3c3c;">
			<div class="container-fluid">
				<a
					class="fs-3 text-center navbar-brand fw-bold text-color: #003399;"
					href="${path}/"> <img src="resources/img/LOGO.png"
					class="rounded float-end rounded mx-auto d-block mx-2" alt=""
					width="50" height="50">WeDron
				</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active text-center"
							aria-current="page" href="${path}/map"><h4>Map</h4></a></li>
						<li class="nav-item"><a class="nav-link active text-center "
							href="${path}/calendar"><h4>Calendar</h4></a></li>
						<a class="nav-link active" href="${path}/news"><h4>News</h4></a>
						</li>
						<li class="nav-item"><a class="nav-link active text-center "
							href="${path}/notice"><h4>Notice</h4></a></li>
						<li class="nav-item"><a class="nav-link active text-center "
							href="${path}/board"><h4>Board</h4></a></li>


						<li class="nav-item"></li>
					</ul>
					<div class="d-flex" id="alarmalert">
						<i id="bell" class="bi bi-bell-fill"
							style="font-size: 1.8rem; color: white"></i><br> <span
							id="cartalertnum"
							class="border border-dark position-absolute top-0 mx-3 badge bg-white text-white rounded-pill mt-2"></span>
					</div>
					<div class="d-flex">
						<a class="btn btn-sm btn-outline-light  me-1 mx-2 "
							href="${path}/login" role="button">로그인</a> <a
							class="btn btn-sm btn-outline-light me-1 mx-1"
							href="${path}/signup" role="button">회원가입</a> <a
							class="btn btn-sm btn-outline-light mx-1 me-1"
							href="${path}/mypages" role="button">마이페이지</a>
						<button class="btn btn-sm btn-outline-light mx-1 " type="button"
							data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
							aria-controls="offcanvasRight">메시지</button>
					</div>
				</div>
		</nav>

		<!-- 사이드바 -->
		<div class="d-flex"
			style="height: auto; width: auto; min-height: 100vh;">

			<nav id="sidebar" style="transition: all 0.3s;">
				<div class="list-group list-group-flush mt-3 ">
					<h3 class="fst-italic ms-3 fw-bold text-decoration-none">마이페이지</h3>
					<a
						class="ps-4 fw-bold list-group-item list-group-item-action active"
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
						<i class="bi bi-info-circle"></i>
					</button>
					<h2 class="fw-bold my-3">내 정보 수정</h2>
				</div>
				<hr />
				<div class="cont container w-50">
					<!-- 내 정보 수정 폼 -->
					<form id="myinfoform" action="/Project/memberupdate" method="post"
						class="needs-validation py-3" novalidate>
						<div class="form-floating col-md-9 mb-3">
							<input type="text" class="form-control" name="nickName"
								id="nickName" placeholder="닉네임" value="" required> <label
								for="validationTooltip01" class="fw-bold">닉네임</label>
							<div id="check1" class="invalid-feedback">중복확인을 다시 해주세요</div>
							<div id="check2" class="invalid-feedback visually-hidden">필수
								정보입니다(100자 이하만 가능)</div>
							<input type="button" class="btn btn-dark mt-2" id="ckBtn"
								value="중복확인">
							<!-- 중복확인 끝 -->
							<p class="visually-hidden text-success mt-1" id="pass">"사용가능합니다"</p>
							<p class="visually-hidden text-danger mt-1" id="fail">"사용불가"</p>
						</div>

						<div class="form-floating col-md-9 mb-3">
							<input type="password" class="nullchecks form-control"
								name="UserPw" id="UserPw" placeholder="비밀번호" value="" required>
							<label for="validationTooltip02" class="fw-bold">비밀번호</label>
							<div class="invalid-feedback">10자 이상 입력해주세요</div>
						</div>
						<div class="form-floating col-md-9 mb-3">
							<input type="password" class="form-control" id="UserPwch"
								name="UserPwch" placeholder="비밀번호확인" value="" required>
							<label for="validationTooltip02" class="fw-bold">비밀번호확인</label>
							<div class="invalid-feedback">동일한지 확인해주세요</div>
						</div>

						<div class="col-md-9 mb-3">
							<label for="checks" class="fw-bold" id="emailsusin"
								name="emailsusin">알림 수신</label>
							<div class="form-check form-check-inline mx-3">
								<label class="form-check-label" for="emailcheckchange1">
									동의 </label> <input class="form-check-input" type="radio" value="Y"
									name="emailcheckchange" id="emailcheckchange1"
									<c:if test="${dto.emailCheck eq 'Y'}">checked</c:if>>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="emailcheckchange" id="emailcheckchange2" value="N"
									<c:if test="${dto.emailCheck eq 'N'}">checked</c:if>> <label
									class="form-check-label" for="emailcheckchange2"> 거부 </label>
							</div>
						</div>
						<hr />
						<div class="col text-center">
							<input id="infochange" class="btn btn-dark" type="button"
								value="정보수정">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</div>
	<script>
		$('#ckBtn').click(function() {
			var userId = $('#UserId').val().trim();
			console.log(userId);
			if (userId != "" && userId.length <= 100) {
				$('#check2').addClass('visually-hidden');
				$('#check1').removeClass('visually-hidden');
				$.ajax({
					type : "POST",//방식(닉네임이라 POST로 해야함)
					url : "${path}/signupcheck",//주소 ->닉네임
					data : {
						userId : userId
					},
					dataType : 'JSON',
					success : function(data) { //성공시
						console.log(data);
						if (data.suc) {
							$('#pass').addClass("visually-hidden");
							$('#fail').removeClass("visually-hidden");
							$('#UserId').removeClass("is-valid");
							$('#UserId').addClass("is-invalid");
						} else {
							$('#pass').removeClass("visually-hidden");
							$('#fail').addClass("visually-hidden");
							$('#UserId').removeClass("is-invalid");
							$('#UserId').addClass("is-valid");
							$('#UserId').attr('readonly', true)
						}
					},
					error : function(e) { //실패시
						console.log(e);
					}
				});
			} else {
				$('#check2').removeClass('visually-hidden');
				$('#check1').addClass('visually-hidden');
				$('#UserId').addClass("is-invalid");
			}
		})
	</script>
	<!-- 하단 푸터 -->

	<footer class="py-3 bg-dark bg-gradient">
		<p class="m-0 text-center text-white">구디아카데미 프로젝트 1조</p>
		<p class="m-0 text-center text-white">Copyright &copy; Website
			2021</p>
	</footer>
