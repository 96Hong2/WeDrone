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
	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="./fixmenu/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="./fixmenu/lognav.jsp" />
	</c:if>


	<div class="wrap">

	 
		<div class="row">
				<div class="col-md-12" style="margin-top: 30px">
		<form action="fbwrite" method="post" enctype="multipart/form-data"> 		

							<h1 class="h1-title">자유 게시판 글쓰기</h1>
<table style="width: 80%; margin-left: auto; margin-right: auto;"> <!-- get은 보안상의 문제도 있지만 내용을 보내는데에 한계가 있다. -->
      
      <tr>
         <th width="15%">제목</th>
         <td width="85%"> <!-- <div class="form-floating"> -->
         <div class="">
		  <input type="text" name="title" required class="form-control" id="floatingInput" placeholder="Title" maxlength="20" >
		  <!-- <label for="floatingInput">Title</label> --> 
		</div>
         </td>
      </tr>
        <tr>
         <th>내용</th>
         <td>
<!--     <div id="editable" contenteditable="true">    
         <div class="form-floating mb-3">
    <input id="postContent" type="hidden" name="postContent" value="" required class="form-control" id="floatingInput">
       
          </div>
    </div>
            -->
            <textarea id="postContent" name="postContent"    rows="10"  class="form-control"  style="width: 100%" ></textarea> 
         </td>
      </tr>
      
      <!--  
      <tr>
      	<td> <button type="button"  class="btn btn-dark" onclick="addFile()">파일추가</button></td>
         <td id="file-add-td">          
         </td>
      </tr>
	-->
      <tr> 
         <td colspan="2">
         <input type="button"  class = "btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/board'" value="리스트"/>
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

<!--  <script src="//cdn.ckeditor.com/4.10.1/standard/ckeditor.js"></script>
 -->
	 <script src="${path}/resources/ckeditor/ckeditor.js"></script>
		<%@ include file="./common/footer.jsp" %>
		
		
		</body>
		<!-- 들어갈 내용 -->
	
		<script>
$(function(){
	CKEDITOR.replace( 'postContent',{
		height:350,
		filebrowserUploadUrl:'${path}/ckUpload'				
	} );
});
/*
     <a href='#' id ='${path}' onclick='del(this)'/>
	  <img src='${path}' width='250'/>
	  <b>X</b>
	  </a>

	  */
	  function fileUp(){
		   window.open('fbuploadForm','file upload','width=400, height=100');
		}
	  
	 // $("#save").click(function(){
		//var loginId='${loginId}';		
		//if(loginId==""){
		//	alert("로그인후 이용 가능합니다.");
		//	return;
		//}
		  
		  //a 태그 하위에 b 태그 삭제
		//  $("#editable a").find("b").remove();
		  //a 태그 자체를 삭제? a 태그 하위에 onclick 만 삭제
		//  $("#editable a").removeAttr("onclick");
		  
	    //저장된 파일 목록은 어떻게?
	   //1. UI 를 이용하여
	   // - input 에 넣는 방법
	   // - ajax 일 경우 : 파일 list 라는 별도의 파라메터를 사용
	
	   //2. session 을 이용한 방법(데이터 타입 object이니까 다 들어갈 수 있음)
	
	
	   //div태그 사이에 있는 내용이기에 html로 값 받아옴 
	   //$("#postContent").val($("#editable").html());
	  // $("form").submit();
	//});
	  
	  
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


</html>