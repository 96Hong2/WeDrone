<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
   crossorigin="anonymous">
   
</script>
<!-- 부트스트랩 css 추가 -->
<link href="${path}/resources/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
   href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500&display=swap"
   rel="stylesheet">
<%-- 공통 css --%>
<link href="${path}/resources/css/common.css?var=3" rel="stylesheet">

<!-- 아이콘 -->
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css"
   integrity="sha384-wESLQ85D6gbsF459vf1CiZ2+rr+CsxRY0RpiF1tLlQpDnAgg6rwdsUF1+Ics2bni"
   crossorigin="anonymous">
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<link href="${path}/resources/css/main.css?ver=95" rel="stylesheet">
<link href="${path}/resources/css/reviewMK.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* 푸터 위의 내용 감싸서 내용 없어도 푸터 하단으로 가도록 */
.wrap {
   text-align: center;
   display: flex;
   flex-direction: column;
   height: 80%
}

footer {
   width: 100%;
   height: 80px;
   background-color: #3c3c3c;;
   margin-top: auto
}

body, html {
   font-family: 'Do Hyeon', sans-serif;
}

/* 후기마커 */
.overlay {
   margin-bottom: 60px;
   background-color: rgba(248, 210, 221, 0.5);
   padding: 10px;
}

.overlay .left {
   font-size: 18px;
   font-weight: 900;
   display: flex;
   justify-content: left;
}

.overlay .right {
   font-size: 12px;
   display: flex;
   justify-content: right;
}

.overlay * {
   vertical-align: center;
}

.gauge1 {
   height: 10px;
   background-color: pink;
   display: inline-block;
   "
}

.gauge2 {
   height: 10px;
   background-color: #ccc;
   display: inline-block;
   "
}

#reloadBtn {
   position: absolute;
   top: 80px;
   right: 20px;
}

/* 사이드메뉴+지도 */
#contentWrap {
   display: flex;
}

/* 사이드메뉴 탭 */
#sideArea {
   width: 30%;
   height: 700px;
   overflow: auto;
   margin: 0 auto;
   justify-content: left;
   /* 가로 스크롤바 숨기기 */
	overflow-x: hidden;
}

ul.tabs {
   margin: 0px;
   padding: 0px;
   list-style: none;
}

ul.tabs li {
   background: none;
   color: #222;
   display: inline-block;
   padding: 10px 15px;
   cursor: pointer;
}

ul.tabs li.current {
   background: #ededed;
   color: #222;
}

.tab-content {
   display: none;
   background: #ededed;
   padding: 15px;
}

.tab-content.current {
   display: inherit;
}

/* 지도 */
#map {
   width: 70%;
   height: 700px;
   justify-content: right;
}

/* 후기마커 리스트 */
#listTopArea {
   display: flex;
   justify-content: space-between;
   margin: 10px;
}

#orderMenu a {
   color: black;
   text-decoration: none;
}

#orderMenu a:hover {
   font-weight: bold;
}

#reloadBtn2 {
   /* justify-content: left; */
   
}

#orderMenu {
   /* display:inline-block;margin-left:270px; margin-bottom:15px; */
   /* justify-content: right; */
   
}

/* .overlay .center {background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 50px;font-size: 12px;line-height: 50px;}
.overlay .left {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 50px;overflow: hidden;vertical-align: center;width: 7px;}
.overlay .right {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 50px;overflow: hidden;vertical-align: center;width: 6px;} */
</style>
</head>
<title>드론</title>
<body>
   <!-- 상단 메뉴바 -->
   <!-- 아이디 있을 때 네비바 -->
   <c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="../fixmenu/navbar.jsp" />
	</c:if>

	<!-- 아이디 없을때 네비바 -->
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="../fixmenu/lognav.jsp" />
	</c:if>

 
