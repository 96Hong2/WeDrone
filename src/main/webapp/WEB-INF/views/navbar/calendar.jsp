<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>드론</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">	
<link href="${path}/resources/css/common.css?var=3" rel="stylesheet">
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
<script type="text/javascript" src="//cdn.jsdelivr.net/jquery/1/jquery.min.js"></script>

<script src="${path}/resources/js/common.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">


<script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap/3/css/bootstrap.css" /> -->
<!-- Include Date Range Picker -->
<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />

<link href='${path}/resources/fullcalendar-5.9.0/lib/main.css' rel='stylesheet' />
<script src='${path}/resources/fullcalendar-5.9.0/lib/moment.min.js'></script>
<script src='${path}/resources/fullcalendar-5.9.0/lib/main.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/locales-all.min.js'></script>
<link href="${path}/resources/css/calendar.css?v=1" rel="stylesheet">

</head>

<body>
	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="../fixmenu/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
	 	<jsp:include page="../fixmenu/lognav.jsp" /> 
	</c:if>

<!-- 들어갈 내용 -->
<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item fs-4"><a href="${path}/">Home</a></li>
    <li class="breadcrumb-item active fs-4" aria-current="page">Map</li>
  </ol>
</nav>

<!-- 날씨 위젯 시작 -->
<div style="position: fixed; bottom: 150px;  right: 0px;width: 100%;">
<div class="position-relative" class="modal hide fade" id="btn-weather"   tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div id="quick" class="position-absolute top-50 end-0 translate-middle-y" style="margin-right:0px;">
		<a href="#weather-layer1"
			class="rounded-pill btn btn-success fw-bold" data-toggle="modal" class="btn" data-target="#myModal"> <i
			class="bi bi-info-circle"></i> 실시간 정보
		</a>
	</div>
</div>
</div>
<%@ include file="../common/weather-widget.jsp" %>

<!--// 날씨 위젯 끝 -->

	<div id='wrap'>
		<!-- calendar 태그 -->
		<div id='calendar-wrap'>
			<h1 style="display:none"><input type="text" id="currentDatePage"></h1>
			<div id='calendar'></div>			
		</div>
	</div>


