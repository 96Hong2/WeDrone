<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<nav class="navbar navbar-expand-lg navbar-dark bg-dark"
	style="back-groundcolor: #3c3c3c;">
	<div class="container-fluid">
		<a class="fs-3 text-center navbar-brand fw-bold text-color: #003399;"
			href="${path}/"> <img src="resources/img/LOGO.png"
			class="rounded float-end rounded mx-auto d-block mx-2" alt=""
			width="50" height="50">WeDron
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
					class="nav-link dropdown-toggle active fs-4 "
					data-bs-toggle="dropdown" href="#" role="button"
					aria-expanded="false">Map</a>
					<ul class="dropdown-menu active">
						<li><a class="dropdown-item" href="${path}/warnmap">비행지역 조회</a></li>
						<li><a class="dropdown-item" href="${path}/map">지도 보기</a></li>
					</ul></li>
				<li class="nav-item"><a
					class="nav-link active text-center  fs-4 " href="${path}/calendar">Calendar</a></li>
				<li class="nav-item"><a class="nav-link active fs-4"
					href="${path}/news"> News</a></li>
				<li class="nav-item"><a
					class="nav-link active text-center  fs-4 " href="${path}/notice">Notice</a></li>
				<li class="nav-item"><a
					class="nav-link active text-center fs-4 " href="${path}/board">Board</a></li>
			</ul>

			<i class="bi bi-envelope" style="font-size: 1.8rem; color: white"></i><span
				class="position-absoluteposition-absolute top-0 end-0 translate-middle badge border border-light rounded-circle bg-danger p-2"><span
				class="visually-hidden">unread messages</span></span>


			<button type="button" onclick="alarmListMove()"
				class="btn btn-sm btn-#3c3c3c; position-relative">
				<i class="bi bi-bell-fill" style="font-size: 1.8rem; color: white"></i><span id="alarm-span"
					class="position-absoluteposition-absolute top-0 end-0 translate-middle badge border border-light rounded-circle bg-danger p-2"><span
					class="" id="alarm-span-count"></span></span>
			</button>

			<form class="d-flex">
				<a class="btn btn-sm btn-outline-light me-1 mx-1" role="button"
					href="${path}/logout"> 로그아웃</a> <a
					class="btn btn-sm btn-outline-light  mx-1" role="button"
					href="${path}/memberInfo">마이페이지${sesseionScope.loginNickName}</a>

				<button class="btn btn-sm btn-outline-light mx-1 " type="button"
					data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
					aria-controls="offcanvasRight">메시지</button>
			</form>
		</div>
	</div>
</nav>
