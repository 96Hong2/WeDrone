<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 

 <div class="modal fade insertModal" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h2 class="modal-title text-center" style="width: 100%; font-size: 1.7rem"></h2>
          <button type="button" class="close" onclick="closeModal()">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <div class="form-group empl_nm">
			<label for="empl_nm">scheduleId:</label>
			<input type="text" class="form-control" id="scheduleId"  name="scheduleId" readonly="readonly">
		  </div>
		  
   		  <br>
          <div class="form-group">
			<label for="title">제목:</label>
			<input type="text" class="form-control" placeholder="" id="title" maxlength="30">
		  </div>
	
	
		<div class="form-group">		
			<input type="text" name="daterange" id="daterange"    value="" class="form-control" /> 
		</div>
	
	
	      <div class="form-group empl_nm">
			<label for="date">시작일:</label>
			<input type="text" class="form-control"  id="startDate" name="startDate">
		  </div>	
	
	      <div class="form-group empl_nm">
			<label for="date">종료일:</label>
			<input type="text" class="form-control"  id="endDate" name="endDate">
		  </div>	


        <!-- Modal footer -->
        <div class="modal-footer">
		  <button type="button" class="btn btn-danger  scheDeleteBtn" onclick="deleteSch()"   >삭제</button>
		  <button type="button" class="btn btn-warning schInsertBtn" onclick="insertSch('insertModal', g_arg)">등록</button>
		  <button type="button" class="btn btn-warning schUpdateBtn" onclick="updateSch('insertModal', g_arg)" >수정</button>
        </div>
        
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
var daterangeStartDate="";
var daterangeEndDate="";

function customDaterangePicker(){
	  
	$('input[name="daterange"]').daterangepicker({
	    "showDropdowns": true,
	    "showWeekNumbers": true,
	    "showISOWeekNumbers": true,
	    "timePicker": true,
	    "timePicker24Hour": true,
	    "timePickerSeconds": true,
	    "locale": {
	        "format": "YYYY-MM-DD Ah:mm",
	        "separator": " - ",
	        "applyLabel": "적용",
	        "cancelLabel": "취소",
	        "fromLabel": "From",
	        "toLabel": "To",
	        "customRangeLabel": "사용자 지정",
	        "weekLabel": "W",
	        "daysOfWeek": [
	            "일",
	            "월",
	            "화",
	            "수",
	            "목",
	            "금",
	            "토"
	        ],
	        "monthNames": [
	            "1월",
	            "2월",
	            "3월",
	            "4월",
	            "5월",
	            "6월",
	            "7월",
	            "8월",
	            "9월",
	            "10월",
	            "11월",
	            "12월"
	        ],
	        "firstDay": 1
	    },
	    "autoUpdateInput": false,
	    "alwaysShowCalendars": true,
	    "startDate":daterangeStartDate,
		"endDate": daterangeEndDate,
	    
	    "minDate": "2000-12-31",
	    "maxDate": "2050-12-31" 
	}, function(start, end, label) {
		//console.log("start:"+start);
		//console.log(start);
		//console.log("end:"+end);
		//console.log(end);
		//console.log("label:"+label);
		//console.log(label);
		//console.log("moment().format():"+  moment(start).format());
		
		$("#startDate").val(moment(start).format());
		$("#endDate").val(moment(end).format());
		$("#daterange").val(start.format('YYYY-MM-DD Ah:mm')+"  ~   "+end.format('YYYY-MM-DD Ah:mm'));
		
		// console.log("New date range selected: " + start.format('YYYY-MM-DD A h:mm') + " to " + end.format('YYYY-MM-DD A h:mm') + " (predefined range: " + label + ")");
	});
     
}