<%--    <div class="wrap">
      <!-- 네비게이션바 -->
      <nav class="navbar navbar-expand-lg navbar-dark"
         style="background-color: #3c3c3c;">
         <div class="container-fluid">
            <a
               class="fs-3 text-center navbar-brand fw-bold text-color: #003399;"
               href="${path}/"> <img src="resources/img/LOGO.png"
               class="rounded float-end rounded mx-auto d-block mx-2" alt=""
               width="50" height="50">WeDron
            </a>
            <button class="navbar-toggler" type="button"
               data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
               aria-controls="navbarSupportedContent" aria-expanded="false"
               aria-label="Toggle navigation">
               <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
               <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item dropdown "><a
                     class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"
                     href="#" role="button" aria-expanded="false"><h4>Map</h4></a>
                     <ul class="dropdown-menu active">
                        <li><a class="dropdown-item" href="#">비행지역 조회</a></li>
                        <li><a class="dropdown-item" href="${path}/map">지도 보기</a></li></li>
               </ul>
               <li class="nav-item"><a class="nav-link active text-center "
                  href="${path}/calendar"><h4>Calendar</h4></a></li> <a
                  class="nav-link active" href="${path}/news"><h4>News</h4></a>
               </li>
               <li class="nav-item"><a class="nav-link active text-center "
                  href="${path}/notice"><h4>Notice</h4></a></li>
               <li class="nav-item"><a class="nav-link active text-center "
                  href="${path}/board"><h4>Board</h4></a></li>
               <li class="nav-item"></li>
               </ul>
               <div class="d-flex" id="alarmalert">
                  <i id="bell" class="bi bi-bell-fill"
                     style="font-size: 1.8rem; color: white"></i><br> <span
                     id="cartalertnum"
                     class="border border-dark position-absolute top-0 mx-3 badge bg-white text-white rounded-pill mt-2"></span>
               </div>
               <div class="d-flex">
                  <a class="btn btn-sm btn-outline-light mx-3 me-1"
                     href="${path}/login" role="button">로그인</a> <a
                     class="btn btn-sm btn-outline-light me-1 mx-1"
                     href="${path}/signup" role="button">회원가입</a> <a
                     class="btn btn-sm btn-outline-light mx-1 me-1"
                     href="${path}/mypages" role="button">마이페이지</a>
                  <button class="btn btn-sm btn-outline-light mx-1 " type="button"
                     data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
                     aria-controls="offcanvasRight">메시지</button>
               </div>
            </div>
      </nav>
  --%>
 
	<!-- 후기마커 상세보기 모달창 import -->
	<c:import url="../reviewDetail.jsp"></c:import>

      <!-- 들어갈 내용 -->
      <script type="text/javascript"
         src="//dapi.kakao.com/v2/maps/sdk.js?appkey=96f67dd6c088728e30743d7db32a6789&libraries=services"></script>

      <div id="contentWrap">
         <!-- 사이드메뉴 영역 -->
         <div id="sideArea">
            <div style="margin: 40px; text-align: center;">
               <h5>
                  <b>Enjoy your flight, WeDrone</b>
               </h5>
               <h6>${sessionScope.loginNickName} 님, 환영합니다 ^ㅇ^</h6>
            </div>
            <ul class="tabs">
               <li class="tab-link" id="tab-myLocationMK-li" data-tab="tab-myLocationMK">내위치마커</li>
               <li class="tab-link current" id="tab-reviewMK-li" data-tab="tab-reviewMK">후기마커</li>
               <li class="tab-link" id="tab-bookmark-li" data-tab="tab-bookmark">즐겨찾기</li>
               <li class="tab-link" id="tab-myReviewMK-li" data-tab="tab-myReviewMK">내후기마커</li>
            </ul>
			
			<!-- 내 위치 마커 탭 -->
            <div id="tab-myLocationMK" class="tab-content">내위치마커 내용</div>

			<!-- 후기마커 탭 -->
            <div id="tab-reviewMK" class="tab-content current">
               <h4 id="firstComment" style="color: crimson; text-align: center;">♥
                  지역을 선택해주세요! ♥</h4>
               <div id='reviewListArea'>
                  <div>지도를 클릭하여 후기마커를 등록해보세요.</div>
                  <div id="listTopArea">
                     <div id="reloadBtn2">
                        <button type="button" onclick="location.reload(true)"
                           style="display: inline-block;"
                           class="btn btn-sm btn-outline-dark mx-1 me-1">전체지역보기</button>
                     </div>
                     <div id='orderMenu'>
                     </div>
                  </div>

                  <div id='reviewList'>
                     <ul class="list-group list-group-flush" id="reviewUl">
                        <!-- <li class="list-group-item">An item</li> -->
                     </ul>
                  </div>
               </div>
            </div>

			<!-- 즐겨찾기 탭 -->
            <div id="tab-bookmark" class="tab-content">
            	<div id="bookmarkListArea">
				<c:if test="${sessionScope.loginId eq null}">
					<div id="bookmarkComment" style="margin:10px;text-align:center;">
						<h6>로그인이 필요한 서비스입니다.</h6>
						<h6>로그인하고 마음에 드는 후기마커를 즐겨찾기해보세요!</h6>
					</div>
				</c:if>
                <c:if test="${sessionScope.loginId ne null}">
					<div id="bookmarkComment" style="margin:10px;text-align:center;">
						<h6>즐겨찾기한 후기마커가 없습니다.</h6>
						<h6>후기마커 탭에서 새로운 즐겨찾기를 등록해보세요!</h6>
					</div>
				</c:if>  

                  <div id="bookmarkList">
                     <ul class="list-group list-group-flush" id="bookmarkUl">
                        
                     </ul>
                  </div>
               </div>
            </div>

            <!-- 내 후기 마커 탭 -->
            <div id="tab-myReviewMK" class="tab-content">
				<div id="ReviewListArea_my">
				<c:if test="${sessionScope.loginId eq null}">
					<div id="myRevComment" style="margin:10px;text-align:center;">
						<h6>로그인이 필요한 서비스입니다.</h6>
						<h6>로그인하고 나만의 후기마커를 남겨보세요!</h6>
					</div>
				</c:if>
                <c:if test="${sessionScope.loginId ne null}">
					<div id="myRevComment" style="margin:10px;text-align:center;">
						<h6>등록된 후기마커가 없습니다.</h6>
						<h6>후기마커 탭에서 새로운 후기마커를 등록해보세요!</h6>
					</div>
				</c:if>  

                  <div id="reviewList_my">
                     <ul class="list-group list-group-flush" id="reviewUl_my">
                        
                     </ul>
                  </div>
               </div>           	
           	
           	</div>

         </div>

         <!-- 지도 영역 -->
         <div id="map"></div>

      </div>

   <!-- 모달 영역 -->
      <div class="modal fade" id="reviewModal" tabindex="-1"
         aria-labelledby="reviewModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="reviewModalLabel"></h5>
                     <input type="hidden" id="rmLat" name="rmLat" value=""/>
                     <input type="hidden" id="rmLng" name="rmLng" value=""/>
                     <input type="hidden" id="rmLoginId" name="rmLoginId" value="${sessionScope.loginId}"/>
                     <input type="hidden" id="rmLoginNickName" name="rmLoginNickName" value="${sessionScope.loginNickName}"/>
                  <button type="button" class="btn-close" data-bs-dismiss="modal"
                     aria-label="Close"></button>
               </div>
               <div class="modal-body">
                  <input id="content" type="text" name="content" maxlength="200" placeholder="10자 이상 입력해주세요"/>
                     <!--  <form id="fileUpload" enctype="multipart/form-data"> -->
                        <input type="file" name="rmPhoto" id="rmPhoto" accept="image/*"/>
                     <!--  </form>-->
               </div>
               <div class="modal-footer">
               <select name="rating" id="rating" style="width:100px; height:30px;">
               <option value='1'>1</option>
               <option value='2'>2</option>
               <option value='3'>3</option>
               <option value='4'>4</option>
               <option value='5'>5</option>
            </select>
                  <button type="button" class="btn btn-secondary"
                     data-bs-dismiss="modal" id="closeBtn">취소</button>
                  <button type="button" class="btn btn-primary" id="rmSubmit">등록</button>
               </div>
            </div>
         </div>
      </div>

</body>

<script>
      
