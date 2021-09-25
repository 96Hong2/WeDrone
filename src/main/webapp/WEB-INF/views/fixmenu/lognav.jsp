<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark"
	style="back-groundcolor: #3c3c3c;">
	<div class="container-fluid">
		<a class="fs-3 text-center navbar-brand fw-bold text-color: #003399;"
			href="${path}/"> <img src="resources/img/LOGO.png"
			class="rounded float-eand rounded mx-auto d-block mx-2" alt=""
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
			
			<button type="button" onclick="javascript:openMsgBox()" class="btn btn-sm btn-#3c3c3c; position-relative" style="display:inline;">
			<i class="bi bi-envelope" style="font-size: 1.8rem; color: white"></i><span
				class="position-absoluteposition-absolute top-0 end-0 translate-middle badge border border-light rounded-circle bg-danger p-2"><span
				class="visually-hidden">unread messages</span></span>
			</button>

			<button type="button" onclick="alarmListMove()"
				class="btn btn-sm btn-#3c3c3c; position-relative">
				<i class="bi bi-bell-fill" style="font-size: 1.8rem; color: white"></i><span id="alarm-span"
					class="position-absoluteposition-absolute top-0 end-0 translate-middle badge border border-light rounded-circle bg-danger p-2"><span
					class="" id="alarm-span-count"></span></span>
			</button>

			<form class="d-flex">
				 <a
					class="btn btn-sm btn-outline-light  mx-1" role="button"
					href="${path}/memberInfo">마이페이지</a>

				<button class="btn btn-sm btn-outline-light mx-1 " type="button"
					data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
					aria-controls="offcanvasRight" onclick="openMsgBox()">메시지</button>
					
					<a class="btn btn-sm btn-outline-light me-1 mx-1" role="button"
					href="${path}/logout"> 로그아웃</a>
			</form>
		</div>
	</div>
</nav>
<%@ include file="../common/footer.jsp"%>

<style>
#msgBoxTitle{
	display : flex;
	justify-content: space-between;
}

.msgBox{
	position : absolute;
	background-color: pink;
	padding : 15px;
	width : 400px;
	top:13%;
	right:1%;
	z-index: 3;
}

#reqChatBox{
	background-color:snow;
}

#reqChatBox li{
	list-style: none;
}

#userListBox{
	background-color:aliceblue;
}

#userListBox li{
	list-style: none;
}

#userListBox a{
	color: black;
	text-decoration: none;
}

#userListBox a:hover{
	font-weight : bolder;
}


#userImg{
	width : 20px;
	height : 20px;
	margin-right : 3px;
}

</style>

<div class="msgBox">
	<div id="msgBoxTitle">
		<h4><b>WeDrone 1:1채팅</b></h4>
		<a href="javascript:closeMsgBox()" style="text-decoration:none; color:black; margin-right:10px;"><h4><b>X</b></h4></a>
	</div>
	<hr/>
	<div id="reqChatBox">
		<h5><b>내가 받은 대화요청</b></h5>
		<p>대화를 수락할 유저를 클릭하세요</p>
		<ul id="reqList">
			<li><div>드론곤볼 광주시</div></li>
			<li><div>드로니 광주시</div></li>
		</ul>
	</div>
	<div id="userListBox">
		<h5><b>접속한 유저 리스트</b></h5>
		<p>대화를 요청할 유저를 클릭하세요</p>
		<ul id="userList">
		
		</ul>
	</div>
</div>

<script>

//현재 접속한 유저 리스트 불러오기
getUserList();

$('.msgBox').hide();

function openMsgBox(){
	$('.msgBox').show(800);
}

function closeMsgBox(){
	$('.msgBox').hide();
}

//채팅창 팝업 열기
function openMsg(user){
	console.log("대화상대 : ",user);
	//대화상대 user를 파라미터로 넘겨주기
	
    var url = "./chatRoom?other="+user;
	//var url = "./message?other="+user;
    var title = "popup";
    var status = "toolbar=no,resizable=no, channelmode=yes, location=no,status=no,menubar=no,width=680, height=660, top=0,left=70%"; 
                                   
    window.open(url,title,status);
}


function getUserList(){
	$.ajax({
	     url:'callMyLocMK', //서버의 모든 내위치마커 불러오기
	     type:'post',
	     dataType:'json',
	     success:function(data){
	    	console.log("메시지 유저리스트 가져오기 : ", data.list);
	    	
	    	var list = data.list;
	    	var content = "";
	    	
	    	list.forEach(function(user, index){
	    		if(user.userId != "{sessionScope.loginId}"){
	    		
	    		content += "<li><a href='javascript:openMsg(\""+user.nickName+"\")'><div>"
		    	content += "<img src='resources/img/comment.png' id='userImg'>"+user.nickName+" 님 &nbsp;";
		    	
		    	//내위치마커 주소
		    	//address = address.substring(0, address.indexOf("시")+1); //시작인덱스, 끝인덱스
		    	content += "<span style='font-size:15px; color:darkgray;'>"+user.address+"</span></div></a></li>";
	    		}
	    	})
	    	
		    $("#userList").empty();
		    $("#userList").append(content);	    		
	    	
	     },
	     error:function(e){
	         console.log("에러 e : ",e);
	     }
	 });
}
</script>