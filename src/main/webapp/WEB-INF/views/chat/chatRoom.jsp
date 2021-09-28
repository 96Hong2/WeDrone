<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>WeDrone</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/chatPopUp.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">

   <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap" rel="stylesheet">
<link rel = "icon" href = "resources/img/dron1.ico">
<style>

	@font-face {
	    font-family: 'Cafe24SsurroundAir';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/Cafe24SsurroundAir.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	

	body, html {
	   font-family: 'IBM Plex Sans KR', sans-serif;
	}
	#monitor{
		margin: auto;
		width: 85%;
		height: 500px;
		overflow: auto;
		border: 1px solid white;
		padding: 5px;
	}
	
	.monitor{
		color: white;
	}
	
			/* 스크롤바 설정*/
	.monitor::-webkit-scrollbar{
	    width: 6px;
	}
	
	/* 스크롤바 막대 설정*/
	.monitor::-webkit-scrollbar-thumb{
	    height: 17%;
	    background-color: rgba(33,133,133,1);
	    border-radius: 10px;  
	}
	
	/* 스크롤바 뒷 배경 설정*/
	.monitor::-webkit-scrollbar-track{
	    background-color: rgba(33,133,133,0.33);
	}
	
	#weDrone{
		color: white;
		display: inline-block;
		margin-left: auto;
		font-family: 'Russo One', sans-serif;
	}
	
	#shallWeBegin{
		font-family: 'Cafe24SsurroundAir';
		color: darkcyan;
		margin: auto;
	}
	
	#msg{
		width:  77%;
		background-color: transparent;
		border: 1px solid white;
		margin-left: 5px;
		height: 28px;
		color: white;
	}
	
	#imOut{
		display:inline-block;
		float: right;
		margin-bottom: auto;
		background-color: transparent;
		color: orangered;
		margin-top: 5%;
		border: none;
	}
	
	#iSend{
		margin-top: 5px;
		display: inline-block;
		margin-left: 5px;
		background-color: transparent;
		color: white;
		border: none;
		/* border: 1px solid white; */
		width: 8.4%;
		height: 32px;
		font-size: 14px;
	}
	
	#iSend:hover{
		color: greenyellow;
		font-weight: bold;
	}
	
	#hiddenForm{
		width: 85%;
		color: white;
		margin: auto;
		font-size: 16px;
	}
	
	#backgroundDiv{
		margin: auto;
	}
	
	.backgroundDiv_1{
		margin: auto;
		width: 85%;
		height: 57px;
	}
	
	#outMsg{
		font-size: 12px;
		color: orangered;
	}
	
	#alert{
		font-size: 12px;
		color: greenyellow;
	}
	
	#RejectAlert{
		position : absolute;
		top:36%;
		left:28%;
		padding : 15px;
		z-index: 4;
		background-color : white;
	}

	#topAlert{
		display : flex;
		justify-content: space-between;
	}
	
	#closeToast{
		text-decoration : none;
		color : black;
	}
	
	#chatboxImg{
		width : 20px;
		height : 20px;
	}
	
	#rejectImg{
		width : 60px;
		height : 60px;
	}
	
	#rejectImgDiv{
		text-align: center;
	}
	
</style>
</head>
<body>
	<div id="RejectAlert"></div>
	<div id='stars'></div>
	<div id='stars2'></div>
	<div id='stars3'></div>
		<div id="backgroundDiv">
		<!-- <form onsubmit="return false;">-->				
			<div class="backgroundDiv_1">
					<h2 id="weDrone">WeDrone</h2>
						<button type='button' id="imOut" onclick='disConn()'>나가기</button>
				</div>
				<div class="monitor" id="monitor">
					<span class='text' id="shallWeBegin"></span><br/>
				</div>
				<div id="hiddenForm">
					말하기 : <input type="text" id="msg" autocomplete="off"/>
					<input type="button" value="전송" id="iSend" onclick="sendMsg()"/>
				</div>
			<!-- </form> -->
		</div>
