<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style>

#weDrone{
	font-family: 'Russo One', sans-serif;
	font-size: 31px;
	padding-top: 3.7px;
	padding-bottom: 3.7px;
}

#msgBoxTitle{
	display : flex;
	justify-content: space-between;
}

.msgBox{
	position : absolute;
	background-color: snow;
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
	/* background-color:white; */
}

#reqChatBox li{
	list-style: none;
}

#userListBox{
	/* background-color:white; */
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

#reqChatBox a{
	color: black;
	text-decoration: none;
}

#reqChatBox a:hover{
	font-weight : bolder;
}

#userImg{
	width : 20px;
	height : 20px;
	margin-right : 3px;
}

#alertToast{
	position : absolute;
	top:13%;
	left:1%;
	z-index: 4;
}

#myToast a{
	text-decoration : none;
	color : black;
}

#myToast a:hover{
	font-weight : bolder;
}

#navbarSupportedContent ul li a:hover{
	color: #ffffff;
 	 transition: .1s;
  	-webkit-transition: .1s;
  	-moz-transition: .1s;
}


</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap" rel="stylesheet">
<!--  -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark"
	style="back-groundcolor: #3c3c3c;">
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
			
			<button type="button" onclick="javascript:openMsgBox()" class="btn btn-sm btn-#3c3c3c; position-relative" style="display:inline;">
			<i class="bi bi-envelope" style="font-size: 1.8rem; color: white"></i><span id="redCircle" class="position-absoluteposition-absolute top-0 end-0 translate-middle badge border border-light rounded-circle bg-danger p-2">
			<span class="visually-hidden">unread messages</span></span>
			</button>

			<button type="button" onclick="alarmListMove()"
				class="btn btn-sm btn-#3c3c3c; position-relative">
				<i class="bi bi-bell-fill" style="font-size: 1.8rem; color: white"></i><span id="alarm-span" style="display: none;"
					class="position-absoluteposition-absolute top-0 end-0 translate-middle badge border border-light rounded-circle bg-danger p-2"><span
					class="" id="alarm-span-count"></span></span>
			</button>

			<form class="d-flex">
				 <a
					class="btn btn-sm btn-outline-light  mx-1" role="button"
					href="${path}/memberInfo">마이페이지</a>
					
					<a class="btn btn-sm btn-outline-light me-1 mx-1" role="button"
					href="${path}/logout"> 로그아웃</a>
			</form>
		</div>
	</div>
</nav>
<%-- <%@ include file="../common/footer.jsp"%> --%>



<div class="msgBox">
	<div id="msgBoxTitle">
		<h4><img src='resources/img/chat-box.png' width='30px' height='30px'>&nbsp;<b>WeDrone 1:1 채팅</b></h4>
		<a href="javascript:closeMsgBox()" style="text-decoration:none; color:black; margin-right:10px;"><h4><b>X</b></h4></a>
	</div>
	<hr/>
	<div id="reqChatBox">
		<h5><b>내가 받은 대화요청</b></h5>
		<p>대화를 수락할 유저를 클릭하세요</p>
		<ul id="reqList">
			<li id="emptyReqCmt">받은 대화요청이 없습니다.</li>
		</ul>
	</div>
	<hr/>
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
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script>

//웹소켓 전역변수 mySocket 선언
var mySocket = null;

$(document).ready(function(){
	//알림을 받기 위한 웹소켓 연결(/chat-ws는 servlet-context.xml에 있다)
	mySock = new SockJS("<c:url value="/chat-ws"/>");
	mySocket = mySock;
	//알림 데이터를 전달받았을 때 실행되는 함수로 onMessage함수를 연결(toast를 생성하는 함수)
	mySock.onmessage = onMessage;
	
	//알림을 보내기 위한 웹소켓 연결(/chatRoom-ws는 servlet-context.xml에 있다)
	chatSock = new SockJS("<c:url value="/chatRoom-ws"/>");
	chatSocket = chatSock;
	//chatSock.onmessage = onChatMessage; //웹소켓에서 알림을 받지는 않기 때문에 주석처리
	
	//메시지박스에 현재 접속한 유저 리스트 불러오기
	getUserList();
	
	//메시지박스에 현재 나에게 대화요청한 유저 리스트 불러오기
	getReqList();
	
	//메시지박스 숨기기(버튼을 클릭하면 보이게 하기 위함)
	$('.msgBox').hide();
	
	//헤더의 메시지아이콘에 빨간 동그라미 숨기기
	$('#redCircle').hide();
});

