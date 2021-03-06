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
<title>WeDrone</title>
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
					<a class="ps-4  list-group-item list-group-item-action fs-5"
						href="${path}/memberInfo" style="cursor: pointer;">내 정보</a> <a
						class="ps-4  list-group-item list-group-item-action active fs-5"
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
						href="${path}/userout" style="cursor: pointer;">회원탈퇴</a>
				</div>
			</nav>
		</div>
		<!--들어갈 내용-->
		<div class="cont container mx-10 py-5 col-sm-8">
			<div class="d-flex align-items-center">
				<div class="container px-4 py-4 my-4 border shadow-lg" id="cont">
					<p class= fs-3>비밀번호 변경</p>
					<hr />
					<div class="container w-50">
						<form id="pwChangeForm" action="${path}/pwupdate" method="post">
							<div class="form-group">
								<label for="InputId" class="fw-bold"></label> <input
									type="hidden" class="form-control" name="userId" id="userId"
									<%-- <c:if test="${cookie.userId ne null}"> value="${cookie.userId.value}" </c:if> --%>
									value = "${sessionScope.loginId}" 
									placeholder="아이디를 입력해주세요">
								<div class="invalid-feedback">아이디를 입력해주세요</div>
							</div>
							<div class="form-group my-2">
								<label for="InputPassword" class="fw-bold">기존 비밀번호</label> <input
									type="password" class="form-control" name="pw" id="pw"  maxlength="20"
									placeholder="기존 비밀번호를 입력해주세요">
								<div class="invalid-feedback" id="pwInputChk">비밀번호를 입력해주세요</div>
							</div>
							<div class="form-group my-2">
								<label for="InputPassword" class="fw-bold">비밀번호 변경</label> <input
									type="password" class="form-control" name="pwChange" id="pwChange"  maxlength="20"
									placeholder="새 비밀번호 6~20자 입력" >
								<div class="invalid-feedback" id="pwInputChk2">변경할 비밀번호를 입력해주세요.</div>
							</div>
							<div class="form-group my-2">
								<label for="InputPassword" class="fw-bold">비밀번호 변경 확인</label> <input
									type="password" class="form-control" name="pwChange_chk" id="pwChange_chk"  maxlength="20"
									placeholder="다시 한 번 똑같이 입력해주세요" >
								<div class="invalid-feedback" id="pwInputChk3">변경할 비밀번호가 일치하지 않습니다.</div>
							</div>


							<c:if test='${success eq "fail"}'>
								<div id="redalert"
									class=" alert alert-danger d-flex align-items-center"
									role="alert">
									<svg class="bi flex-shrink-0 me-2" width="24" height="24"
										role="img" aria-label="Danger:">
						<use xlink:href="#exclamation-triangle-fill" /></svg>
									<div>없는 아이디거나 비밀번호가 틀립니다</div>
								</div>
							</c:if>
							<hr />
							<div>
								<button type='button' onclick="javascript:pwValidChk()" class="btn btn-dark" name="pwupdate">비밀번호 변경</button>
							</div>
						</form>
					</div>
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

<c:if test="${suc eq false }">
	<script type="text/javascript">
		alert("기존 비밀번호를 올바르게 입력해주세요.");
	</script>
</c:if>
<c:if test="${suc eq true }">
	<script type="text/javascript">
		alert("비밀번호 변경이 완료되었습니다!");
	</script>
</c:if>

<script type="text/javascript">

function hide_invalid_fb(){
	$(".invalid-feedback").hide();
}

function pwValidChk(){
	$(".invalid-feedback").hide();
	
	if($("#pw").val() == ""){
		$("#pwInputChk").show();
		return;
	}else if($("#pwChange").val() == ""){	
		$("#pwInputChk2").show();
		return;
	}else if($("#pwChange").val() != $("#pwChange_chk").val()){
		$("#pwInputChk3").show();
		return;
	}else{
		//alert("비번 변경!  :"+$("#pw").val());
		$("#pwChangeForm").submit();
	}
}

</script>

<!--// 날씨 위젯 끝 -->
      
      
	<script src="${path}/resources/js/js.js"></script>
	<script src="${path}/resources/js/common.js"></script>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>