</body>
<!-- sockJS CDN -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
//전체 프로젝트 페이지에서 사용하는 웹소켓 전역변수
var mySocket = null;
$(document).ready(function(){
	$("#RejectAlert").hide();
	
	//알림을 받기 위한 웹소켓 연결(/chat-ws는 servlet-context.xml에 있다)
	mySock = new SockJS("<c:url value="/chat-ws"/>");
	mySocket = mySock;

	//알림 데이터를 전달받았을 때 실행되는 함수로 onMessage함수를 연결(toast를 생성하는 함수)
	mySock.onmessage = onMsg;
});

//웹소켓으로 메시지를 받아 거절알림을 띄워주는 함수
function onMsg(e){
	var rejector = e.data; //웹소켓으로부터 받은 알림 데이터
	console.log("거절한 유저닉네임 onMessage : ",rejector);
	
	//채팅요청과 일반알림을 구분하기위해 e.data의 맨 앞에 특수기호를 찍어서 구분했다.
	//**이면 채팅요청, ##이면 채팅거절알림, 아니면 일반알림(일반알림은 채팅뿐아니라 좋아요, 즐겨찾기, 댓글 등에서도 쓰이기 때문에 형식을 변경할 수 없음)
	if(rejector.substring(0,2) == "##"){ //채팅 거절요청
		rejector = rejector.substr(2);
		console.log("자른 data : ", rejector);
		
	    var content = "<div id='myAlert'>";
		content += "<div id='topAlert'><strong class='mr-auto'><img src='resources/img/chat-box.png' id='chatboxImg'>&nbsp;알림 &nbsp;</strong>";
		content += "<a href='javascript:toastClose()' id='closeToast'><strong>X</strong></a></div>";
		content += "<hr/>";
		content += "<div id='rejectImgDiv'><img src='resources/img/rejected.png' id='rejectImg'></div>";
		content += "<div style='text-align:center;'>" + rejector + "님이 1:1채팅요청을 거절했습니다.</div></div>"
	    
	    $("#RejectAlert").empty();
	    $("#RejectAlert").append(content);
	    $("#RejectAlert").show();
	    //채팅 웹소켓 닫아주기
	    webSocket.close();
	}else{
		//다른 웹소켓 메시지일 경우 무시한다.
		return;
	}
}

function toastClose(){
	$('#RejectAlert').hide();
}
	
const content = "바른 말 고운 말을 사용합시다 !    ";
const text = document.querySelector(".text");
let i = 0;

function typing(){
    let txt = content[i++];
    text.innerHTML += txt=== "\n" ? "<br/>": txt;
    if (i > content.length) {
        text.textContent = "";
        i = 0;
    }
}
setInterval(typing, 300)


//var url = "ws://localhost:8080/web/chat/";
var webSocket = null;
var $mon = $("#monitor");

   //var url = "ws://localhost:8090/go/chat/"+"${sessionScope.loginNickName}";
   //var url = "wss://14de-1-243-186-47.ngrok.io/go/chat/"+"${sessionScope.loginNickName}";
   var url = "ws://localhost:8080/go/chat/"+"${sessionScope.loginNickName}";
   //console.log(url);
   webSocket = new WebSocket(url);
   
   //웹소켓이 연결되었을 때
   webSocket.onopen = function(e){
      //console.log("connect : ",e);
   }
   
   //웹소켓이 끊겼을 때
   webSocket.onclose = function(e){
      //console.log("close : ",e);
      $mon.append("<span id='outMsg'>대화방에서 나왔습니다.</span>");
      $("#monitor").scrollTop($("#monitor")[0].scrollHeight);
   }   
   
   //메시지를 서버로 부터 받았을 때
   webSocket.onmessage = function(e){
      //console.log("message : ",e);
      $mon.append(e.data+"<br/>");
      $("#monitor").scrollTop($("#monitor")[0].scrollHeight);
   }         
   
   
	//메시지를 보내기
	function sendMsg(){
	   webSocket.send("${sessionScope.loginNickName} : "+$("#msg").val());
	   $("#msg").val("");
	   //$("#shallWeBegin").hide();
	}
	
	//웹소켓 종료
	function disConn(){
		$("#shallWeBegin").hide();
	   webSocket.close();
	}
	
	 $("#msg").on("keyup",function(key){
	        if(key.keyCode==13) {
	        	sendMsg();
	        }
	    });



</script>
</html>