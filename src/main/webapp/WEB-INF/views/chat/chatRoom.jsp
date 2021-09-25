<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>WeDrone - Chatting</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/chatPopUp.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
   href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500&display=swap"
   rel="stylesheet">
<style>

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
	
	#weDrone{
		color: white;
		display: inline-block;
		margin-left: auto;
		font-family: 'Do Hyeon', sans-serif;
	}
	
	#shallWeBegin{
		color: greenyellow;
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
	
	

</style>
</head>
<body>
	<div id='stars'></div>
	<div id='stars2'></div>
	<div id='stars3'></div>
		<div id="backgroundDiv">
		<form>
				<div class="backgroundDiv_1">
					<h2 id="weDrone">WeDrone</h2>
						<input type="button" value="나가기" id="imOut" onclick="disConn()"/>
				</div>
				<div class="monitor" id="monitor">
					<span class='text' id="shallWeBegin"></span>
				</div>
				<div id="hiddenForm">
					말하기 : <input type="text" id="msg"/>
					<input type="button" value="전송" id="iSend" onclick="sendMsg()"/>
				</div>
			</form>
		</div>
</body>
<script>


const content = "채팅을 시작하시겠습니까?";
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
setInterval(typing, 200)


//var url = "ws://localhost:8080/web/chat/";
var webSocket = null;
var $mon = $("#monitor");

   var url = "ws://localhost:8080/go/chat/"+"${sessionScope.loginId}";
   //var url = "ws://localhost:8090/go/chat/"+"${sessionScope.loginId}";
   console.log(url);
   webSocket = new WebSocket(url);
   
   //웹소켓이 연결되었을 때
   webSocket.onopen = function(e){
      console.log("connect : ",e);
   }
   
   //웹소켓이 끊겼을 때
   webSocket.onclose = function(e){
      console.log("close : ",e);
      $mon.append("<span id='outMsg'>대화방에서 나왔습니다.</span>");
   }   
   
   //메시지를 서버로 부터 받았을 때
   webSocket.onmessage = function(e){
      console.log("message : ",e);
      $mon.append(e.data+"<br/>");
   }         
   
   
	//메시지를 보내기
	function sendMsg(){
	   webSocket.send("> "+$("#msg").val());
	   $("#msg").val("");
	   $("#shallWeBegin").hide();
	}
	
	//웹소켓 종료
	function disConn(){
		$("#shallWeBegin").hide();
	   webSocket.close();
	}


</script>
</html>