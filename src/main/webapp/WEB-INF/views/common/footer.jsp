<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <div class="toast align-items-center fade" role="alert"  id='alert-toast' aria-live="assertive" aria-atomic="true" style="color: white;background: #dc5151; position: absolute;
    top: 78px;right: 0px;">
  <div class="d-flex">
    <div class="toast-body">
   </div>
    <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
  </div>
</div>   
<%-- <script src="${pageContext.request.contextPath}/resources/js/sockjs.min.js"></script>  --%>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script> 
<script>
//전역변수 선언
var socket = null;
var alarmCount=0;
$(document).ready(function (){
	connectWs();	 
	setTimeout(() => {
		  sock.send("${loginId}");
	}, 300);
	setInterval("autoScript()", 5000);
});

function autoScript() {	
	sock.send("${loginId}");
}
function connectWs(){
	console.log("getContextPath :" +getContextPath());
	// 웹소켓 주소
   // var wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/alarm";
    //var wsUri = "${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/alarm";
	//sock = new SockJS(wsUri);
    sock = new SockJS(getContextPath()+'/alarm');		
	socket = sock;
	sock.onopen = function() {
		console.log('connect onopen');
	};


  
 sock.onmessage = function(evt) {
	 	var data = evt.data;
	   	console.log("ReceivMessage : " + data + "\n");
		const obj =JSON.parse(data);
		
		if($("#alarm-span-count").hasClass("visually-hidden") === false){
			$("#alarm-span-count").addClass("visually-hidden");
		}
		
		//마지막 것만 알림을 위해 카운트 비교
		if(alarmCount!=obj.length){
			//console.log(obj[obj.length-1]);
			var html='<a style="color:#fff; text-decoration: none;"  href="${pageContext.request.contextPath}/alarmLinkMove?type=fbdetail&postId='+obj[obj.length-1].relatedId+'&informid='+obj[obj.length-1].informId+'">' +obj[obj.length-1].informContent  +'</a>';
			$("#alert-toast .toast-body").html(html);
			$("#alert-toast").addClass("show");
			$("#alert-toast .d-flex").css("display", "block")
			;						
			setTimeout(() => {
				$("#alert-toast").removeClass("show");
				$("#alert-toast .d-flex").css("display", "none");
			}, 5000);
		}
		
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
			
			/* 
			for(var key in obj){
				console.log(key);
				console.log(obj[key].informField);
			} */			
		}
		 
 };

 
 sock.onclose = function() {
   	console.log('connect close');   
 };

 sock.onerror = function (err) {console.log('Errors : ' , err);};

}

function alarmListMove(){
	location.href="${pageContext.request.contextPath}/alarmAllRead";
}

function getContextPath() {
    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
}; 



</script>


