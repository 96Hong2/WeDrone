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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 부트스트랩 파일 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous">
	
</script>
<link href="${path}/resources/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css"
	integrity="sha384-wESLQ85D6gbsF459vf1CiZ2+rr+CsxRY0RpiF1tLlQpDnAgg6rwdsUF1+Ics2bni"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<link href="/Project2/assets/css/main.css?ver=95" rel="stylesheet">
<style>
/* 푸터 위의 내용 감싸서 내용 없어도 푸터 하단으로 가도록 */
.wrap {
	text-align: center;
	display: flex;
	flex-direction: column;
	height: 100%
}

footer {
	width: 100%;
	height: 80px;
	background-color: #3c3c3c;;
	margin-top: auto
}

.overlay {
	margin-bottom: 60px;
	background-color: rgba(248, 210, 221, 0.5);
	padding : 10px;
}

.overlay .left{
	font-size: 18px;
	font-weight: 900;
	display: flex;
	justify-content: left;
}

.overlay .right{
	font-size: 12px;
	display: flex;
	justify-content: right;
}

.overlay * {
	vertical-align: center;
}

.gauge1{
	width:40px;
	height:10px;
	background-color: pink;
	display:inline-block;"
}

.gauge2{
	width:50px;
	height:10px;
	background-color: #ccc;
	display:inline-block;"
}

#reloadBtn{
	position: absolute;
	top:80px;
	right:20px;
}

/* .overlay .center {background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 50px;font-size: 12px;line-height: 50px;}
.overlay .left {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 50px;overflow: hidden;vertical-align: center;width: 7px;}
.overlay .right {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 50px;overflow: hidden;vertical-align: center;width: 6px;} */