<script type='text/javascript'>
var g_arg;	//모달창에서 호출하는 함수에서 참조하기 위함)
var calendar;
document.addEventListener('DOMContentLoaded', function() {
	
	
  var calendarEl = document.getElementById('calendar');
  calendar = new FullCalendar.Calendar(calendarEl, {
 	  
	  //이벤트 소스는 구글에서 가져와서 쓰는
	googleCalendarApiKey: 'AIzaSyDqXhIu1nACWbwfRgPhoulB0GLxlb3OW_0',
   //className은 임의로 넣어주는 제목 그래도 캘린더랑 맞춰주면 좋을듯 하다
	eventSources: [
		   		 {
		          googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
		          className: '대한민국의 휴일',
		          color: '#be5683', //rgb,#ffffff 등의 형식으로 할 수 있다
		          //textColor: 'black' 
		        },
		       
		  		 {
		            googleCalendarId: 'du6b9s50h56t8aq0tgnfjhfpl8@group.calendar.google.com',
		            className: '드론일정',
		            color: '#c0ca33', //rgb,#ffffff 등의 형식으로 할 수 있다
		            //textColor: 'black' 
		          },
			  	{
			            googleCalendarId: 'jjuunn613@gmail.com',
			            className: '박지윤',
			            color: '#16bf71', //rgb,#ffffff 등의 형식으로 할 수 있다
			            //textColor: 'black' 
			    },
		          
   
    ],
    
/* 	events: [
		{"resourceId":"a","title":"event 1","start":"2021-07-14","end":"2021-07-16"},
		{"resourceId":"b","title":"event 3","start":"2021-07-15T12:00:00+00:00","end":"2021-07-16T06:00:00+00:00"},
		{"resourceId":"d1","title":"event 4","start":"2021-07-15T07:30:00+00:00","end":"2021-07-15T09:30:00+00:00"},
		 {
	        title: '77777',
            start: '2021-09-15',
            end: '2021-09-30',
             url: "${pageContext.request.contextPath }/detail.do?seq=",
             color:"#f7e600"
	     }
	]
  	, */
  
   
	
  	    customButtons: { 
  	        myCustomButton: { 
  	            text: '일정입력',
  	            click: function(event) { 
  	              onSelectEvent(event); 
  	            } 
  	        } 
  		}, 
    

    headerToolbar: {
		left : 'prev,next today',
		center : 'title',
		right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek,myCustomButton'
	},
	//initialDate : '2021-09-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
	locale : 'ko', // 한국어 설정
	editable : false, // 수정 가능
	droppable : false, // 드래그 가능
	//drop : function(arg) { // 드래그 엔 드롭 성공시
	// 드래그 박스에서 아이템을 삭제한다.
	//	arg.draggedEl.parentNode
	//			.removeChild(arg.draggedEl);
	//},   
	defaultView: 'timeGridWeek',
	navLinks: false, // can click day/week names to navigate views	
	allDaySlot: false,
	eventLimit: true, // allow "more" link when too many events
	//minTime: '10:00:00',
	//maxTime: '24:00:00',
	//contentHeight: 'auto',
    
    
   	dateClick:function(arg) {
   		
   		
  			//해당월  페이지 이동을 위한 날짜가져오기
	  		var getData=this.getCurrentData();
	   		//console.log(getData);
	   		//console.log(getData.currentDate);
	   		var currentDatePage=moment(getData.currentDate).format('YYYY-MM-DD');
	   		$("#currentDatePage").val(currentDatePage);
			insertModalOpen(arg);
     
    	  			
 
    },
    
    
    eventClick: function(info) {
    	event.preventDefault();
   	
	   		
	    	console.dir(info);    	
	    	console.log(info.event.title + '수정 : ' + info.event.id);
	    	
	   		//해당월  페이지 이동을 위한 날짜가져오기
	  		var getData=this.getCurrentData();
	  		//console.log(getData);
	   		//console.log(getData.currentDate);
	   		var currentDatePage=moment(getData.currentDate).format('YYYY-MM-DD');
	   		$("#currentDatePage").val(currentDatePage);
	    	
	    	
	    	var url=info.event.url;
	    	console.log(url);
	    	updateModalOpen(info.event.id, url);
 	
    	    	
      //  alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
       // alert('View: ' + info.view.type);
//eventClick: function (info) { alert(info.event.id); alert(info.event.title); alert(info.event.start.format('DD/MM/YYYY HH:mm:ss')); return false; },

        // change the border color just for fun
       // info.el.style.borderColor = 'red';
      //  return false;
      }
  

    
    
  });  //End  ------------  var calendar = new FullCalendar.Calendar(calendarEl,


  var arr = getCalendarDataInDB();
  $.each(arr, function(index, item){
  		  calendar.addEvent( item );
  });  
  
  
  calendar.render();
  
  calendar.on('dateClick', function(info) {
	// console.log('clicked on ' + info.dateStr);
  });
  
	  

});

 //일정 입력
function onSelectEvent(){
	 insertModalOpen("onSelectEvent");
}


 //arr 는 테스트용으로 DB 에서 스케즐 데이터를 가져오지 못했을 경우 테스트용 데이터
function getCalendarDataInDB(){
    var arr = [{title: 'evt111', start:'2021-10-01' ,end:'2021-10-31'}, {title: 'evt2', start:'123123123'}];
     console.log("getCalendarDataInDB");
    $.ajax({
        contentType:'application/json',
        dataType:'json',
        url:'${path}/selectEventList',
        type:'post',
        async: false,
        //resp db에서 가져오는 데이터
        success:function(resp){
        	//console.log(" resp ");
        	//console.dir(resp);
        	arr=resp;
        },
        error:function(res){
            console.dir(res);        	
        }
    });
    return arr;
}

$(function(){
	$('body').on('click', 'button.fc-prev-button', function(e) {
		  //console.log("prev");
		  //console.log(e);
		  //console.log(this);
	});

	$('body').on('click', 'button.fc-next-button', function(e) {
		//console.log("next");
	});
})

    // 받은 날짜값을 date 형태로 형변환 해주어야 한다.
function convertDate(date) {
        var date = new Date(date);
        alert(date.yyyymmdd());
}

</script>


<%@ include file="calendar_modal.jsp" %>
<%@ include file="../common/footer.jsp"%>

</body>
</html>
