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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/js.js"></script>
<script src="${path}/resources/js/common.js"></script>
<!-- API script -->
<script
	src="http://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=48073EB2-97FF-3571-8683-EEFD0567901F"></script>
</head>
<title>드론</title>
<c:if test="${sessionScope.loginId eq null}">
	<jsp:include page="../fixmenu/navbar.jsp" />
</c:if>
<c:if test="${sessionScope.loginId ne null}">
	<jsp:include page="../fixmenu/lognav.jsp" />
</c:if>

<nav
	style="-bs-breadcrumb-divider: url(&amp; #34; data: image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&amp;#34;);"
	aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item fs-4"><a href="${path}/">Home</a></li>
		<li class="breadcrumb-item active fs-4" aria-current="page">Map >
			비행지역 조회</li>
	</ol>
</nav>
<body>

	<div id="map" style="width: 80%;"></div>

	<div style="border: 1px solid black; float: left; width: 224px;">
		<input type="checkbox" class="chkAir" name="chkBox"
			value="lt_c_aisprhc" checked />비행금지구역 <input type="checkbox"
			class="chkAir" name="chkBox" value="lt_c_aisctrc" checked />관제권 <input
			type="checkbox" class="chkAir" name="chkBox" value="lt_c_aisresc" />비행제한구역
		<input type="checkbox" class="chkAir" name="chkBox"
			value="lt_c_aisdngc" />위험구역 <input type="checkbox" class="chkAir"
			name="chkBox" value="lt_c_aismoac" />군작전구역 <input type="checkbox"
			class="chkAir" name="chkBox" value="lt_c_aisatzc" />비행장교통구역 <input
			type="checkbox" class="chkAir" name="chkBox" value="lt_c_aisuac"
			checked />초경량비행장치공역
		<!-- 시범구역은 안보임..... -->
		<!-- <input type="checkbox" class="chkAir" name="chkBox" value="lt_c_aisfldc" />경량항공기이착륙장 -->
	</div>

	<div style="border: 1px solid RED; float: left; width: 224px;">
		<div>
			<span>범례</span>
			<div id="wms_image"></div>
		</div>
	</div>
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
<%@ include file="../common/footer.jsp" %>		
</body>


	<script>
		var apiKey = "48073EB2-97FF-3571-8683-EEFD0567901F"; // http://192.168.4.229:8090/map/
		//var apiKey = "7D096ADD-E13F-3199-AC3B-67BB4C585198" // http://localhost:8090/map/

		vw.ol3.MapOptions = {
			basemapType : vw.ol3.BasemapType.GRAPHIC,
			controlDensity : vw.ol3.DensityType.EMPTY,
			interactionDensity : vw.ol3.DensityType.BASIC,
			controlsAutoArrange : true,
			homePosition : vw.ol3.CameraPosition,
			initPosition : vw.ol3.CameraPosition
		};

		var vmap = new vw.ol3.Map("map", vw.ol3.MapOptions);

		//기본으로 보여주는 제한구역 때문에 만든건데 이거말고 더 좋은 방법이 있을듯...

		//웹 사이트 켜졌을 때 체크된 거 지도에 보여주는
		$(function() {
			var $chk = $("input[name='chkBox']");

			$chk
					.each(function(idx, item) {
						vmap.removeLayer(vmap.getLayerByName(item.value)); //기존결과 삭제
						var this_val = item.value;
						if (item.checked) {
							var layer_tile = new ol.layer.Tile({
								title : '',
								id : this_val,
								name : item.value, //레이어를 삭제할 때 사용할 name
								projection : "EPSG:900913",
								extent : vmap.getView().getProjection()
										.getExtent(),
								maxZoom : 18,
								minZoom : 10,
								tilePixelRatio : 1,
								tileSize : [ 512, 512 ],
								source : new ol.source.TileWMS({
									url : "http://api.vworld.kr/req/wms?",
									params : {
										LAYERS : this_val,
										STYLES : this_val,
										CRS : "EPSG:900913",
										apikey : apiKey,
										DOMAIN : "http://loacalhost:8090",
										title : '',
										FORMAT : "image/png",
										domain : "http://localhost",
										WIDTH : 512,
										HEIGHT : 512
									}
								})
							});
							console.log("체크된거" + item.value + " : " + idx);
							layer_tile.setZIndex(5);
							vmap.addLayer(layer_tile);
							var imgSrc = "http://api.vworld.kr/req/image?key="
									+ apiKey
									+ "&service=image&request=GetLegendGraphic&format=png&type=ALL&layer="
									+ this_val + "&style=" + this_val;
							$('#wms_image').html("<img src='"+imgSrc+"' >");
						}
					});
			console.log("-------------------------");
		});

		//원하는 거 체크/체크해재 할 때마다 지도에 보여주는
		$(document)
				.on(
						'click',
						'.chkAir',
						function() {
							var $chk = $("input[name='chkBox']");

							$chk
									.each(function(idx, item) {
										vmap.removeLayer(vmap
												.getLayerByName(item.value)); //기존결과 삭제
										var this_val = item.value;
										if (item.checked) {
											var layer_tile = new ol.layer.Tile(
													{
														title : '',
														id : this_val,
														name : item.value, //레이어를 삭제할 때 사용할 name
														projection : "EPSG:900913",
														extent : vmap
																.getView()
																.getProjection()
																.getExtent(),
														maxZoom : 18,
														minZoom : 10,
														tilePixelRatio : 1,
														tileSize : [ 512, 512 ],
														source : new ol.source.TileWMS(
																{
																	url : "http://api.vworld.kr/req/wms?",
																	params : {
																		LAYERS : this_val,
																		STYLES : this_val,
																		CRS : "EPSG:900913",
																		apikey : apiKey,
																		DOMAIN : "http://loacalhost:8090",
																		title : '',
																		FORMAT : "image/png",
																		domain : "http://localhost",
																		WIDTH : 512,
																		HEIGHT : 512
																	}
																})
													});
											console.log("체크된거" + item.value
													+ " : " + idx);
											layer_tile.setZIndex(5);
											vmap.addLayer(layer_tile);
											var imgSrc = "http://api.vworld.kr/req/image?key="
													+ apiKey
													+ "&service=image&request=GetLegendGraphic&format=png&type=ALL&layer="
													+ this_val
													+ "&style="
													+ this_val;
											$('#wms_image').html(
													"<img src='"+imgSrc+"' >");
										}
									});
							console.log("-------------------------");
						});

		
	</script>
	

</html>
