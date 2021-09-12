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
<link href="${path}/resources/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Acme&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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

 table{
      width:80%;
      margin-left: auto; 
      margin-right: auto;
      
     

   }
   input[type='text']{
      width:100%;
   }
   table,th,td{
      border:1px solid black;
      border-collapse:collapse;
      padding:5px 10px;
      text-align:center;
      
   }
   
   #editable{
      width:90%;
      height:280px;
      border:1px solid black;
      text-align:left;
      margin:auto;
      overflow:auto;
      
   }
</style>
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




	<div class="wrap">
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
						<li class="nav-item"><a class="nav-link active text-center"
							aria-current="page" href="${path}/map"><h4>Map</h4></a></li>
						<li class="nav-item"><a class="nav-link active text-center "
							href="${path}/calendar"><h4>Calendar</h4></a></li>
						<a class="nav-link active" href="${path}/news"><h4>News</h4></a>
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
		
		<div class="col-6 center-block" style="margin-right:auto; margin-left:auto">
				
<form action="fpwrite" method="post">
							<h1>자유 게시판 글쓰기</h1>
<table> <!-- get은 보안상의 문제도 있지만 내용을 보내는데에 한계가 있다. -->
      
      <tr>
         <th>제목</th>
         <td>
         <div class="form-floating mb-3">
  <input type="text" name="title" required class="form-control" id="floatingInput">
  <label for="floatingInput">Title</label>
</div>
         </td>
      </tr>
      <tr>
         <th>작성자</th>
         <td><input type="text" name="nickName"/></td>
      </tr>
   
      <tr>
         <th>내용</th>
         <td>
    <div id="editable" contenteditable="true">    
         <div class="form-floating mb-3">
            <!-- div 내용을 서버에 보낼 수 있도록 input을 추가 -->
    <input id="postContent" type="hidden" name="postContent" value="" required class="form-control" id="floatingInput">
        <label for="floatingInput">content</label>
          </div>
    </div>
            
         </td>
      </tr>
      <tr>
         <td colspan="2">
            <input type="button" class = "btn btn-dark" value="파일업로드" onclick="fileUp()"/>
         </td>
      </tr>
      <tr>
         <td colspan="2">
         <input type="button"  class = "btn btn-dark" onclick="location.href='./'" value="리스트"/>
         <button type="button"  class = "btn btn-dark" id="save">저장</button>
         </td>
      </tr>
   </table>
   </form>
		</div>
		</div>

		
		
		
		</body>
		<!-- 들어갈 내용 -->
		<script>

/*
     <a href='#' id ='${path}' onclick='del(this)'/>
	  <img src='${path}' width='250'/>
	  <b>X</b>
	  </a>

	  */
	  function fileUp(){
		   window.open('fbuploadForm','file upload','width=400, height=100');
		}
	  
	  $("#save").click(function(){
	  
	  //a 태그 하위에 b 태그 삭제
	  $("#editable a").find("b").remover();
	  //a 태그 자체를 삭제? a 태그 하위에 onclick 만 삭제
	  $("#editable a").removeAttr("onclick");
	  
    //저장된 파일 목록은 어떻게?
   //1. UI 를 이용하여
   // - input 에 넣는 방법
   // - ajax 일 경우 : 파일 list 라는 별도의 파라메터를 사용

   //2. session 을 이용한 방법(데이터 타입 object이니까 다 들어갈 수 있음)


   //div태그 사이에 있는 내용이기에 html로 값 받아옴 
   $("#postContent").val($("#editable").html());
   $("form").submit();
})

function del(elem){
	//삭제 요청
	//클릭시 a 태그를 가져와서 id 에서 파일명만 추출하기
	//console.log(elem);  //js object
	//console.log($(elem));  // jq object
	var fileName = elem.id.substring(elem.id.lastIndexOf("/")+1);//파일 이름만 깔끔하게 나온다
	
    console.log(fileName);
	  
	  $.ajax({
		  url:"fbfileDelete",
		  type:"get",
		  data:{"fileName":fileName},
		  dataType:"json",
		  success:function(data){
			  console.log(data);
			  if(data.success){
				  $(elem).remove();//object 안에 success ture가 뜨면 삭제 완료!
			  }
		  },
		  error:function(e){
			  console.log(e);
		  }
	  });
}
   
</script>
		
		
		
		
		
		
		
		
		

<!-- 하단 푸터 -->

<footer class="py-3 bg-dark bg-gradient">
	<p class="m-0 text-center text-white">구디아카데미 프로젝트 1조</p>
	<p class="m-0 text-center text-white">Copyright &copy; Website 2021</p>
</footer>

</html>

