<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<%-- 부트 스트랩 메타태그 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%-- 부트 스트랩 아이콘 --%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<!-- 부트스트랩 css 추가 -->
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<%-- 공통 css --%>
<link href="${path}/resources/css/common.css?var=3" rel="stylesheet">

</head>
<title>드론</title>
<body>
<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="fixmenu/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="fixmenu/lognav.jsp" />
	</c:if>

<!-- 들어갈 내용 -->
<h3>실시간 날씨정보 띄우기</h3>
<div id="addressInfo"></div>
<div id="locationInfo"></div>



 

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <script type="text/javascript"
         src="//dapi.kakao.com/v2/maps/sdk.js?appkey=96f67dd6c088728e30743d7db32a6789&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c4f184a0580dc27199cd4d05a181a688"></script>
<script src="${path}/resources/js/js.js"></script>
<script src="${path}/resources/js/common.js"></script>
</body>

<script>
//실시간 정보 위젯
//	var myLoc = new kakao.maps.Marker({	
//	position : new kakao.maps.LatLng(37.21953563998351, 127.21194259376661)
//});
	
	callMyLocation();
 	
    //현재 위치를 불러오는 메소드
    //현재위치에 마커를 찍고 해당 마커를 중심으로 지도를 이동시킨다.
    function callMyLocation(){
		// HTML5의 geolocation으로 사용할 수 있는지 확인
		if (navigator.geolocation) {
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat = position.coords.latitude,
		              lon = position.coords.longitude;
		        var latlng = kakao.maps.LatLng();
		        
		      //현재 위치 주소 받아오기
		        searchDetailAddrFromCoords(lat, lon, function(result, status) {
		            if (status === kakao.maps.services.Status.OK) {
		                var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
		                detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
		            	console.log("detailAddr : "+detailAddr);
		                
		                $("#addressInfo").append(detailAddr);
		                
		                var addressInfo = result[0].address.address_name;
		                console.log("상세주소 : ", addressInfo);
		                
		            }
		        });
		      
		        weather(lat, lon);
		        
		      });
		} else {//못 불러오면
			//경기도 임의의 중심점을 중심으로 마커 찍기
		    var locPosition = new kakao.maps.LatLng(37.21953563998351, 127.21194259376661);
	        var lat = locPosition.getLat(),
	        lon = locPosition.getLng();
	        
			weather(lat, lon);
	         
		}
    }
    
    var geocoder = new kakao.maps.services.Geocoder();
    
    function searchDetailAddrFromCoords(lat, lon, callback) {
        // 좌표로 법정동 상세 주소 정보를 요청합니다
        geocoder.coord2Address(lon, lat, callback);
    }
      
    //일출, 일몰 시간 변환
  	function unix_timestamp(t) {
  		var date = new Date(t*1000);
  		var hour = "0" + date.getHours();
  		var minute = "0" + date.getMinutes();
  		return hour.substr(-2) + ":" + minute.substr(-2);
  	}

  	// 풍향 변환
  	function windDirection(deg) {
  		 var result = Math.round((deg + 22.5 * 0.5) / 22.5);
  		 var vector;
  		 switch(result) {
  		 case 0 :
  			 vector = "북";
  			 break;
  			 
  		 case 1 :
  			 vector = "북북동";
  			 break;
  			 
  		 case 2 :
  			 vector = "북동";
  			 break;
  			 
  		 case 3 :
  			 vector = "동북동";
  			 break;
  			 
  		 case 4 :
  			 vector = "동";
  			 break;
  			 
  		 case 5 :
  			 vector = "동남동";
  			 break;
  			 
  		 case 6 :
  			 vector = "남동";
  			 break;
  			 
  		 case 7 :
  			 vector = "남남동";
  			 break;
  			 
  		 case 8 :
  			 vector = "남";
  			 break;
  			 
  		 case 9 :
  			 vector = "남남서";
  			 break;
  			 
  		 case 10 :
  			 vector = "남서";
  			 break;
  			 
  		 case 11 :
  			 vector = "서남서";
  			 break;
  			 
  		 case 12 :
  			 vector = "서";
  			 break;
  			 
  		 case 13 :
  			 vector = "서북서";
  			 break;
  			 
  		 case 14 :
  			 vector = "북서";
  			 break;
  			 
  		 case 15 :
  			 vector = "북북서";
  			 break;
  			 
  		 case 16 :
  			 vector = "북";
  			 break;
  		 }
  		return vector;
  	}
  	

 	//기상정보 불러오기 (ApiService랑 연동)
  	function weather(lat, lon) {
 		console.log("lat/lon : "+lat+"/"+lon);
  		$.ajax({
  			
  		     url:'apiCall',
  		     type:'post',
  		     data:{
  		         "lon" : lon,
  		         "lat" : lat
  		     },
  		     dataType:'json',
  		     success:function(data){
  		    	 console.log("성공 :: " , data);
  		    	 var message = "";
  		    	 //message += "현재위, 경도 : " + data.coord.lat + ", " + data.coord.lon + "<br>";
  		    	 message += "현재온도  &nbsp;"+ data.main.temp  + "°C" + "<br>";
  		    	 message += "체감온도  &nbsp;" + data.main.feels_like + "°C" + "<br>";
  		    	 message += "현재습도  &nbsp;"+ data.main.humidity + "%" + "<br>";
  		    	 message += "날씨  &nbsp;"+ data.weather[0].main + "<br>";
  		    	// message += "날씨 이미지 : "+ data.weather[0].icon + "<br>";
  		    	 message += "풍속  &nbsp;" + data.wind.speed + "m/s" + "<br>";
  		    	 message += "풍향  &nbsp;" + windDirection(data.wind.deg) + "<br>";
  		    	 message += "구름   &nbsp;"+ data.clouds.all +"%"  + "<br>";  
  		    	 message += "일출  &nbsp;" + unix_timestamp(data.sys.sunrise) + "<br>";
  		    	 message += "일몰  &nbsp;" + unix_timestamp(data.sys.sunset) + "<br>";
  		    	 
  		    	 var resultDiv = document.getElementById('locationInfo'); 
  		    	 resultDiv.innerHTML = message;
  		     },
  		     error:function(e){
  		         console.log("에러 e : ",e);
  		     }
  		 });
  	}
  	
  

</script>
</html>
