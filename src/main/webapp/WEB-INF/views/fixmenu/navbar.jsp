<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap" rel="stylesheet">
<!--  -->
<c:set var="path" value="${pageContext.request.contextPath}" />
<nav class="navbar navbar-expand-lg navbar-dark bg-dark"
	style="back-groundcolor:#3c3c3c;">
	<div class="container-fluid">
		<a class="text-center navbar-brand"
			href="${path}/" id="weDrone"> <img src="resources/img/LOGO.png"
			class="rounded float-end rounded mx-auto d-block mx-2" alt=""
			width="50" height="50">WeDrone
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0 navbar-left">
				<li class="nav-item dropdown "><a
					class="nav-link dropdown-toggle fs-5 "
					data-bs-toggle="dropdown" href="#" role="button"
					aria-expanded="false">Map</a>
					<ul class="dropdown-menu active">
						<li><a class="dropdown-item" href="${path}/warnmap">비행지역 조회</a></li>
						<li><a class="dropdown-item" href="${path}/map">지도 보기</a></li>
					</ul></li>
				<li class="nav-item"><a
					class="nav-link text-center  fs-5 " href="${path}/calendar">Calendar</a></li>
				<li class="nav-item"><a class="nav-link fs-5"
					href="${path}/news"> News</a></li>
				<li class="nav-item"><a
					class="nav-link text-center  fs-5 " href="${path}/notice">Notice</a></li>
				<li class="nav-item"><a
					class="nav-link text-center fs-5 " href="${path}/board">Board</a></li>
			</ul>
			<form class="d-flex">
			<a class="btn btn-sm btn-outline-light me-1 mx-1" roll="button"
						href="${path}/loginForm">로그인</a> <a
						class="btn btn-sm btn-outline-light  mx-1" role="button"
						href="${path}/joinForm">회원가입</a>
			</form>
		</div>
	</div>
</nav>
<style>
	#weDrone{
	font-family: 'Russo One', sans-serif;
	font-size: 31px;
	padding-top: 3.7px;
	padding-bottom: 3.7px;
	}

	#navbarSupportedContent ul li a:hover{
	color: #ffffff;
 	 transition: .1s;
  	-webkit-transition: .1s;
  	-moz-transition: .1s;
	}
</style>
<%@ include file="../common/footer.jsp"%>