//알림 toast를 생성하고 띄워주는 함수(부트스트랩 사용)
function onMessage(e){
	var data = e.data; //웹소켓으로부터 받은 알림 데이터
	console.log("onMessage e.data : ",e.data);
	
	//채팅요청과 일반알림을 구분하기위해 e.data의 맨 앞에 특수기호를 찍어서 구분했다.
	//**이면 채팅요청, ##이면 채팅거절알림, 아니면 일반알림(일반알림은 채팅뿐아니라 좋아요, 즐겨찾기, 댓글 등에서도 쓰이기 때문에 형식을 변경할 수 없음)
	if(data.substring(0,2) == "**"){ //채팅요청
	    data = data.substr(2);
		console.log("자른 data : ", data);
		var splitStr = data.split("/");
		var reqId = splitStr[0];
		var reqNickName = splitStr[1];
		console.log("reqId/reqNickName : "+reqId+"/"+reqNickName);
		
		var chatReq = "<li id='req_"+reqNickName+"_li'><a href='javascript:acceptReq(\""+reqId+"\",\""+reqNickName+"\")'><div>";
		chatReq += "<img src='resources/img/comment.png' id='userImg'> &nbsp;";
		chatReq += "[<b>대화요청</b>] &nbsp;"+reqNickName+" 님 ";
		
		var now = new Date();
		//var nowHour = (now.getHours() > 12 ? "오후 "+(parseInt(now.getHours)-12)+"시" : "오전 "+now.getHours+"시"); 
		var reqTime = now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
		
		chatReq += "<span style='font-size:15px; color:darkgray;'>"+reqTime+"</span></a>";
		chatReq += "<button id='rejectChatBtn' class='btn btn-sm btn-outline-dark mx-1 me-1' type='button' onclick='javascript:rejectChat(\""+reqId+"\",\""+reqNickName+"\")'>거절</button></div></li>";
		$("#emptyReqCmt").empty();
		$("#reqList").append(chatReq);	
	/*
	}else if(data.substring(0,2) == "##"){
		//##은 채팅 거절알림, 채팅거절 알림메시지일 경우 여기서 해줄 일은 없다.
		
	*/
	}else{ //일반알림
		var toast = "<div id='myToast' class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
	    toast += "<div class='toast-header'><i class='bi bi-bell-fill' style='font-size: 0.9rem; color : orange'></i><strong class='mr-auto'> &nbsp;알림 &nbsp;</strong>";
	    toast += "<p class='text-muted' style='font-size:14px;'> just now&nbsp;</p><a href='javascript:toastClose()'><strong>X</strong></a>";
	    toast += "</div> <div class='toast-body'>" + data + "</div></div>"
	    
	    $("#alertToast").empty();
	    $("#alertToast").append(toast); //alertToast div에 생성한 토스트 추가
	    //$('.toast').toast({"animation": true, "autohide": false});
	    //$('.toast').toast('show');
	    $('#myToast').fadeIn(400).delay(5000).fadeOut(400);
	    
	    //헤더의 메시지아이콘에 빨간 동그라미 보이기
	    $('#redCircle').show();
	}
}

function toastClose(){
	$('#myToast').hide();
}

function openMsgBox(){
	$('#redCircle').hide();
	$('.msgBox').show(800);
}

function closeMsgBox(){
	$('.msgBox').hide();
}

function rejectChat(userId, userNickName){
	var rejectorId = "${sessionScope.loginId}";
	var rejectorNickName = "${sessionScope.loginNickName}";
	if(confirm(userNickName+"님의 대화요청을 거절하시겠습니까?") == true){
		$("#req_"+userNickName+"_li").empty();
		
		//대화요청을 거절했을 때 거절당한 유저에게 보내는 채팅방 알림 웹소켓
		chatSock.send("chatReject,"+userId+","+rejectorNickName+",#");
		
		deleteReq(userNickName);
	}else{
		return;
	}
}

//대화를 요청하는 함수 (요청 받을 사람 아이디, 닉네임)
function sendReq(user, nickName){
	if(confirm(nickName+"님께 1:1채팅을 요청하시겠습니까?") == true){	
		var requestor = "${sessionScope.loginId}"; //대화를 요청하는 유저(나)
		var reqNickName = "${sessionScope.loginNickName}";
		var url = "./chatRoom?other="+user;
		console.log("요청자/대화상대 : "+requestor+" / "+user);
		console.log("요청자/대화상대 : "+reqNickName+" / "+nickName);
	
		//대화를 요청받은 유저에게 알림 전송
		//send의 인자는 알림 데이터로 "타입, 타겟(알림을 받을 유저아이디), 내용, 알림 클릭 시 이동할 URL"의 형식을 가진다.(,로 구분)
		mySocket.send("채팅 알림,"+user+","+reqNickName+"님이 1:1 채팅을 요청했습니다,"+"#");
		//타입을 chat으로 주면 해당 유저의 msgBox에 채팅요청이 간다.
		mySocket.send("chat,"+user+","+requestor+"/"+reqNickName+","+url);
		
		//DB에 대화요청 저장(요청자, 받는사람)
		//30분 뒤 대화요청 제거됨(SchedulerService)
		insertReq(requestor, user);
		
		//채팅방 팝업창 열어주기
		openChat(user);
	}else{
		return;
	}
}

