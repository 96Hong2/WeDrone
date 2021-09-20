<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- 부트스트랩 메타태그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 파일 -->
<link href="${path}/resources/css/bootstrap.css?ver=8" rel="stylesheet">
<!-- css cdn 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" >
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500&display=swap"
	rel="stylesheet">

<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.3/css/fontawesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<link href="${path}/resources/css/main.css?ver=95" rel="stylesheet">
		
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"> </script>
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
      height:300px;
     

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
#proCommentBtn{
	margin: 20px 0px;
} 


.left-td{
border:0px;
width: 73%;
padding: 30px !important;
}
.right-td{
border:0px;
width:10%;
}
.td-nickname{
border:0px;
width:17%;
}
#commentList-row{
	margin-bottom: 230px
}
.pagination{
	display: inline-flex !important;
}

.page-item.active .page-link {
    background-color: #41464b;
    border-color: #41464b;
}
.page-link {
    color: #41464b;
}
.page-link:hover {
    color: #212529;
    background-color: #e9ecef;
    border-color: #dee2e6;
}
table {
	border:0px;
	height: auto;
}
.td-180{
	padding-left: 120px  !important;
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

	<div class="wrap">
		<!-- 네비게이션바 -->
		<c:if test="${sessionScope.loginId eq null}">
			<jsp:include page="./fixmenu/navbar.jsp" />
		</c:if>
		<c:if test="${sessionScope.loginId ne null}">
			<jsp:include page="./fixmenu/lognav.jsp" />
		</c:if>
		
		

	<h1 class="h1-title">자유 게시판 상세보기</h1>	
	<table>
	
		<tr>
			<th>게시판 번호</th>
			<td>${post.postId}</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>${post.nickName} (${post.userId})</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${post.postDate}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${post.postContent}</td>
		</tr>
		
		
		<tr>
			<td colspan="2">
				<c:choose>
					<c:when test="${param.update eq 'ok' }">
						<button onclick="location.href='${path}/fbList'" class = "btn btn-dark" >리스트</button>
					</c:when>
					<c:otherwise>
					<button onclick="history.back();" class = "btn btn-dark" >리스트</button>
					</c:otherwise>
				</c:choose>
				
				
			<c:choose>			
				<c:when test="${post.userId eq loginId}">
					<button onclick="location.href='./fbupdateForm?postId=${post.postId}'" class = "btn btn-dark" >수정</button>
					<button onclick="location.href='./fbdel?postId=${post.postId}'" class = "btn btn-dark" >삭제</button>	
				</c:when>
				<c:otherwise>
					<button onclick="alert('작성자만 수정 가능합니다.')" class = "btn btn-dark" >수정</button>
					<button onclick="alert('작성자만 삭제 가능합니다.')" class = "btn btn-dark" >삭제</button>	
				</c:otherwise>
			</c:choose>				
		
			</td>
		</tr>
	</table>
		
<!-- 	<div class="container px-4 my-4">
		<h3 id="comments" class="fw-bold mt-3">댓글</h3>
				<hr />
				<c:if test="${loginId==null}">
					<div class="d-flex align-items-center">
						<div class="form-floating flex-grow-1 px-2">
							<textarea class="form-control" placeholder="Leave a comment here"
								name="commentContent" id="commentContent"
								style="height: 100px; resize: none;"></textarea>
							<div class="invalid-feedback">1자 이상 입력해주세요.</div>
							<label for="commentContent">로그인 후 이용해주세요.</label>
						</div>
						
					</div>
				</c:if>
				 -->
				 
		
			<div id='commentArea'>
				<div class="container px-4 my-4" id="post_commentWrap">
				<h3 id="comments" class="fw-bold mt-3">댓글</h3>
						<hr />
						<c:if test="${sessionScope.loginId ==null}">
							<div class="d-flex align-items-center">
								<div class="form-floating flex-grow-1 px-2">
									<textarea class="form-control" placeholder="Leave a comment here"
										name="cmtContent" id="cmtContent"
										style="height: 100px; resize: none;"></textarea>
									<div class="invalid-feedback">1자 이상 입력해주세요.</div>
									<label for="cmtContent">로그인 후 이용해주세요.</label>
								</div>
								
							</div>
						</c:if>
			
			
				
				<c:if test="${sessionScope.loginId != null}">
					<div class="d-flex align-items-center">
						<div class=" flex-grow-1 px-2">
						<textarea class="form-control" placeholder="${loginId}님, 이곳에 댓글을 작성하세요"
								name="cmtContent" id="cmtContent"
								style="height: 80px; resize:none; margin:auto;width:80%;"></textarea>
								
							<div class="invalid-feedback">1자 이상 입력해주세요.</div>						
					     <input type="hidden" name="postId" id="postId" value="${post.postId }" >	
						 <a type="button" id="proCommentBtn" class="btn btn-secondary btn-sm" title="${post.postId}">등록</a>
						</div>

					</div>
				</c:if>
				<br/>
		
	
			<div class="row" id="commentList-row">	
			<div class="col-md-12"> 
				<p style="float: left; top:-10px">댓글 (<span id="commentTotalCount"></span>)</p>
			</div>				
				<div class="col-md-12 " role="main" style="margin-top: 30px">	
												 	
					 <div class="table-responsive">
						<table class="table table-striped" >
							<tbody id="tbody-commentList">
					
							</tbody>
							
							<tfoot>
								<tr>
								<td colspan="2" class="text-center" style="border: 0px; text-align: center;">
								<nav aria-label="..." id="nav-pagination" ></nav>								
								</td>
								</tr>
							</tfoot>
						</table>
					 </div>			
			</div>
			</div>
			
			
			
			
			 </div>	
	</div>	<!--// 	commentArea -->	
				
		
		

<!-- Modal -->
	<div class="modal fade" id="commentUpdate-modal" data-backdrop="static"
		tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">댓글 수정</h5>					
				</div>				
				<div class="modal-body">
				 <form id="frm-comment" >
					<textarea rows="5" cols="" style="width: 100%" id="commnet-update-cmtcontent" name="cmtcontent"></textarea>
				 	<input type="hidden" id="commnet-update-cmtId"  name="cmtId">
				 </form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" onclick="commentModalClose()"  data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" onclick="commentUpdate()" >수정하기</button>
				</div>
			</div>
		</div>
	</div>
	
	
		
				
<script id="template" type="text/x-handlebars-template">
{{#each .}}     
 		<tr>								
		  <td class="left-td" >{{commentCount RN}}.  {{CMTCONTENT}}

		  </td>
		 <td class="td-nickname  td-120" {{#userNotConfirm  USERID}} colspan="2" style="padding-left: 120px;"{{/userNotConfirm}} >
 			<small>{{CMTDATE}}</small><br>
			{{NICKNAME}} ({{USERID}}) 		
		</td>
		{{#userConfirm  USERID}}
		  <td  class="right-td">			
			<a class='ms-2 float-end btn btn-secondary btn-sm'  onclick="commentDelete('{{CMTID}}')">삭제</a>
			<a class='btn btn-secondary btn-sm' onclick="commentUpdateForm('{{CMTID}}')">수정</a>																						
  		 </td>
		{{/userConfirm}}		
	    </tr>
{{/each}}   
</script>	


<script>
function commentDelete(cmtId){	
	var postId=$("#postId").val();
	if(confirm("정말 삭제 하시겠습니까?")){
		$.ajax({
			type : "POST",
			url : "fbcmtDel", 
			data : {
				"postId" : postId,
				"cmtId":cmtId
			},
			dataType : 'JSON',
			success : function(data) {				
				getCommentList(1);
			},
			error:function(result) {
				console.log("error:");
				console.log(result);
			}			
		});
	}
	alert(cmtid);
}

function commentUpdateForm(cmtId){		
	$("#commentUpdate-modal").modal("show");	
	$.ajax({
		type : "POST",
		url : "getComment", 
		data : {
			"cmtId" : cmtId,		
		},
		dataType : 'JSON',
		success : function(data) {
			//console.log(data);
			$("#commnet-update-cmtcontent").val(data.CMTCONTENT);
			$("#commnet-update-cmtId").val(cmtId);
		},
		error:function(result) {
			console.log("error:");
			console.log(result);
		}			
	});		
}

// 댓글 수정
function commentUpdate(){		
	var cmtContent  =$("#commnet-update-cmtcontent").val();
	var cmtId=$("#commnet-update-cmtId").val();
	
	$.ajax({
		type : "POST",
		url : "fbcmtupdate", 
		data : {
			"cmtId" : cmtId,
			"cmtContent":cmtContent
		},
		dataType : 'JSON',
		success : function(data) {
			//console.log(data);			
			getCommentList(1);
			$("#commentUpdate-modal").modal("hide");
		},
		error:function(result) {
			console.log("error:");
			console.log(result);
		}			
	});		
}


$(function(){
	$("#cmtContent").on("keypress", function(e){		
		if($('#cmtContent').hasClass('is-invalid')){
			$('#cmtContent').removeClass('is-invalid');	
		}				
	});
	
	$("#proCommentBtn").on("click", function(e){
		var postId=$("#postId").val();
		var cmtContent = $('#cmtContent').val();		
		var postedUserId='${post.userId }';
		var postedTitle='${post.title}'
		if(cmtContent==""){
			$('#cmtContent').addClass('is-invalid');
			return;
		}
				
		$.ajax({
			type : "POST",
			url : "fbcmtwrite", 
			data : {
				"postId" : postId,
				"cmtContent" : cmtContent,
				"postedUserId":postedUserId,
				"postedTitle":postedTitle,
				"cmtField":"Fbpost"
			},
			dataType : 'JSON',
			success : function(data) {
				$('#cmtContent').val("");
				getCommentList(1);
			},
			error:function(result) {
				console.log("error:");
				console.log(result);
			}			
		});
	});
	
	getCommentList();
		
});


function getCommentList(currPage){
		var postId=$("#postId").val();
		if(currPage==""|| currPage==undefined){
			currPage=1;
		}				
		$.ajax({
		type : "POST",
		url : "fbcmList", 
		data : {
			"postId" : postId,
			"page" : currPage
		},
		dataType : 'JSON',
		success : function(data) {
			//console.log(data);
			var loginId='${loginId}';
			//$("#selectMaterialSearchTotalCount").text(result.totalCount);           
            
            //핸들바 템플릿 가져오기
            var source = $("#template").html();
            var template = Handlebars.compile(source);
            
            Handlebars.registerHelper('userConfirm', function(postUserid, options) {
                if(postUserid==loginId){
                    return options.fn(this);
                }
                return options.inverse(this);                                   
            });
            Handlebars.registerHelper('userNotConfirm', function(postUserid, options) {
            	 if(postUserid==loginId){
            		 return options.inverse(this);  
                 }
            	 return options.fn(this);                                 
            })
            
             Handlebars.registerHelper('commentCount', function(rn, options) {     
            	 return parseInt(data.commentTotalCount)-rn+1;                                 
            })
            
            $("#commentTotalCount").text(data.commentTotalCount);
            if(parseInt(data.commentTotalCount)>10){
            	 $("#nav-pagination").html(data.pagination);
            }
            //배열 형식 이라 자동으로 매칭                           
            $("#tbody-commentList").html(template(data.commentList));  
          
		},
		error:function(result) {
			console.log("error:");
			console.log(result);
		}
	});			
}

function commentModalClose(){
	$("#commentUpdate-modal").modal("hide");
}

</script>



<%@ include file="./common/footer.jsp" %>


</body>
</html>