//이벤트 등록 모달
function insertModalOpen(arg){
	$(".scheDeleteBtn").css("display","none");
	$(".schInsertBtn").css("display","block");
	$(".schUpdateBtn").css("display","none");
	
	$(".modal-title").text("일정 등록");
	$("#title").val("");
	
	
	if(arg=="onSelectEvent"){
	  var date1=new Date();
	  arg={
			  dateStr:moment(date1).format('YYYY MM DD')
	  }		
	}
	
	//console.log(arg);
	//console.log(arg.dateStr);
	g_arg = arg;

	//초기 해당일 날짜 셋팅
	daterangeStartDate=arg.dateStr+" AM12:00";
	daterangeEndDate=arg.dateStr+" PM1:00";
	$("#daterange").val(daterangeStartDate +"  ~   "+daterangeEndDate );	
	var sd1 = new Date(arg.dateStr+"T12:00:00");
	var ed1 = new Date(arg.dateStr+"T13:00:00");	
	$("#startDate").val(moment(sd1).format());
	$("#endDate").val(moment(ed1).format());
	$(".daterangepicker_input input[name=daterangepicker_start]").val(daterangeStartDate);
	$(".daterangepicker_input input[name=daterangepicker_end]").val(daterangeEndDate);
	//end - 초기 해당일 날짜 셋팅
	
	//var ddddd3=new Date("2021-09-10T18:00:00+09:00")
	//$("#title").val(moment("2021-09-05T12:00:00+09:00").format('YYYY-MM-DD Ah:mm'))	
	customDaterangePicker();
	//console.log(g_arg.dateStr);	
	$('.insertModal').modal("show");	
}





 //스케쥴 등록
function insertSch(modal, arg){
	//console.log("modal:" +modal);
	//console.log(arg);
	var scheduleName=$("#title").val();
	var startDate=$("#startDate").val();
	var endDate=$("#endDate").val();
	
    if($('.insertModal #end').val() <= $('.insertModal #start').val()){
		  alert('종료시간을 시작시간보다 크게 선택해주세요');
		  $('.insertModal #end').focus();
		  return;
	  }
	if($('.'+modal+' #title').val() == ''){
		alert('제목을 입력해주세요');
		$("#title").focus();
		return;
	}
	
	if(startDate=="" || startDate=="Invalid date"){
		alert("시작 날짜를 다시 선택해 주세요.");
		return;
	}

	if(endDate=="" || endDate=="Invalid date"){
		alert("종료 날짜를 다시 선택해 주세요.");
		return;
	}
	

	var param={
			scheduleName:scheduleName,
			startDate:startDate,
			endDate:endDate,
	}
	
	//스케줄 작성
 	$.ajax({
	  url: "${path}/addSchedule",
	  type: "POST",
	  data: param,
	  dataType: "text",
	  success : function(result){		 
		 //console.log(result);
		 
		 loadEvents();		    
	
	  },
	  error : function(result){
		  console.log("error:");
		  console.log(result);
	  }
	});
	    
}	

 //캘린더 Refresh
function loadEvents() {	
	calendar.destroy();
	var currentDatePage=$("#currentDatePage").val();
	var calendarEl = document.getElementById('calendar');
	var refreshCalendar = new FullCalendar.Calendar(calendarEl, { 	  
			googleCalendarApiKey: 'AIzaSyDqXhIu1nACWbwfRgPhoulB0GLxlb3OW_0',
		    eventSources: [
				   		 {
				          googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
				          className: '대한민국의 휴일',
				          color: '#be5683', //rgb,#ffffff 등의 형식으로 할 수 있어요.
				          //textColor: 'black' 
				        },
				        			        
				  		 {
				            googleCalendarId: 'du6b9s50h56t8aq0tgnfjhfpl8@group.calendar.google.com',
				            className: '드론일정',
				            color: '#c0ca33', //rgb,#ffffff 등의 형식으로 할 수 있어요.
				            //textColor: 'black' 
				          },
					  	{
					            googleCalendarId: 'jjuunn613@gmail.com',
					            className: '홍길동',
					            color: '#16bf71', //rgb,#ffffff 등의 형식으로 할 수 있어요.
					            //textColor: 'black' 
					    },
				          	   
		    ],
		    
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
			initialDate : currentDatePage, // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
			locale : 'ko', // 한국어 설정
			//editable : true, // 수정 가능
			//droppable : true, // 드래그 가능
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
				insertModalOpen(arg);
		    },	    	    
		    eventClick: function(info) {
		    	event.preventDefault();
		    	console.dir(info);    	
		    	console.log(info.event.title + '수정 : ' + info.event.id);
		    	var url=info.event.url;
		    	console.log(url);
		    	updateModalOpen(info.event.id, url);
		      }
		 });  //End  ------------  var calendar = new FullCalendar.Calendar(calendarEl,
	  
	
	var arr = getCalendarDataInDB();
	$.each(arr, function(index, item){
		refreshCalendar.addEvent( item );
	});	
	refreshCalendar.render();
	$('.insertModal').modal("hide");
	
	
} 
 
 //모달 닫기