$(document).ready(function(){
   
	//리뷰리스트 숨기기
   $('#reviewListArea').hide();
   
   //탭 설정
   $('ul.tabs li').click(function(){
      var tab_id = $(this).attr('data-tab');

      $('ul.tabs li').removeClass('current');
      $('.tab-content').removeClass('current');

      $(this).addClass('current');
      $("#"+tab_id).addClass('current');
   })
   
   //후기마커 탭 클릭 시
   $('#tab-reviewMK-li').click(function(){
	   location.reload(true);       
   })
   
   //내후기마커 탭 클릭 시
   $('#tab-myReviewMK-li').click(function(){
	 //지도 초기화
	 deletePolygon(polygons); //폴리곤 제거
     customOverlay.setMap(null); //현재 존재하는 오버레이 삭제
     map.setDraggable(true); //마우스 드래그로 지도 이동하기 on
     deleteMarkers(markers);//마커 제거
     marker.setMap(null);
     
     map.setLevel(10, {anchor: new kakao.maps.LatLng(37.21953563998351, 127.21194259376661)});
     map.setZoomable(true);
     map.setMaxLevel(10);
     map.setCenter(new kakao.maps.LatLng(37.21953563998351, 127.21194259376661));
     //kakao.maps.event.removeListener(map, 'click', reviewMarkerAdd); //클릭 이벤트 제거
     
     loadMyReviews("${sessionScope.loginId}");
   })
   
   //즐겨찾기 탭 클릭 시
   $('#tab-bookmark-li').click(function(){
	 //지도 초기화
	 deletePolygon(polygons); //폴리곤 제거
     customOverlay.setMap(null); //현재 존재하는 오버레이 삭제
     map.setDraggable(true); //마우스 드래그로 지도 이동하기 on
     deleteMarkers(markers);//마커 제거
     marker.setMap(null);
     
     map.setLevel(10, {anchor: new kakao.maps.LatLng(37.21953563998351, 127.21194259376661)});
     map.setZoomable(true);
     map.setMaxLevel(10);
     map.setCenter(new kakao.maps.LatLng(37.21953563998351, 127.21194259376661));
     //kakao.maps.event.removeListener(map, 'click', reviewMarkerAdd); //클릭 이벤트 제거
     
     loadBookMarks("${sessionScope.loginId}");
   })
   
   //자동 스크롤
   //$('#sideArea').scrollTop($('#sideArea').scrollHeight);

})
      
      //#카카오맵 api 불러오기
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new kakao.maps.LatLng(37.21953563998351, 127.21194259376661), // 지도의 중심좌표
         draggable: false,
         level : 10
      // 지도의 확대 레벨
      };

      // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
      var map = new kakao.maps.Map(mapContainer, mapOption);
      
      //지도 클릭시 나타나는 인포윈도우
      var infowindow = new kakao.maps.InfoWindow({zindex:1}); 
      
      //지도를 불러올 때 줌 못하게 막음
      function setZoomable(zoomable) {
             // 마우스 휠로 지도 확대,축소 가능여부를 설정합니다
          map.setZoomable(false);    
      }
      
      var geocoder = new kakao.maps.services.Geocoder();
      
      //#지역 폴리곤 나누기
      $.getJSON("resources/geojson/gyeonggi-do.geojson", function(geojson) {

         var data = geojson.features;
         var coordinates = []; //좌표 저장할 배열
         var name = ''; //행정 구 이름

         $.each(data, function(index, val) {

            coordinates = val.geometry.coordinates;
            name = val.properties.SIG_KOR_NM;

            displayArea(coordinates, name);

         })
      })
      

      //function 안 쪽에 지역변수로 넣으니까 폴리곤 하나 생성할 때마다 배열이 비어서 클릭했을대 전체를 못 없애줌. 그래서 전역변수로 만듦.
      var polygons = [];
      //현재 지도에 띄워지는 커스텀 오버레이 변수 설정
      var customOverlay = new kakao.maps.CustomOverlay();
      //현재 지도에 띄워져있는 후기마커들을 저장하는 배열 //지울 때 한꺼번에 지우기 위함
      var markers = [];
   	 //후기마커의 개수 저장
      var listCnt = 0;
   	 //후기마커들의 reviewId를 저장하는 배열
   	 var reviewIds = [];
   	 //후기작성 마커
   	 var marker = new kakao.maps.Marker();
      
      //#지역 오버레이에서 선택버튼 클릭 시 수행되는 함수 
      //해당 지역 확대 및 리스트,마커 가져오기
      function selectArea(name, order){ //지역명, 정렬기준
         //정렬기준 : default는 지역선택에 의한 함수실행으로 지역 확대가 이루어짐,
         //like는 좋아요순, latest는 최신순 선택에 의한 함수실행으로 지역확대X
         console.log("selectArea name/order : "+name+"/"+order);
         
         if(order=='default'){
            //현재 지도 레벨에서 2레벨 확대한 레벨
            var level = map.getLevel() - 2;
            
            //지도를 클릭된 폴리곤의 중앙 위치를 기준으로 확대합니다.
            map.setLevel(level, {
               anchor : centroid(name),
               animate : {
                  duration : 350 //확대 애니메이션 시간
               }
            });

            deletePolygon(polygons); //폴리곤 제거
            customOverlay.setMap(null); //현재 존재하는 오버레이 삭제
            map.setDraggable(true); //마우스 드래그로 지도 이동하기 on
            /*
            map.setMinLevel(3); //지도 최소 확대레벨
            map.setMaxLevel(9); //지도 최대 확대레벨*/
            
         
            $("#firstComment").hide();
            $('#reviewListArea').show();            
         }
         
         //리뷰마커를 로드하는 함수
         loadReviews(name, order);
         
         
         // 지도를 클릭한 위치에 표출할 마커입니다
         marker = new kakao.maps.Marker({ 
             // 지도 중심좌표에 마커를 생성합니다 
             position: map.getCenter() 
         }); 
         // 지도에 마커를 표시합니다
         marker.setMap(map);
         
         //var infowindow = new kakao.maps.InfoWindow({zindex:1}); 
         
         // 지도에 클릭 이벤트를 등록합니다
         // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
         kakao.maps.event.addListener(map, 'click', function reviewMarkerAdd(mouseEvent){
        	 
            infowindow.close();


                   // 클릭한 위도, 경도 정보를 가져옵니다 
                   var latlng = mouseEvent.latLng; 
                   
                   
                   //클릭한 위치의 주소 받아오기
                   searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
                       if (status === kakao.maps.services.Status.OK) {
                           var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
                           detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
                           
                           var rmLat = latlng.getLat(); 
                           var rmLng = latlng.getLng(); 
                           
                           var address_info = result[0].address.address_name
                           
                           var content = '<div class="bAddr">' +
                                           '<span class="title">법정동 주소정보</span>' + 
                                           detailAddr + 
                                       '</div>'+
                                       '<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#reviewModal" onclick="reviewWrite(\''+result[0].address.address_name+'\', '+rmLat+', '+rmLng+')">'+
                                       '후기 작성'+
                                     '</button>';
                                     
                                     var content2 = '<div class="bAddr">' +
                                     '<span class="title">법정동 주소정보</span>' + 
                                     detailAddr + 
                                 '</div><div><p style="color:red;">선택 지역을 벗어났습니다.</p></div>';
                                     
                           console.log("상세주소 : "+address_info);
                           console.log("지역명 : "+name);
                           
                           infowindow.setContent(content);
                           
                           if(address_info.indexOf(name) == -1){
                        	   infowindow.setContent(content2);
                           }
                                       
                   // 마커 위치를 클릭한 위치로 옮깁니다
                   marker.setPosition(latlng);
                   marker.setMap(map);

                                       
                                       infowindow.open(map, marker);
                                     

                                    /*
                                       // 마커에 마우스아웃 이벤트를 등록합니다
                                       kakao.maps.event.addListener(marker, 'mouseout', function() {
                                           // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
                                           infowindow.close();
                                       });*/
                   
                   /*var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
                   message += '경도는 ' + latlng.getLng() + ' 입니다';
                   
                   var resultDiv = document.getElementById('clickLatlng'); 
                   resultDiv.innerHTML = message;*/
                       }
                   });
         });
         
         
         
      } //end selectArea()
      
      
      function loadReviews(name, order){ //리뷰리스트와 후기마커를 로드하는 메소드
    	  
    	  deleteMarkers(markers); //현재 지도에 띄워져있는 마커가 있으면 모두 제거한다.
    	  reviewIds = []; //reviewIds 초기화
    	  
    	  $.ajax({
              url:'getReviewList',
              type:'GET',
              data : {
                 "areaName" : name,
                 "order" : order
              },
              dataType:'JSON',
              success:function(data){
            	  
                 var orderStr = '<a href="javascript:selectArea(\''+name+'\', \'like\')">좋아요순</a>'
                 +'&nbsp;|&nbsp;<a href="javascript:selectArea(\''+name+'\', \'latest\')">최신순</a>';
                 $('#orderMenu').empty();
                 $('#orderMenu').append(orderStr);
                 
                 console.log("후기마커 data : ", data);
                 console.log("후기마커 list : ", data.list);
                 console.log("후기마커 list[0] : ", data.list[0]);
                 
                 var content = "";
                 var list = data.list;
                 listCnt = list.length;
                 
                 list.forEach(function(review, index){
                    //console.log("후기마커"+index+"번째 : ", review);
                    
                    //평점(구름아이콘)
                    var rating = "";
                    for(var i=0; i<review.rating; i++){
                       rating +="<img src='resources/img/cloud.png' class='revRatingImg'>";
                    }
                   
                    var element = "<li class='list-group-item'>"
                    +"<a href=# class='reviewAnchor'>"
                    +"<div class='reviewWrap"+review.reviewId+"'>"
                    //+"<div> 후기마커 번호 : "+review.reviewId+"</div>"
                    +"<div class='revBox1'>"
                    +"<img class='reviewThumb' src='/photo/"+review.newFileName+"'/>"
                    +"<div class='revBox1_1'>"
                    +"<div class='revNickName'>"+review.nickName+"</div>"
                    +"<div calss='revAddress'>"+review.address+"</div>"
                    +"</div>"
                    +"</div>"
                    +"<div class='invisibleBox'></div>"
                    +"<div class='revBox2'>"
                    +"<div class='revRating'>"+rating+"</div>"
                    +"<div class='revBox2_1'>"
                    +"<div class='revBox2_2'>"
                    +"<div calss='revCmtCnt'><img src='resources/img/comment.png' width='18px' height='18px'> 댓글 "+review.commentCnt+"</div>"
                    +"<div calss='revLikeCnt'><img src='resources/img/like1_full.png' width='18px' height='18px'> 좋아요 "+review.likeCnt+"</div>"
                    +"</div>"; //end revBox2_2

                    /*
                    if(review.isLike > 0){
                       element += "<div calss='revIsLike'>"+"♥"+"좋아요 : "+review.likeCnt+" 개</div>"; 
                    }else{
                       element += "<div calss='revIsLike'>"+"♡"+"</div>";
                    }
                    */
                    
                    if(review.isBookMark > 0){
                        element += "<div class='revIsBookMark'><img src='resources/img/star.png' class='revBookMarkImg'></div>";
                     }else{
                        element += "<div class='revIsBookMark'><img src='resources/img/star2.png' class='revBookMarkImg'></div>";
                     }
                    element += "</div></div>"; //end .revBox2_1, .revBox2
                    element += "</div></a></li><hr/>";
                    content += element;
                    
                  //지도에 후기마커 생성
                    var imageSrc = "resources/img/marker1.png";
                    var imageSize = new kakao.maps.Size(45, 50);
                    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                    
                    var revMarker = new kakao.maps.Marker({
                       map : map,
                       position: new kakao.maps.LatLng(review.lat, review.lon),
                       image : markerImage
                    });
                    
                    //클릭 시 후기마커 상세보기 모달창 열기
                    kakao.maps.event.addListener(revMarker, 'click', function(e) {
                        var userId = "${sessionScope.loginId}";
                        var reviewId = review.reviewId;
                        console.log("userId / reviewId : "+userId+"/"+reviewId);
                        
                     	loadReviewDetail(reviewId, userId, "reviewMK");
                     	$('#detailModal').modal("show");
                     });
                    
                    kakao.maps.event.addListener(revMarker, 'mouseover', function() {
                         //마커 하이라이트
                         imageSize = new kakao.maps.Size(52, 57); //1.5배 크기로
                         markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                         revMarker.setImage(markerImage);
                         revMarker.setMap(map);
                         
                         //리스트 하이라이트
                         $('.reviewWrap'+review.reviewId).css("background-color", "aliceblue");
                         $('.reviewWrap'+review.reviewId).css("color", "skyblue");
                         $('.reviewWrap'+review.reviewId)[0].scrollIntoView({behavior: "smooth", block: "center"});
                     });
                    
                    kakao.maps.event.addListener(revMarker, 'mouseout', function() {
                         
                         //마커 원래대로
                         imageSize = new kakao.maps.Size(45, 50); //원래 크기로
                         markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                         revMarker.setImage(markerImage);
                         revMarker.setMap(map);
                         
                          //리스트 원래대로
                         $('.reviewWrap'+review.reviewId).css("background-color", "white");
                         $('.reviewWrap'+review.reviewId).css("color", "black");
                     });

                    
                    markers.push(revMarker); //마커배열에 이 마커 추가
                  
    				reviewIds.push(review.reviewId); //reviewIds배열에 reviewId저장 //마커스의 인덱스와 같이 감
                    
                    
                 }) //end forEach()
                 
                 $("#reviewUl").empty();
                 $("#reviewUl").append(content);
                 
                //마우스오버된 후기 하이라이트
              	reviewIds.forEach(function(reviewId, i){
    	             	//각각의 reviewId와 index i를 받아옴
    	               	
    	               	var imageSrc = "resources/img/marker1.png";
    	               	
    	               	(function(reviewId, i){
  	  	              		document.getElementsByClassName("reviewWrap"+reviewId)[0].addEventListener("mouseover",function(){
    		               		$(this).css("background-color", "aliceblue");
    	        	       		//console.log("마우스오버 markers["+i+"] : ",markers[i]);
  		       			  	//마커 하이라이트
  		       			  	markers[i].setMap(null);
  		       		  		var imageSize = new kakao.maps.Size(55, 60); //1.5배 크기로
  			       		  	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
  			       		 	markers[i].setImage(markerImage);
  			       			markers[i].setMap(map);
    	        	       	});
    	               	
  	  	              		document.getElementsByClassName("reviewWrap"+reviewId)[0].addEventListener("mouseout",function(e){
  	  	               			$(this).css("background-color", "white");
  	  	               	 	//console.log("마우스아웃 markers["+i+"] : ",markers[i]);
  	  	           		 	//마커 원래대로
  	  	           		 	markers[i].setMap(null);
  	  	           		 	var imageSize = new kakao.maps.Size(45, 50); //원래크기로
  	  	           		 	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
  	  	           		 	markers[i].setImage(markerImage);
  	  	           		 	markers[i].setMap(map);
  	  	        	    });
  	  	              	
	        	       	//리뷰 클릭 시 상세보기 모달창 띄우기
	  	  	            document.getElementsByClassName("reviewWrap"+reviewId)[0].addEventListener("click",function(){
	                        var userId = "${sessionScope.loginId}";
	                        console.log("userId / reviewId : "+userId+"/"+reviewId);
	                        
	                     	loadReviewDetail(reviewId, userId,"reviewMK");
	                     	$('#detailModal').modal("show");
	        	       	});
	  	  	            
    	               	})(reviewId, i); //즉시실행함수 : 여기있는 인수가 바로 들어가서 실행된다
    	               	
    	               	
                  })
               
                 
              },
              error:function(e){
                 console.log("에러발생 : ", e);
              }
           });
      } //end loadReviews()
      
      
      //클릭한 지역의 이름으로 중심좌표를 받아오기 위한 함수
      function centroid(name) {
         console.log('centroid name : ' + name);
         var centroids = {
            '오산시' : new kakao.maps.LatLng(37.1636128389639,
                  127.05518990396887),
            '화성시' : new kakao.maps.LatLng(37.168493, 126.841265),
            '평택시' : new kakao.maps.LatLng(37.008281, 126.995842),
            '안성시' : new kakao.maps.LatLng(37.036418285338,
                  127.31163550418967),
            '이천시' : new kakao.maps.LatLng(37.194796, 127.498984),
            '여주시' : new kakao.maps.LatLng(37.31013340253336,
                  127.62002734684562),
            '광주시' : new kakao.maps.LatLng(37.41199111803577,
                  127.30495011990648),
            '성남시 수정구' : new kakao.maps.LatLng(37.4339550640178,
                  127.11274158158241),
            '성남시 중원구' : new kakao.maps.LatLng(37.4339550640178,
                  127.11274158158241),
            '성남시 분당구' : new kakao.maps.LatLng(37.37226033286201,
                  127.10497215484288),
            '용인시 처인구' : new kakao.maps.LatLng(37.204791007297956,
                  127.25902175816543),
            '용인시 기흥구' : new kakao.maps.LatLng(37.26318902336213,
                  127.11591365849698),
            '용인시 수지구' : new kakao.maps.LatLng(37.33098226611915,
                  127.0713122103596),
            '수원시 권선구' : new kakao.maps.LatLng(37.26295579915725,
                  126.98033915258203),
            '수원시 팔달구' : new kakao.maps.LatLng(37.27845432258514,
                  127.01551540817815),
            '수원시 영통구' : new kakao.maps.LatLng(37.272604514228604,
                  127.05348793494832),
            '수원시 장안구' : new kakao.maps.LatLng(37.313055030637294,
                  127.00579838179321)
         };
         console.log('centroid 선택한 위치값 : ', centroids[name]);

         return centroids[name];
      }

      //행정구역 폴리곤 그려주기 + 각 폴리곤에 이벤트리스너 달기
      function displayArea(coordinates, name) {

         var path = []; //폴리곤 그려줄 path
         var points = []; //중심좌표 구하기 위한 지역구 좌표들

         $.each(coordinates[0], function(index, coordinate) {
            //console.log(foordinates)를 확인해보면 보면 [0]번째에 배열이 주로 저장이 됨. 그래서 [0]번째 배열에서 꺼내줌
            var point = new Object();
            point.x = coordinate[1]; //경도
            point.y = coordinate[0]; //위도
            points.push(point);
            path.push(new kakao.maps.LatLng(coordinate[1], coordinate[0]));
            //new kakao.maps.LatLng 가 없으면 인식을 못해서 path 배열에 추가 
         })

         //다각형을 생성합니다
         var polygon = new kakao.maps.Polygon({
            map : map, //다각형을 표시할 지도 객체
            path : path,
            strokeWeght : 2,
            strokeColor : '#004c80',
            strokeOpacity : 0.8,
            fillColor : '#fff',
            fillOpacity : 0.7
         });

         polygons.push(polygon); //폴리곤 제거하기 위한 배열

         //다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다.
         //지역명을 표시하는 커스텀 오버레이를 지도 위에 표시합니다.
         kakao.maps.event.addListener(polygon,'mouseover',function(mouseEvent) {
            polygon.setOptions({ //마우스오버된 폴리곤의 배경색 옵션 변경
                  fillColor : '#09f'
            });
            
         });
            
         /* //다각형에 mousemove 이벤트를 등록하고 이벤트 발생 시 커스텀 오버레이의 위치를 변경
         kakao.maps.event.addListener(polygon, 'mousemove', function(
               mouseEvent) {

            customOverlay.setPosition(mouseEvent.latLng);
         }); */
         
         //다각형에 mouseout 이벤트를 등록하고 이벤트 발생 시 폴리곤의 채움색을 원래대로 변경
         kakao.maps.event.addListener(polygon, 'mouseout', function() {
            polygon.setOptions({
               fillColor : '#fff'
            });
         });
         
         //다각형에 클릭 이벤트를 등록
         kakao.maps.event.addListener(polygon, 'click', function() {
            polygon.setOptions({
               fillColor : '#09f',
               strokeWeght : 4
            });
            customOverlay.setMap(null); //현재 존재하는 오버레이 삭제
            
            $.ajax({
               url:'getAreaInfo',
               type:'GET',
               data : {"areaName" : name},
               dataType:'JSON',
               success:function(data){
                  reviewCnt = data.reviewCnt;
                  areaRating = data.areaRating;
                  console.log("후기마커개수 : ", data.reviewCnt);
                  console.log("지역평점", data.areaRating);
                  
                  //커스텀 오버레이의 내용 설정
                  customOverlay.setContent('<div class="overlay">'
                     +'<div class="overlay_top"><span class="left">'
                     + name
                     + '</span><span class="right">등록된 후기 '+data.reviewCnt+'개</span></div>'
                     +'<div class="overlay_bot"><span>'
                     + '<img src="resources/img/heart.png" alt="오버레이이미지" width="40" height="40">'
                     + '</span><span><div class="gauge1" style="width:'+((data.areaRating/5)*100)+'px;"></div>'
                     + '<div class="gauge2" style="width:'+(100-((data.areaRating/5)*100))+'px;"></div></span></div>'
                     + '<div style="margin-left:70px;"><button onclick="selectArea(\''+name+'\',\'default\')" class="btn btn-sm btn-outline-dark mx-1 me-1">선택하기</button></div>'
                     +'</div>');
                  customOverlay.setPosition(centroid(name));
                  customOverlay.setMap(map);               
               },
               error:function(e){
                  console.log("에러발생 : ", e);
               }               
            }); //end ajax()
            
         }); //end 클릭이벤트리스너
         
         /*  
         //centroid 알고리즘 (폴리곤 중심좌표 구하기 위함)
            function centroid (point) {
                var i, j, len, p1, p2, f, area, x, y;
             
                area = x = y = 0;
                for (i = 0, len = point.length, j = len - 1; i < len; j = i++) {
                        p1 = point[i];
                        p2 = point[j];
                        f = p1[1] * p2[0] - p2[1] * p1[0];
                        x += (p1[0] + p2[0]) * f;
                        y += (p1[1] + p2[1]) * f;
                        area += f * 3;
                }
              
                return new kakao.maps.LatLng(x / area, y / area);
            }
          */

         
         
      } //end display
      
      
      function deletePolygon(polygons) {
         for (var i = 0; i < polygons.length; i++) {
            polygons[i].setMap(null);
         }
         polygons = [];
      }
      
      function searchAddrFromCoords(coords, callback) {
          // 좌표로 행정동 주소 정보를 요청합니다
          geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
      }

      function searchDetailAddrFromCoords(coords, callback) {
          // 좌표로 법정동 상세 주소 정보를 요청합니다
          geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
      }
      
      //후기 작성 버튼을 눌렀을 때
      function reviewWrite(detailAddr, rmLat, rmLng){
         console.log("주소 : "+detailAddr);
         $("#reviewModalLabel").html(detailAddr);
         $("#rmLat").val(rmLat);
         $("#rmLng").val(rmLng);
      }
      
      function setMapLevel(){
         map.setMinLevel(3);
         map.setMaxLevel(10);
      }
      
         const file = $("#rmPhoto")[0];
      
    //리뷰마커 작성하고 등록 버튼 눌렀을 때
      $("#rmSubmit").click(function(){
          
          var rmLat = $("#rmLat").val();
          var rmLng = $("#rmLng").val();
          var rmDetailAddr = $("#reviewModalLabel").html();
          var content = $("#content").val();
          var rating = $("#rating option:selected").val();
          var rmLoginId = $("#rmLoginId").val();
          var rmLoginNickName = $("#rmLoginNickName").val();
          
          if(file.files.length === 0){
               alert("이미지를 첨부하고 등록해주세요.");
               return;
             }
          
          if(content.length == 0){
        	  alert("내용을 입력해주세요!");
        	  return;
          }
          
          if(content.length < 10){
        	  alert("10자 이상 입력해주세요!");
        	  return;
          }
          
          var areaId;
          var areaName = "";
          
          if(rmDetailAddr.indexOf('화성시') != -1){
        	  areaId = 1;
        	  areaName = '화성시';
          }else if(rmDetailAddr.indexOf('오산시') != -1){
        	  areaId = 2;
        	  areaName = '오산시';
          }else if(rmDetailAddr.indexOf('평택시') != -1){
        	  areaId = 3;
        	  areaName = '평택시';
          }else if(rmDetailAddr.indexOf('안성시') != -1){
        	  areaId = 4;
        	  areaName = '안성시';
          }else if(rmDetailAddr.indexOf('이천시') != -1){
        	  areaId = 5;
        	  areaName = '이천시';
          }else if(rmDetailAddr.indexOf('여주시') != -1){
        	  areaId = 6;
        	  areaName = '여주시';
          }else if(rmDetailAddr.indexOf('광주시') != -1){
        	  areaId = 7;
        	  areaName = '광주시';
          }else if(rmDetailAddr.indexOf('성남시 수정구') != -1){
        	  areaId = 8;
        	  areaName = '성남시 수정구';
          }else if(rmDetailAddr.indexOf('성남시 중원구') != -1){
        	  areaId = 9;
        	  areaName = '성남시 중원구';
          }else if(rmDetailAddr.indexOf('성남시 분당구') != -1){
        	  areaId = 10;
        	  areaName = '성남시 분당구';
          }else if(rmDetailAddr.indexOf('용인시 처인구') != -1){
        	  areaId = 11;
        	  areaName = '용인시 처인구';
          }else if(rmDetailAddr.indexOf('용인시 기흥구') != -1){
        	  areaId = 12;
        	  areaName = '용인시 기흥구';
          }else if(rmDetailAddr.indexOf('용인시 수지구') != -1){
        	  areaId = 13;
        	  areaName = '용인시 수지구';
          }else if(rmDetailAddr.indexOf('수원시 권선구') != -1){
        	  areaId = 14;
        	  areaName = '수원시 권선구';
          }else if(rmDetailAddr.indexOf('수원시 팔달구') != -1){
        	  areaId = 15;
        	  areaName = '수원시 팔달구';
          }else if(rmDetailAddr.indexOf('수원시 영통구') != -1){
        	  areaId = 16;
        	  areaName = '수원시 영통구';
          }else if(rmDetailAddr.indexOf('수원시 장안구') != -1){
        	  areaId = 17;
        	  areaName = '수원시 장안구';
          }else{
        	  alert("지역을 확인해주세요!");
        	  return;
          }
          
          console.log("rmLat : "+rmLat);
            console.log("rmLng : "+rmLng);
            console.log("rmDetailAddr : "+rmDetailAddr);
            console.log("content : "+content);
            console.log("rating : "+rating);
            console.log("로그인아이디: "+rmLoginId);
            console.log("로그인닉네임: "+rmLoginNickName);
            
            
            console.log("file : "+file.files[0].name);
            console.log("file : "+file.files[0].value);
            console.log("file : "+file.files[0].size);
            
            const formData = new FormData();
            formData.append("file", file.files[0]);
            
           
          $.ajax({
                url:'rmWrite',
               type:'POST',
               data : {
                  "lat" : rmLat,
                  "lon" : rmLng,
                  "address" : rmDetailAddr,
                  "reviewContent" : content,
                  "rating" : rating,
                  "areaId" : areaId,
                  "userId" : rmLoginId,
                  "nickName" : rmLoginNickName
                  },
               dataType:'JSON',
               success:function(data){
               
            	   console.log("작성된 글 아이디 : "+data.reviewId);
                   formData.append("reviewId", data.reviewId);
                  
                  $.ajax({
                        url:'rmFileUpload',
                       type:'POST',
                       processData: false,
                       contentType: false,
                       data : formData,
                       dataType:'JSON',
                       success:function(data){
                          console.log(data);
                          alert("등록이 완료되었습니다!");
                          loadReviews(areaName, 'default');
                          infowindow.close();
                       },
                       error:function(e){
                           console.log("에러발생 : ", e);
                           alert("등록에 실패하였습니다!");
                        }  
                  }); // end ajax  
               },
               error:function(e){
                   console.log("에러발생 : ", e);
                   alert("등록에 실패하였습니다!");
                }  
          }); // end ajax */
          
       $("#closeBtn").click();
       })
       
       //모달창이 hidden일때 내용 초기화
       $('.modal').on('hidden.bs.modal', function (e) {
    		console.log('modal close');
    		$("#content").val("");
    		$("#rmPhoto").val("");
		});
      
      
      function deleteMarkers(markers) {
         for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(null);
         }
         markers = [];
      }
      
      //내후기마커 불러오기
      function loadMyReviews(userId){
    	  deleteMarkers(markers); //현재 지도에 띄워져있는 마커가 있으면 모두 제거한다.
    	  reviewIds = []; //reviewIds 초기화
    	  
    	  $.ajax({
              url:'getMyReviewList',
              type:'GET',
              data : {
                 "userId" : userId 
              },
              dataType:'JSON',
              success:function(data){
                 console.log("내 후기마커 data : ", data);
                 console.log("내 후기마커 list : ", data.list);
                 console.log("내 후기마커 list[0] : ", data.list[0]);
                 
                 var content = "";
                 var list = data.list;
                 if(list.length > 0){
                	 $("#myRevComment").hide(); //등록된 리뷰가 없다는 문구 제거
                 }
                 
                 list.forEach(function(review, index){
                    //console.log("내 후기마커"+index+"번째 : ", review);
                    
                    //평점(구름아이콘)
                    var rating = "";
                    for(var i=0; i<review.rating; i++){
                       rating +="<img src='resources/img/cloud.png' class='revRatingImg'>";
                    }
                   	
                    var element = "<li class='list-group-item'>"
                    +"<a href=# class='reviewAnchor'>"
                    +"<div class='reviewWrap"+review.reviewId+"'>"
                    //+"<div> 후기마커 번호 : "+review.reviewId+"</div>"
                    +"<div class='revBox1'>"
                    +"<img class='reviewThumb' src='/photo/"+review.newFileName+"'/>"
                    +"<div class='revBox1_1'>"
                    +"<div class='revNickName'>"+review.nickName+"</div>"
                    +"<div calss='revAddress'>"+review.address+"</div>"
                    +"</div>"
                    +"</div>"
                    +"<div class='invisibleBox'></div>"
                    +"<div class='revBox2'>"
                    +"<div class='revRating'>"+rating+"</div>"
                    +"<div class='revBox2_1'>"
                    +"<div class='revBox2_2'>"
                    +"<div calss='revCmtCnt'><img src='resources/img/comment.png' width='18px' height='18px'> 댓글 "+review.commentCnt+"</div>"
                    +"<div calss='revLikeCnt'><img src='resources/img/like1_full.png' width='18px' height='18px'> 좋아요 "+review.likeCnt+"</div>"
                    +"</div>"; //end revBox2_2

                    /*
                    if(review.isLike > 0){
                       element += "<div calss='revIsLike'>"+"♥"+"좋아요 : "+review.likeCnt+" 개</div>"; 
                    }else{
                       element += "<div calss='revIsLike'>"+"♡"+"</div>";
                    }
                    */
                    
                    if(review.isBookMark > 0){
                        element += "<div class='revIsBookMark'><img src='resources/img/star.png' class='revBookMarkImg'></div>";
                     }else{
                        element += "<div class='revIsBookMark'><img src='resources/img/star2.png' class='revBookMarkImg'></div>";
                     }
                    element += "</div></div>"; //end .revBox2_1, .revBox2
                    element += "</div></a></li><hr/>";
                    content += element;
                    
                  //지도에 후기마커 생성
                    var imageSrc = "resources/img/marker1.png";
                    var imageSize = new kakao.maps.Size(45, 50);
                    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                    
                    var revMarker = new kakao.maps.Marker({
                       map : map,
                       position: new kakao.maps.LatLng(review.lat, review.lon),
                       image : markerImage
                    });
                    
                    
                    //클릭 시 후기마커 상세보기 모달창 열기
                    kakao.maps.event.addListener(revMarker, 'click', function(e) {
                        var userId = "${sessionScope.loginId}";
                        var reviewId = review.reviewId;
                        console.log("userId / reviewId : "+userId+"/"+reviewId);
                        
                     	loadReviewDetail(reviewId, userId, "myReviewMK");
                     	$('#detailModal').modal("show");
                     });
                    
                    kakao.maps.event.addListener(revMarker, 'mouseover', function() {
                         //마커 하이라이트
                         imageSize = new kakao.maps.Size(52, 57); //1.5배 크기로
                         markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                         revMarker.setImage(markerImage);
                         revMarker.setMap(map);
                         
                         //리스트 하이라이트
                         $('.reviewWrap'+review.reviewId).css("background-color", "aliceblue");
                         $('.reviewWrap'+review.reviewId).css("color", "skyblue");
                         $('.reviewWrap'+review.reviewId)[0].scrollIntoView({behavior: "smooth", block: "center"});
                     });
                    
                    kakao.maps.event.addListener(revMarker, 'mouseout', function() {
                         
                         //마커 원래대로
                         imageSize = new kakao.maps.Size(45, 50); //원래 크기로
                         markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                         revMarker.setImage(markerImage);
                         revMarker.setMap(map);
                         
                          //리스트 원래대로
                         $('.reviewWrap'+review.reviewId).css("background-color", "white");
                         $('.reviewWrap'+review.reviewId).css("color", "black");
                     });
					
                    
                    markers.push(revMarker); //마커배열에 이 마커 추가
                  
    				reviewIds.push(review.reviewId); //reviewIds배열에 reviewId저장 //마커스의 인덱스와 같이 감
                    
                    
                 }) //end forEach()
                 
                 $("#reviewUl_my").empty();
                 $("#reviewUl_my").append(content);
                 
                 
                 
                //마우스오버된 후기 하이라이트
              	reviewIds.forEach(function(reviewId, i){
    	             	//각각의 reviewId와 index i를 받아옴
    	               	
    	               	var imageSrc = "resources/img/marker1.png";
    	               	
    	               	(function(reviewId, i){
  	  	              		document.getElementsByClassName("reviewWrap"+reviewId)[0].addEventListener("mouseover",function(){
    		               		$(this).css("background-color", "aliceblue");
    	        	       		//console.log("마우스오버 markers["+i+"] : ",markers[i]);
  		       			  	//마커 하이라이트
  		       			  	markers[i].setMap(null);
  		       		  		var imageSize = new kakao.maps.Size(55, 60); //1.5배 크기로
  			       		  	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
  			       		 	markers[i].setImage(markerImage);
  			       			markers[i].setMap(map);
    	        	       	});
    	               	
  	  	              		document.getElementsByClassName("reviewWrap"+reviewId)[0].addEventListener("mouseout",function(e){
  	  	               			$(this).css("background-color", "white");
  	  	               	 	//console.log("마우스아웃 markers["+i+"] : ",markers[i]);
  	  	           		 	//마커 원래대로
  	  	           		 	markers[i].setMap(null);
  	  	           		 	var imageSize = new kakao.maps.Size(45, 50); //원래크기로
  	  	           		 	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
  	  	           		 	markers[i].setImage(markerImage);
  	  	           		 	markers[i].setMap(map);
  	  	        	    });
  	  	              	
	        	       	//리뷰 클릭 시 상세보기 모달창 띄우기
	  	  	            document.getElementsByClassName("reviewWrap"+reviewId)[0].addEventListener("click",function(){
	                        var userId = "${sessionScope.loginId}";
	                        console.log("userId / reviewId : "+userId+"/"+reviewId);
	                        
	                     	loadReviewDetail(reviewId, userId, "myReviewMK");
	                     	$('#detailModal').modal("show");
	        	       	});
	  	  	            
    	               	})(reviewId, i); //즉시실행함수 : 여기있는 인수가 바로 들어가서 실행된다
    	               	
    	               	
                  })
               
                 
              },
              error:function(e){
                 console.log("에러발생 : ", e);
              }
           });
    	  
      } //end loadMyReviews()
      
      //즐겨찾기한 후기마커 리스트 불러오기
      function loadBookMarks(userId){
    	  deleteMarkers(markers); //현재 지도에 띄워져있는 마커가 있으면 모두 제거한다.
    	  reviewIds = []; //reviewIds 초기화
    	  
    	  $.ajax({
              url:'getBookMarkList',
              type:'GET',
              data : {
                 "userId" : userId 
              },
              dataType:'JSON',
              success:function(data){
                 console.log("즐겨찾기 data : ", data);
                 console.log("즐겨찾기 list : ", data.list);
                 console.log("즐겨찾기 list[0] : ", data.list[0]);
                 
                 var content = "";
                 var list = data.list;
                 if(list.length > 0){
                	 $("#bookmarkComment").hide(); //등록된 즐겨찾기가 없다는 문구 제거
                 }
                 
                 list.forEach(function(review, index){
                    //console.log("내 후기마커"+index+"번째 : ", review);
                    
                    //평점(구름아이콘)
                    var rating = "";
                    for(var i=0; i<review.rating; i++){
                       rating +="<img src='resources/img/cloud.png' class='revRatingImg'>";
                    }
                   	
                    var element = "<li class='list-group-item'>"
                    +"<a href=# class='reviewAnchor'>"
                    +"<div class='reviewWrap"+review.reviewId+"'>"
                    //+"<div> 후기마커 번호 : "+review.reviewId+"</div>"
                    +"<div class='revBox1'>"
                    +"<img class='reviewThumb' src='/photo/"+review.newFileName+"'/>"
                    +"<div class='revBox1_1'>"
                    +"<div class='revNickName'>"+review.nickName+"</div>"
                    +"<div calss='revAddress'>"+review.address+"</div>"
                    +"</div>"
                    +"</div>"
                    +"<div class='invisibleBox'></div>"
                    +"<div class='revBox2'>"
                    +"<div class='revRating'>"+rating+"</div>"
                    +"<div class='revBox2_1'>"
                    +"<div class='revBox2_2'>"
                    +"<div calss='revCmtCnt'><img src='resources/img/comment.png' width='18px' height='18px'> 댓글 "+review.commentCnt+"</div>"
                    +"<div calss='revLikeCnt'><img src='resources/img/like1_full.png' width='18px' height='18px'> 좋아요 "+review.likeCnt+"</div>"
                    +"</div>"; //end revBox2_2

                    /*
                    if(review.isLike > 0){
                       element += "<div calss='revIsLike'>"+"♥"+"좋아요 : "+review.likeCnt+" 개</div>"; 
                    }else{
                       element += "<div calss='revIsLike'>"+"♡"+"</div>";
                    }
                    */
                    
                    if(review.isBookMark > 0){
                        element += "<div class='revIsBookMark'><img src='resources/img/star.png' class='revBookMarkImg'></div>";
                     }else{
                        element += "<div class='revIsBookMark'><img src='resources/img/star2.png' class='revBookMarkImg'></div>";
                     }
                    element += "</div></div>"; //end .revBox2_1, .revBox2
                    element += "</div></a></li><hr/>";
                    content += element;
                    
                  //지도에 후기마커 생성
                    var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
                    var imageSize = new kakao.maps.Size(24, 35);
                    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                    
                    var revMarker = new kakao.maps.Marker({
                       map : map,
                       position: new kakao.maps.LatLng(review.lat, review.lon),
                       image : markerImage
                    });
                    
                    
                    //클릭 시 후기마커 상세보기 모달창 열기
                    kakao.maps.event.addListener(revMarker, 'click', function(e) {
                        var userId = "${sessionScope.loginId}";
                        var reviewId = review.reviewId;
                        console.log("userId / reviewId : "+userId+"/"+reviewId);
                        
                     	loadReviewDetail(reviewId, userId, "bookmark");
                     	$('#detailModal').modal("show");
                     });
                    
                    kakao.maps.event.addListener(revMarker, 'mouseover', function() {
                         //마커 하이라이트
                         imageSize = new kakao.maps.Size(34, 45); //1.5배 크기로
                         markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                         revMarker.setImage(markerImage);
                         revMarker.setMap(map);
                         
                         //리스트 하이라이트
                         $('.reviewWrap'+review.reviewId).css("background-color", "aliceblue");
                         $('.reviewWrap'+review.reviewId).css("color", "skyblue");
                         $('.reviewWrap'+review.reviewId)[0].scrollIntoView({behavior: "smooth", block: "center"});
                     });
                    
                    kakao.maps.event.addListener(revMarker, 'mouseout', function() {
                         
                         //마커 원래대로
                         imageSize = new kakao.maps.Size(24, 35); //원래 크기로
                         markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
                         revMarker.setImage(markerImage);
                         revMarker.setMap(map);
                         
                          //리스트 원래대로
                         $('.reviewWrap'+review.reviewId).css("background-color", "white");
                         $('.reviewWrap'+review.reviewId).css("color", "black");
                     });
					
                    
                    markers.push(revMarker); //마커배열에 이 마커 추가
                  
    				reviewIds.push(review.reviewId); //reviewIds배열에 reviewId저장 //마커스의 인덱스와 같이 감
                    
                    
                 }) //end forEach()
                 
                 $("#bookmarkUl").empty();
                 $("#bookmarkUl").append(content);
                 
                 
                 
                //마우스오버된 후기 하이라이트
              	reviewIds.forEach(function(reviewId, i){
    	             	//각각의 reviewId와 index i를 받아옴
    	               	
    	               	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
    	               	
    	               	(function(reviewId, i){
  	  	              		document.getElementsByClassName("reviewWrap"+reviewId)[0].addEventListener("mouseover",function(){
    		               		$(this).css("background-color", "aliceblue");
    	        	       		//console.log("마우스오버 markers["+i+"] : ",markers[i]);
  		       			  	//마커 하이라이트
  		       			  	markers[i].setMap(null);
  		       		  		var imageSize = new kakao.maps.Size(34, 45); //1.5배 크기로
  			       		  	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
  			       		 	markers[i].setImage(markerImage);
  			       			markers[i].setMap(map);
    	        	       	});
    	               	
  	  	              		document.getElementsByClassName("reviewWrap"+reviewId)[0].addEventListener("mouseout",function(e){
  	  	               			$(this).css("background-color", "white");
  	  	               	 	//console.log("마우스아웃 markers["+i+"] : ",markers[i]);
  	  	           		 	//마커 원래대로
  	  	           		 	markers[i].setMap(null);
  	  	           		 	var imageSize = new kakao.maps.Size(24, 35); //원래크기로
  	  	           		 	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
  	  	           		 	markers[i].setImage(markerImage);
  	  	           		 	markers[i].setMap(map);
  	  	        	    });
  	  	              	
	        	       	//리뷰 클릭 시 상세보기 모달창 띄우기
	  	  	            document.getElementsByClassName("reviewWrap"+reviewId)[0].addEventListener("click",function(){
	                        var userId = "${sessionScope.loginId}";
	                        console.log("userId / reviewId : "+userId+"/"+reviewId);
	                        
	                     	loadReviewDetail(reviewId, userId, "bookmark");
	                     	$('#detailModal').modal("show");
	        	       	});
	  	  	            
    	               	})(reviewId, i); //즉시실행함수 : 여기있는 인수가 바로 들어가서 실행된다
    	               	
    	               	
                  })
               
                 
              },
              error:function(e){
                 console.log("에러발생 : ", e);
              }
           });
      } //end loadBookMarks()
      //주석
</script>
</html>