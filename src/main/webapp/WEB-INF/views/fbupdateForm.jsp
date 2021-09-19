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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Acme&display=swap" rel="stylesheet">

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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
	crossorigin="anonymous">
	
</script>

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
		
	<div class="wrap">
		<h1 class="h1-title">자유게시판 글 수정 1</h1>
		
		<form action="fbupdate" method="post" enctype="multipart/form-data">

     
		<table style="width: 800px; margin-left: auto; margin-right: auto;">
			<tr>
				<th>게시판 번호</th>
				<td>${post.postId}<input type="hidden"
					name="postId" value="${post.postId}" />
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text"
					name="title" value="${post.title}" />
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
				<div id="editable" contenteditable="true">	
				  <textarea name="postContent" rows="5" cols="" style="width: 100%">${post.postContent}</textarea>
           		 </div>
            </td>
			</tr>

			<tr>
				<th>사진</th>
				<td><img src="/photo/${image.newFileName}" width="500px" />
					<p>
						<input type="file" name="photo" onchange="fbfileUpload()"/>
					</p></td>
			</tr>
			 <tr>
         <td colspan="2">
            <input type="button" class = "btn btn-dark" value="파일업로드" onclick="fileUp()"/>
         </td>
          </tr>

			<tr>
			<td>
				   <input type="button" onclick="location.href='${path}/fbList'"
					value="자유게시판 리스트" class = "btn btn-dark" />
					<button class = "btn btn-dark">저장</button></td>
			</tr>
		</table>
	</form>
		</div>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		</body>
		
		<!-- 들어갈 내용 -->
		
		
		
		
		
		
		
		
		
		

<!-- 하단 푸터 -->

<%@ include file="./common/footer.jsp" %>

</html>