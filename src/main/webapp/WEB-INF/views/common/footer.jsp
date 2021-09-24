<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 <div class="toast align-items-center fade" role="alert"  id='alert-toast' aria-live="assertive" aria-atomic="true" style="color: white;background: #dc5151; position: absolute;
    top: 78px;right: 0px;">
  <div class="d-flex">
    <div class="toast-body">
   </div>
    <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
  </div>
</div>   

 <div class="toast align-items-center" role="alert"  id='alert-drone-toast' aria-live="assertive" aria-atomic="true" 
 	style="color: white;background: #fff; position: absolute;
    top: 78px; left:40%;  width: 200px; ">
    
  <div class="d-flex text-center">
    <div class="toast-body">
     <h1 style="color:#000;">긴급 알림</h1>
     <p style="color:#000;"><i class="fa fa-exclamation-triangle" style="color: #ffc107; font-size: 32px"></i>  KP:<span id="drone-kp"></span></p>
     <p style="font-size: 15px; color: red; font-weight: normal; text-align: left;" class="text-left">"오늘은 드론을 날리기 위험한<br>날입니다."</p>
     <p>
  	  <button type="button"  id="drone-alert-btn"  >확인</button>
     </p>
   </div>

  </div>
</div> 

<%-- <script src="${pageContext.request.contextPath}/resources/js/sockjs.min.js"></script>  --%>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script> 

<script>
function getDronIntervalTime() {

    var today = new Date();   
    var hours = ('0' + today.getHours()).slice(-2); 
    var minutes = ('0' + today.getMinutes()).slice(-2);
    var seconds = ('0' + today.getSeconds()).slice(-2); 
    var timeString = hours + ':' + minutes  + ':' + seconds
    //console.log(timeString);
	return minutes;
}///1분마다 실행

//소켓 전역변수 선언
var socket = null;
//클라이언트 초기 시간
var droneSystemTime = getDronIntervalTime();

//한번만 메시지 알림을 위해 alarmCount 변수 설정 
var alarmCount=0;
$(document).ready(function(){
	connectWs();	
	
	setTimeout(() => {
		//시작후 0.3초후 알림데이터 가져오기
		  sock.send("${loginId}");
	}, 300);
	
	//5초마다 알림데이터 가져오기
	setInterval("autoScript()", 5000);
	
	
	setTimeout(() => {
		//시작후 0.5초후 KP지수 데이터 가져오기
		sock.send("ALARM-SPACEWEATHERGETKP");
	}, 500);
	
	setInterval(() => {	
		var hh=getDronIntervalTime();
		//클라이언트 현재 시간이 : hh값 0 과 다를 경우 실행
		if(droneSystemTime != hh){			
			droneSystemTime=hh;
			sock.send("ALARM-SPACEWEATHERGETKP")				
		}				
	}, 1000); //1초 -1000 간격 // 60000 - 1분마다 실행 //60000*60 = 3600000 1시간간격   하면서 클라이언트 시간 변경 감지
			
	
	$("#drone-alert-btn").click(function(){
		$("#alert-drone-toast").hide();
	});
	
	console.log("클라이언트 초기 시간: "+droneSystemTime);
});

function autoScript() {	
	sock.send("${loginId}");
}
function connectWs(){
	//console.log("getContextPath :" +getContextPath());
	// 웹소켓 주소
   // var wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/alarm";
    //var wsUri = "${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/alarm";
	//sock = new SockJS(wsUri);
    sock = new SockJS(getContextPath()+'/alarm');		
	socket = sock;
	sock.onopen = function() {
		//console.log('connect onopen');
	};


  
 sock.onmessage = function(evt) {
	 	var data = evt.data;
	    //console.log("ReceivMessage : " + data + "\n");
		if(data!="null"){
		    const obj =JSON.parse(data);
			//변환할 문자열이 유효한 json이 아닐수 있으므로 객체 생성
		    
			//멀티 알림일 경우
			//multiAlarmData(obj);
			
			
			if(obj.messageType=="weather"){				
				console.log("오늘은 드론을 날리기 위험한 날입니다.");
				//$("#drone-kk").text(obj.kk);
				$("#drone-kp").text(obj.kp);
				$("#alert-drone-toast").show();
			
			}else{
				//알림 마지막 데이터만
				alarmData(obj);				
			}
			
	    }else{
	    	$("#alarm-span").hide();	
	    }
 };

 
 sock.onclose = function() {
   //	console.log('connect close');   
 };

sock.onerror = function (err) {console.log('Errors : ' , err);};
}

//알림에 링크 주는 기능
function alarmListMove(){
	location.href="${pageContext.request.contextPath}/alarmAllRead";
}

//contextpath 구하기
function getContextPath() {
    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
}; 

//멀티 알림일 경우
function multiAlarmData(obj){
	//마지막 것만 알림을 위해 카운트 비교
	if(alarmCount!=obj.length){
		//console.log(obj[obj.length-1]);
		var html='<a style="color:#fff; text-decoration: none;"  href="${pageContext.request.contextPath}/alarmLinkMove?type=fbdetail&postId='+obj[obj.length-1].relatedId+'&informid='+obj[obj.length-1].informId+'">' +obj[obj.length-1].informContent  +'</a>';
		$("#alert-toast .toast-body").html(html);
		$("#alert-toast").addClass("show");
		$("#alert-toast .d-flex").css("display", "block");						
		setTimeout(() => {
			$("#alert-toast").removeClass("show");
			$("#alert-toast .d-flex").css("display", "none");
		}, 5000);
	}
	
	//alarmCount 에 값이 일치하게 만든다.
	alarmCount=obj.length;
	
	//console.dir(obj);
	if(obj.length>0){
		$("#alarm-span").show();
		if(obj.length>1){
			$("#alarm-span-count").text(obj.length);
			if($("#alarm-span-count").hasClass("visually-hidden") === true){
				$("#alarm-span-count").removeClass("visually-hidden");
			}
		}			
	}
}


function alarmData(obj){
	//알람 보이기
	if(parseInt(obj.countInform)>0){
		$("#alarm-span-count").text(obj.countInform);
		$("#alarm-span").show();
		 
		
		//토스트 메시지 보이기
		if(alarmCount!=obj.countInform){
			var html='<a style="color:#fff; text-decoration: none;"  href="${pageContext.request.contextPath}/alarmLinkMove?type=fbdetail&postId='+obj.relatedId+'&informid='+obj.informId+'">' +obj.informContent  +'</a>';
			$("#alert-toast .toast-body").html(html);
			$("#alert-toast").addClass("show");
			$("#alert-toast .d-flex").css("display", "block");						
			
			
			setTimeout(() => {
				$("#alert-toast").removeClass("show");
				$("#alert-toast .d-flex").css("display", "none");
			}, 5000);
		}
		
		//한번만 메시지 알림 = 알림 있다
		alarmCount=obj.countInform;
		
	}else{
		$("#alarm-span").hide();	
	}
	
}







</script>