</style>
</head>
<title>드론</title>
<body>

	<!-- 네비게이션바 -->
	<nav class="navbar navbar-expand-lg navbar-dark"
		style="background-color: #3c3c3c;">
		<div class="container-fluid">
			<a class="fs-3 text-center navbar-brand fw-bold text-color: #003399;"
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
					<li class="nav-item"><a class="nav-link active text-center"
						aria-current="page" href="${path}/map">Map</a></li>
					<li class="nav-item"><a class="nav-link active text-center "
						href="${path}/calendar">Calendar</a></li>
					<a class="nav-link active" href="${path}/news">News</a>
					</li>
					<li class="nav-item"><a class="nav-link active text-center "
						href="${path}/notice">Notice</a></li>
					<li class="nav-item"><a class="nav-link active text-center "
						href="${path}/board">Board</a></li>


					<li class="nav-item"></li>
				</ul>
				<div class="d-flex" id="alarmalert"
					onclick="location.href='/webapp/WEB-INF/views/alarm.jsp'">
					<i id="bell" class="bi bi-bell-fill"
						style="font-size: 1.8rem; color: white"></i>23<span
						id="cartalertnum"
						class="border border-dark position-absolute top-0 mx-3 badge bg-white text-white rounded-pill mt-2"></span>
				</div>
				<div class="d-flex">
					<button class="btn btn-sm btn-outline-light mx-1 me-1">로그인</button>
					<button class="btn btn-sm btn-outline-light mx-1" type="submit">회원가입</button>
					<a class="btn btn-sm btn-outline-light  mx-1" role="button"
						href="${path}/mypage">마이페이지</a>
					<button class="btn btn-sm btn-outline-light mx-1 " type="button"
						data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight"
						aria-controls="offcanvasRight">기타</button>
				</div>
			</div>
	</nav>


	<!-- 들어갈 내용 -->

	<h4>Map - 지도 - 후기마커 보기</h4>
	<button type="button" onclick="location.reload(true)" class="btn btn-sm btn-outline-dark mx-1 me-1" id="reloadBtn">전체지역보기</button>
	<!-- 지도를 표시할 div 입니다 -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=96f67dd6c088728e30743d7db32a6789"></script>
	<div id="map" style="width: 100%; height: 600px;"></div>

	<script>
		
		//#카카오맵 api 불러오기
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.23158045033799, 126.8253682729277), // 지도의 중심좌표
			level : 10
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
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
		

		var polygons = [];
		//function 안 쪽에 지역변수로 넣으니까 폴리곤 하나 생성할 때마다 배열이 비어서 클릭했을대 전체를 못 없애줌. 그래서 전역변수로 만듦.

		//행정구역 폴리곤
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

			//커스텀 오버레이 변수 설정
			var customOverlay = new kakao.maps.CustomOverlay();			

			//다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다.
			//지역명을 표시하는 커스텀 오버레이를 지도 위에 표시합니다.
			kakao.maps.event.addListener(polygon,'mouseover',function(mouseEvent) {
				polygon.setOptions({ //마우스오버된 폴리곤의 배경색 옵션 변경
									fillColor : '#09f'
				});
				
				var reviewCnt = 0;
				var areaRating = 0.0;
				$.ajax({
					url:'getAreaInfo',
					type:'GET',
					data:{'areaName' : '광주시'},
					dataType:'JSON',
					success:function(data){
						console.log("후기마커개수 : ", data.reviewCnt);
						console.log("지역평점", data.areaRating);
						reviewCnt = data.reviewCnt;
						areaRating = data.areaRating;
					},
					error:function(e){
						console.log("에러발생 : ", e);
					}
				});	
				console.log(data.reviewCnt);
				console.log(data.areaRating);
				
								
				//커스텀 오버레이의 내용 설정
				customOverlay.setContent('<div class="overlay">'
					+'<div class="overlay_top"><span class="left">'
					+ name
					+ '</span><span class="right">등록된 후기 '+reviewCnt+'개</span></div>'
					+'<div class="overlay_bot"><span>'
					+ '<img src="resources/img/heart.png" alt="오버레이이미지" width="40" height="40">'
					+ '</span><span><div class="gauge1"></div><div class="gauge2"></div></span></div>'
					+'</div>');
					customOverlay.setPosition(mouseEvent.latLng);
					customOverlay.setMap(map);
			});

			//다각형에 mousemove 이벤트를 등록하고 이벤트 발생 시 커스텀 오버레이의 위치를 변경
			kakao.maps.event.addListener(polygon, 'mousemove', function(
					mouseEvent) {

				customOverlay.setPosition(mouseEvent.latLng);
			});

			//다각형에 mouseout 이벤트를 등록하고 이벤트 발생 시 폴리곤의 채움색을 원래대로 변경
			//커스텀 오버레이를 지도에서 제거
			kakao.maps.event.addListener(polygon, 'mouseout', function() {
				polygon.setOptions({
					fillColor : '#fff'
				});
				customOverlay.setMap(null);
			});

			//다각형에 클릭 이벤트를 등록하고 이벤트가 발생하면 해당 지역을 확대합니다.
			kakao.maps.event.addListener(polygon, 'click', function() {

				//현재 지도 레벨에서 2레벨 확대한 레벨
				var level = map.getLevel() - 2;

				//지도를 클릭된 폴리곤의 중앙 위치를 기준으로 확대합니다.
				map.setLevel(level, {
					anchor : centroid(name),
					animate : {
						duration : 350
					//확대 애니메이션 시간
					}
				});

				deletePolygon(polygons); //폴리곤 제거 
			});

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

			//클릭한 지역의 이름으로 중심좌표를 받아오기 위한 함수
			function centroid(name) {
				console.log('name : ' + name);
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
					'용인시처인구' : new kakao.maps.LatLng(37.204791007297956,
							127.25902175816543),
					'용인시기흥구' : new kakao.maps.LatLng(37.26318902336213,
							127.11591365849698),
					'용인시수지구' : new kakao.maps.LatLng(37.33098226611915,
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
				console.log('선택한 위치값 : ', centroids[name]);

				return centroids[name];
			}

			function deletePolygon(polygons) {
				for (var i = 0; i < polygons.length; i++) {
					polygons[i].setMap(null);
				}
				polygons = [];
			}
			
			
		} //end display
	</script>
	</div>
</body>
</html>