function closeModal(){
	$('.insertModal').modal("hide");
} 

//이벤트 수정 및 삭제 모달
function updateModalOpen(id, url){
	$(".scheDeleteBtn").css("display","block");
	$(".schInsertBtn").css("display","none");
	$(".schUpdateBtn").css("display","block");
	
	
	$(".modal-title").text("일정 수정");
	
	if(url==""){
		
		$.ajax({
			  url: "${path}/getEvent",
			  type: "POST",
			  data: {id:id},
			  dataType: "json",
			  success : function(data){		 
				 //console.log(data);
				 	
				 	$("#title").val(data.title);
				 	$("#scheduleId").val(data.id);
				 	
					//초기 해당일 날짜 셋팅
					var start=data.start;
					var end=data.end;
					$("#startDate").val(start);
					$("#endDate").val(end);
										
					daterangeStartDate=moment(start).format('YYYY-MM-DD Ah:mm');
					daterangeEndDate=moment(end).format('YYYY-MM-DD Ah:mm');
					$("#daterange").val(daterangeStartDate +"  ~   "+daterangeEndDate );
		
					$(".daterangepicker_input input[name=daterangepicker_start]").val(daterangeStartDate);
					$(".daterangepicker_input input[name=daterangepicker_end]").val(daterangeEndDate);					
					//end -  해당일 날짜 셋팅
					//date picker 호출
					customDaterangePicker();
					$('.insertModal').modal("show");
			  },
			  error : function(result){
				  console.log("error:");
				  console.log(result);
			  }
		});
		
						
	}else{
		//구글 이동
		window.open(url);
	}
	
}
 
 
//삭제 처리 
function deleteSch(){
	var id=$("#scheduleId").val();
	if(confirm("정말 삭제 하시겠습니까?")){
		$.ajax({
			  url: "${path}/deleteSch",
			  type: "POST",
			  data: {id:id},
			  dataType: "json",
			  success : function(result){		 
				// console.log(result);
				 if(result==1){
					 loadEvents();		     
				 }else{
					 console.log("error");
				 }				 
			  },
			  error : function(result){
				  console.log("error:");
				  console.log(result);
			  }
		});
		
	}
		    
} 
 
 
 

//스케쥴 수정
function updateSch(modal, arg){
	var scheduleId=$("#scheduleId").val();
	var scheduleName=$("#title").val();
	var startDate=$("#startDate").val();
	var endDate=$("#endDate").val();
	
   if($('.insertModal #end').val() <= $('.insertModal #start').val()){
		  alert('종료시간을 시작시간보다 크게 선택해주세요');
		  $('.insertModal #end').focus();
		  return;
	  }
	if($('.'+modal+' #title').val() == ''){
		alert('제목을 입력해주세요');
		$("#title").focus();
		return;
	}
	
	if(startDate=="" || startDate=="Invalid date"){
		alert("시작 날짜를 다시 선택해 주세요.");
		return;
	}

	if(endDate=="" || endDate=="Invalid date"){
		alert("종료 날짜를 다시 선택해 주세요.");
		return;
	}
	

	var param={
			scheduleId:scheduleId,
			scheduleName:scheduleName,
			startDate:startDate,
			endDate:endDate,
	}
	
	
	$.ajax({
	  url: "${path}/updateSch",
	  type: "POST",
	  data: param,
	  dataType: "text",
	  success : function(result){		 
		 loadEvents();		    	
	  },
	  error : function(result){
		  console.log("error:");
		  console.log(result);
	  }
	});
	    
}	

 
 
</script>