//대화요청을 수락했을 때 실행되는 함수
function acceptReq(requestorId, requestorNickName){
	$("#req_"+requestorNickName+"_li").empty();
	deleteReq(requestorNickName);
	
	//채팅방 팝업창 열어주기
	openChat(requestorId);
}

//채팅방 팝업창을 열어주는 함수
function openChat(user){
	//대화상대 user를 URL을 통해 팝업창에 파라미터로 넘겨준다.
    var url = "./chatRoom?other="+user;
    var title = "popup";
    var status = "toolbar=no,resizable=no, channelmode=yes, location=no,status=no,menubar=no,width=680, height=660, top=0,left=70%"; 
                  
    window.open(url,title,status);
}


function insertReq(requestor, user){
	$.ajax({
	     url:'insertReq', //DB에 대화요청 알림 INSERT
	     type:'get',
	     data:{
	    	 "userId" : requestor,
	    	 "reqUserId" : user
	     },
	     dataType:'json',
	     success:function(data){
	    	console.log("DB에 대화요청알림 insert : ", data.success);
	     },
	     error:function(e){
	         console.log("에러 e : ",e);
	     }
	 });
}

function deleteReq(user){
	var loginUser = "${sessionScope.loginId}";
	console.log("deleteReq loginUser : ",loginUser);
	$.ajax({
	     url:'deleteReq', //DB에서 대화요청 알림 DELETE
	     type:'get',
	     data:{
	    	 "userId" : loginUser,
	    	 "reqUserId" : user
	     },
	     dataType:'json',
	     success:function(data){
	    	console.log(loginUser+" DB에서 대화요청 delete : ", data.success);
	     },
	     error:function(e){
	         console.log("에러 e : ",e);
	     }
	 });
}

//메시지박스에 현재 접속한(내위치마커ON) 유저 리스트를 불러오는 함수.
function getUserList(){
	$.ajax({
	     url:'callMyLocMK', //서버의 모든 내위치마커 불러오기
	     type:'post',
	     dataType:'json',
	     success:function(data){
	    	console.log("실시간마커 유저리스트 가져오기 : ", data.list);
	    	
	    	var list = data.list;
	    	var content = "";
	    	
	    	list.forEach(function(user, index){
	    		if(user.userId != "{sessionScope.loginId}"){
	    		
	    		content += "<li><a href='javascript:sendReq(\""+user.userId+"\",\""+user.nickName+"\")'><div>"
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

//메시지박스에 대화를 요청한 유저 리스트를 불러오는 함수
function getReqList(){
	$.ajax({
	     url:'getReqList', //DB알림 중 message로 된 이 유저의 알림 다 가져오기
	     type:'post',
	     dataType:'json',
	     success:function(data){
	    	console.log("대화요청 리스트 가져오기 : ", data.list);
	    	
	    	var list = data.list;
	    	var content = "";
	    	
	    	/*헤더 메시지아이콘에 빨간동그라미
	    	if(list != null){
	    		$('#redCircle').show();
	    	}
	    	*/
	    	
	    	list.forEach(function(user, index){
	    		//아이디(regUserId), 닉네임(informContent) 모두 가져와야 함!!
		    	content = "<li id='req_"+user.informContent+"_li'><a href='javascript:acceptReq(\""+user.regUserId+"\",\""+user.informContent+"\")'><div>";
		    	content += "<img src='resources/img/comment.png' id='userImg'> &nbsp;";
		    	content += "[<b>대화요청</b>] &nbsp;"+user.informContent+" 님 ";
		    	content += "<span style='font-size:15px; color:darkgray;'>"+user.msgDate+"</span></a>";
		    	content += "<button id='rejectChatBtn' class='btn btn-sm btn-outline-dark mx-1 me-1' type='button' onclick='javascript:rejectChat(\""+user.regUserId+"\",\""+user.informContent+"\")'>거절</button></div></li>";
	    	})
	    	
		    $("#reqList").empty();
		    $("#reqList").append(content);
	    	
	     },
	     error:function(e){
	         console.log("에러 e : ",e);
	     }
	 });
}
</script>