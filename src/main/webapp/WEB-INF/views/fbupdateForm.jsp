<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<link href="${path}/resources/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Acme&display=swap"
	rel="stylesheet">
<!--폰트-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500&display=swap" rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css"
	integrity="sha384-wESLQ85D6gbsF459vf1CiZ2+rr+CsxRY0RpiF1tLlQpDnAgg6rwdsUF1+Ics2bni"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

<link href="${path}/resources/css/main.css?ver=95" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->

<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.css" />
<script src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.js"></script>
 -->
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

body,html {
	font-family: 'Do Hyeon', sans-serif;
}

table, th, td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 6px;
		text-align: left;
	}

    table{
      width:80%;
      margin-left: auto; 
      margin-right: auto;
      height:100px;
     

   }

.h1-title{
 font-family: "Do Hyeon", sans-serif;
 font-style: normal;
 font-weight: 500;
 color: #212529; 
 font-size: 2.5rem;
 margin-top: 30px;
  margin-bottom: 20px;
}
.span-file a{
 text-decoration: none;
 color: black;
}
input[name=file]{
	margin-bottom: 10px; 
}
</style>
<link href="${path}/resources/css/common.css?var=3" rel="stylesheet">

</head>
<title>드론</title>
<body>
	<!-- 상단 메뉴바 -->
	<!-- 아이디가 있다면 -->
	<%-- <c:if test="${sessionScope.userId ne null}">
		<jsp:include page="${path}/lognav"></jsp:include>
	</c:if>
	<!-- 아이디가 없ㅇ 네비바-->
	<c:if test="${sessionScope.userId eq null}">
		<jsp:include page="${path}/navbar"></jsp:include>
	</c:if> --%>

			<!-- 네비게이션바 -->
		<c:if test="${sessionScope.loginId eq null}">
			<jsp:include page="./fixmenu/navbar.jsp" />
		</c:if>
		<c:if test="${sessionScope.loginId ne null}">
			<jsp:include page="./fixmenu/lognav.jsp" />
		</c:if>



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
<%@ include file="./common/weather-widget.jsp" %>

<!--// 날씨 위젯 끝 -->
		
	<div class="wrap">
	<div class="row">
				<div class="col-md-12" style="margin-top: 30px">
		<h1 class="h1-title">자유게시판 글 수정 1</h1>
		
		<form action="fbupdate" method="post" enctype="multipart/form-data">

     
		<table style="width: 80%; margin-left: auto; margin-right: auto;">
			<tr>
				<th width="15%">게시판 번호</th>
				<td width="85%">${post.postId}<input type="hidden" name="postId" value="${post.postId}" />
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" class="form-control" name="title" id="floatingInput" value="${post.title}"  maxlength="20"/>
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>${post.nickName}<input type="hidden"
					name="nickName" value="${post.nickName}" />
				</td>
			</tr>
			<tr>
				<th>작성 날짜</th>
				<td>${post.postDate}<input type="hidden"
					name="postDate" value="${post.postDate}" />
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
	
				  <textarea name="postContent" rows="5" 
				   class="form-control" id="postContent" style="width: 100%">${post.postContent}</textarea>
            </td>
			</tr>

		<!-- 	<tr>
				<th>첨부파일</th>
				<td>
					<p>
				
					<c:forEach items="${fileList}" var="row" varStatus="status">
						<c:choose>
							<c:when test="${(row.ext eq 'GIF') or  (row.ext eq 'JPEG') or (row.ext eq 'JPG') or (row.ext eq 'PNG')}">
								<span class="span-file">
									<a href="${path}/resources/upload/${row.newFileName}" data-fancybox data-caption="${row.oriFileName}">
									<img src="${path}/resources/upload/${row.newFileName}" width="80" height="80"  class="img-responsive img-thumbnail">
									</a>						
								<a href="${path}/common/download.do?fileName=${row.newFileName}" ><i class="fa fa-download" ></i>&nbsp;${row.oriFileName}</a>
								</span>
							</c:when>
							<c:otherwise>
								<span class="span-file">
									<a href="${path}/common/download.do?fileName=${row.newFileName}" ><i class="fa fa-save" ></i>&nbsp;${row.oriFileName}</a>
								</span>
							</c:otherwise>							
						</c:choose>
			
						<button  type="button"  class="btn btn-dark" onclick="fileDelete('${row.imgId}');" style="margin-left: 50px;">파일삭제</button>	
						&nbsp;&nbsp;&nbsp;
						<c:if test="${not status.last }">|</c:if>								
						&nbsp;&nbsp;&nbsp;					
					</c:forEach>
					
					<c:if test="${empty fileList }">없음</c:if>	
					</p>				
				</td>
			</tr>
			
	
      <tr>
      	<td> <button type="button"  class="btn btn-dark" onclick="addFile()">파일추가</button></td>
         <td id="file-add-td">          
         </td>
      </tr>
	 -->

			<tr>
			<td colspan="2" class="text-center">
				   <input type="button" onclick="location.href='${path}/board'"
					value="자유게시판 리스트" class = "btn btn-dark" />
					 <button type="button"  class = "btn btn-dark" id="save">저장</button>
			</td>
			</tr>
		</table>
	</form>
	 </div>
	 </div>
	
		</div>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous">
</script>
	<script src="${path}/resources/ckeditor/ckeditor.js"></script>
	<%@ include file="./common/footer.jsp" %>

<script>
$(function(){
	CKEDITOR.replace( 'postContent',{
		height:350,
		filebrowserUploadUrl:'${path}/ckUpload'				
	} );
});

var fileCount='${fileList.size()}';


$(function(){
	$("#save").click(function(){
		var loginId='${loginId}';		
		if(loginId==""){
			alert("로그인후 이용 가능합니다.");
			return;
		}
			
		var title=$("#floatingInput").val();
		//var postContent=$("#postContent").val();
		var postContent=CKEDITOR.instances.postContent.getData();
		if(title==""){
			alert("제목을 입력하세요.");
			$("#floatingInput").focus();
			return;
		}
		
		if(postContent==""){
			alert("내용을 입력하세요.");
			$("#postContent").focus();
			return;			
		}
		
		
	  $("form").submit();
	});	
		addFile();
	
	

});



</script>	
</body>	
</html>