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

.msgBox p{
	font-size : 15px;
	color : darkgray;
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
			<li>받은 대화요청이 없습니다.</li>
		</ul>
	</div>
	<div id="userListBox">
		<h5><b>접속한 유저 리스트</b></h5>
		<p>대화를 요청할 유저를 클릭하세요</p>
		<ul id="userList">
			<li>현재 대화 가능한 유저가 없습니다.</li>
		</ul>
	</div>
</div>

<div id="alertToast"></div>

<!-- sockJS CDN -->
<script>

//웹소켓 전역변수 socket 선언
var socket = null;

$(document).ready(function(){
	//알림을 받기 위한 웹소켓 연결(/chat-ws는 servlet-context.xml에 있다)
	sock = new SockJS("<c:url value="/chat-ws"/>");
	socket = sock;
	
	//알림 데이터를 전달받았을 때 실행되는 함수로 onMessage함수를 연결(toast를 생성하는 함수)
	sock.onmessage = onMessage;
	
	//메시지박스에 현재 접속한 유저 리스트 불러오기
	getUserList();
	
	//메시지박스 숨기기(버튼을 클릭하면 보이게 하기 위함)
	$('.msgBox').hide();
});

//알림 toast를 생성하고 띄워주는 함수(부트스트랩 사용)
function onMessage(e){
	var data = e.data; //웹소켓으로부터 받은 알림 데이터
	
	var toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
    toast += "<div class='toast-header'><i class='fas fa-bell mr-2'></i><strong class='mr-auto'>알림</strong>";
    toast += "<small class='text-muted'>just now</small><button type='button' class='ml-2 mb-1 close' data-dismiss='toast' aria-label='Close'>";
    toast += "<span aria-hidden='true'>&times;</span></button>";
    toast += "</div> <div class='toast-body'>" + data + "</div></div>";
    
    $("#alertToast").append(toast); //alertToast div에 생성한 토스트 추가
    $(".toast").toast({"animation": true, "autohide": false});
    $('.toast').toast('show');
}


function openMsgBox(){
	$('.msgBox').show(800);
}

function closeMsgBox(){
	$('.msgBox').hide();
}

//대화를 요청받은 유저에게 알림 전송 & 채팅창 팝업 열기
function openMsg(user){
	var requestor = "${sessionScope.loginId}";
	console.log("요청자/대화상대 : "+requestor+" / "+user);
	
	//send의 인자는 알림 데이터로 "타입, 타겟(알림을 받을 유저아이디), 내용, 알림 클릭 시 이동할 URL"의 형식을 가진다.(,로 구분)
	socket.send("메시지 알림,"+user+",새로운 메시지 요청이 왔습니다.,"+url);
	
	//대화상대 user를 URL을 통해 팝업창에 파라미터로 넘겨준다.
    var url = "./chatRoom?other="+user;
    var title = "popup";
    var status = "toolbar=no,resizable=no, channelmode=yes, location=no,status=no,menubar=no,width=680, height=660, top=0,left=70%"; 
                                   
    window.open(url,title,status);
}

//메시지박스에 현재 접속한(내위치마커ON) 유저 리스트를 불러오는 함수.
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
	    		
	    		content += "<li><a href='javascript:openMsg(\""+user.userId+"\")'><div>"
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