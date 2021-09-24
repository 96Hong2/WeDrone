<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/chatPopUp.css">
<style>
	#monitor{
		margin: 5px;
		width: 85%;
		height: 500px;
		overflow: auto;
		border: 1px solid white;
		padding: 5px;
	}
	
	#hiddenForm{
		display: none;
	}
	
	#weDrone{
		color: white;
	}
	
	#shallWeBegin{
		color: white;
	}
	

</style>
</head>
<body>
	<div id='stars'></div>
	<div id='stars2'></div>
	<div id='stars3'></div>
		<form>
				<div class="backgroundDiv">
					<h3 id="weDrone">WeDrone</h3>
					<div id="monitor">
						<span class='text' id="shallWeBegin"></span>
					</div>
					<input type="button" id="login" value="시작"/>
					<div id="hiddenForm">
						메시지 : <input type="text" id="msg"/>
						<input type="button" value="전송" onclick="sendMsg()"/>
						<input type="button" value="나가기" onclick="disConn()"/>
					</div>
				</div>
			</form>
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


$("#login").click(function(){
	$("#hiddenForm").show();
	$("#login").hide();
	$(".text").hide();
   var url = "ws://localhost:8080/go/chat/"+"${sessionScope.loginId}";
   console.log(url);
   webSocket = new WebSocket(url);
   
   //웹소켓이 연결되었을 때
   webSocket.onopen = function(e){
      console.log("connect : ",e);
   }
   
   //웹소켓이 끊겼을 때
   webSocket.onclose = function(e){
      console.log("close : ",e);
      $mon.append("대화방에서 나왔습니다.<br/>");
   }   
   
   //메시지를 서버로 부터 받았을 때
   webSocket.onmessage = function(e){
      console.log("message : ",e);
      $mon.append(e.data+"<br/>");
   }         
   
});
   
	//메시지를 보내기
	function sendMsg(){
	   webSocket.send($("#msg").val());
	   $("#msg").val("");
	}
	
	//웹소켓 종료
	function disConn(){
	   webSocket.close();
	}


</script>
</html>