<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="resources/js/jquery.twbsPagination.js"></script>
<style></style>
</head>
<body>

	<div class='cmt_wrap'>
			<div class='cmtCount'>
				&nbsp;
				<p id='cmtCount'></p>
				Comments
			</div>
			<div class='commentInputBox'>
				<div id="emptyComment"></div>
				<b style='color: rosybrown;'> 댓글 작성</b>
				<hr></hr>
				<textarea id='cmtInput' name='cmtInput'
					placeholder="여기에 댓글을 입력해주세요" ></textarea>
				<button id="cmtInputBtn">댓글달기</button>
			</div>
	
			<div class='commentAreaBox'>
				<table id='commentAreaTable'>
					<tr>
						<td align="center">댓글을 불러오는 중입니다</td>
					</tr>
				</table>
			</div>
	
			<div class="pageContainer">
				<nav aria-lable="Page navigation" style="text-align:center">
					<ul class="pagination" id="pagination"></ul>
				</nav>
			</div>
		</div>

</body>
<script>

var currPage = 1;

loadComments(currPage);

function loadComments(page) { //댓글 데이터를 불러오는 함수
	console.log(page+"가져오기");
	$
			.ajax({
				type : "POST",
				url : "loadComments", //글번호를 받아 댓글,대댓글 데이터를 반환
				data : {
					"reviewId" : "${param.reviewId}",
					"page" : page
				},
				dataType : 'JSON',
				success : function(data) {
					if (data.list != null) { //DB에서 댓글 데이터를 정상적으로 가져왔다면
						$(".commentAreaBox").show(); //만약 숨겨져있으면 보이게 한다
						$('#cmtCount').html(data.totalCnt);
						drawComments(data.list); //댓글리스트를 브라우저에 그려준다
						$("#pagination").twbsPagination({
							startPage : data.currPage, //시작페이지
							totalPages : data.pages, //총 페이지 개수
							visiblePages : 5,
							onPageClick : function(e, page){
								console.log(e, page);
								loadComments(page);
							}
						});
					} else { //등록된 댓글이 없다면
						$("#emptyComment")
								.html(
										"<b>댓글이 없습니다</b>");
						$(".commentAreaBox").hide();
					}
				},
				error : function(e) {
					console.log("ajax loadComments() 에러 : " + e);
				}
			})

}

function drawComments(list) {
	console.log("drawComments() 들어옴");
	var content = "";
	var loginId = "${sessionScope.userId}";
	var loginNickName = "${sessionScope.nickName}"

	list
			.forEach(function(item, idx) {

					//댓글 보여주기
					content += "<tbody class='cmtTbodyClass' id='cmtTbody"+idx+"'>";
					content += "<tr>";
					content += "<td rowspan='2'></td>";

					//이 댓글의 작성자가 현재 로그인된 유저아이디와 같다면 색깔을 입혀서 보여준다
					if (item.userId == loginId) {
						content += "<td></td><td style='color:rosybrown;'> <b>작성날짜</b> "
								+ item.comment_date + "</td>";
						content += "<td style='color:rosybrown;'><b>작성자</b> "
								+ item.nickName + "</td>";
					} else {
						content += "<td></td><td> <b>작성날짜</b> "
								+ item.comment_date + "</td>";
						content += "<td><b>작성자</b> " + item.nickName
								+ "</td>";
					}

					//이 댓글의 작성자가 현재 로그인된 유저아이디와 같다면 수정과 삭제버튼을 보여준다
					if (item.userId == loginId) {
						content += "<td><button id='cmtUpdateBtn" + idx
								+ "' onclick='cmtUpdateClick(" + idx
								+ ")'>수정</button></td>";
						content += "<td><button id='cmtDeleteBtn" + idx
								+ "' onclick='cmtDelete(" + idx + ", \""
								+ item.commentId + "\", \"" + item.lev
								+ "\")'>삭제</button></td>";
					} else {
						content += "<td></td><td></td>";
					}

					//댓글 수정하기
					content += "<tbody class='cmtUpdateTbodyClass' id='cmtUpdateTbody"+idx+"'>";
					content += "<tr><td><b style='color:rosybrown;'>&nbsp; 댓글 수정</b></td></tr>";
					content += "<tr>";
					content += "<td rowspan='2'></td>";
					content += "<td></td>";
					content += "<td style='color:rosybrown;'><b>작성날짜</b> "
							+ item.comment_date + "</td>";
					content += "<td style='color:rosybrown;'><b>작성자</b> "
							+ item.nickName + "</td>";
					content += "<td><button id='cmtUpdateSubmitBtn" + idx
							+ "' onclick='javascript:cmtUpdateExecute("
							+ idx + ", \"" + item.commentId + "\", \""
							+ item.lev + "\")'>저장</button></td>";
					content += "<td><button id='cmtUpdateCancelBtn"+idx+"' onclick='javascript:cmtUpdateCancel("+idx+",\""+item.comment_content+"\")'>취소</button></td>";
					content += "</tr>";
					content += "<tr>";
					content += "<td class='cmt_content"+idx+"' colspan='9'>";
					content += "<textarea id='cmtUpdateInput"+idx+"' name='cmtUpdateInput"+idx+"'";
			content +=	"style='width:500px;'>"
							+ item.comment_content + "</textarea>";
					content += "</td>";
					content += "</tr>";
					content += "</tbody>";

				
			});
			

	$("#commentAreaTable").empty(); //기존 내용을 비우기
	$("#commentAreaTable").append(content);

	/*
	var i = 0;
	content = "";
	//페이징
	content += "<button type='button' onclick='loadComments(" + start
			+ ", 1)'>이전</button>"
	console.log("======페이징 시작=====");
	//console.log("typeof(totalPage) : "+typeof(totalPage));
	console.log("start / totalPage : " + start + "/" + totalPage);
	if (totalPage < end) {
		for (i = start; i <= totalPage; i++) {
			content += "<div class='page'>";
			if (i == currPage) {
				content += ("<b>" + i + "</b>");
			} else {
				content += ("<a href='javascript:loadComments(" + i
						+ ",-1)'>" + i + "</a>");
			}
			console.log("totalPage<end여서 for문 끝!!");
			content += "</div>";
		}
	} else {
		for (i = start; i < end; i++) {
			content += "<div class='page'>";
			if (i == currPage) {
				content += ("<b>" + i + "</b>");
			} else {
				content += ("<a href='javascript:loadComments(" + i
						+ ",-1)'>" + i + "</a>");
			}
			content += "</div>";
		}
	}
	content += "<button type='button' onclick='loadComments(" + end
			+ ", 2)'>다음</button>";
	content += "<div style='height:5px'>&nbsp;</div>";
	*/

	$(".pageArea").empty();
	$(".pageArea").append(content);

	//댓글 수정창 숨기기
	$(".cmtUpdateTbodyClass").hide();


//댓글 작성
$("#cmtInputBtn").click(function() { //댓글 달기 버튼 클릭 시

	if ($("#cmtInput").val() == null || $("#cmtInput").val() == "") {
		alert("댓글 내용을 입력해주세요.");
		return;
	}

	$.ajax({
		url : "writeComment",
		type : "POST",
		dataType : "JSON",
		data : {
			postId : "${param.postId}",
			content : $("#cmtInput").val()
		},
		success : function(data) {
			if (data.success) {
				alert("댓글 등록에 성공했습니다.");
				$("#cmtInput").val('');
				loadComments(-1, -1);
			} else {
				alert("댓글 등록에 실패했습니다.");
				loadComments(-1, -1);
			}
		}
	})
})

//댓글 및 대댓글 수정(공용)
//댓글 수정 버튼 클릭 시
function cmtUpdateClick(idx) {
	console.log("cmtUpdateClick() idx : " + idx);
	$("#cmtTbody" + idx).hide();
	$("#cmtUpdateTbody" + idx).show();
}

//댓글 수정 취소 버튼 클릭 시
function cmtUpdateCancel(idx, ex_content) {
	console.log("cmtUpdateCancel() idx : " + idx);
	$("#cmtUpdateInput" + idx).val(ex_content);
	$("#cmtUpdateTbody" + idx).hide();
	$("#cmtTbody" + idx).show();
}

//댓글 수정 저장 버튼 클릭 시
function cmtUpdateExecute(idx, commentId, lev) {
	console.log("cmtUpdateExecute() idx/commentId/lev : " + idx + "/"
			+ commentId + "/" + lev);
	$("#cmtTbody" + idx).hide();
	$("#cmtUpdateTbody" + idx).show();

	console.log("cmtUpdateExecute() 수정내용 : " + idx + "/" + commentId + "/"
			+ lev);

	if ($("#cmtUpdateInput" + idx).val() == null
			|| $("#cmtUpdateInput" + idx).val() == "") {
		alert("수정할 댓글 내용을 입력해주세요.");
		return;
	}

	$.ajax({
		url : "updateComment",
		type : "POST",
		dataType : "JSON",
		data : {
			commentId : commentId,
			lev : lev,
			content : $("#cmtUpdateInput" + idx).val()
		},
		success : function(data) {
			if (data.success) {
				alert("댓글 수정에 성공했습니다.");
				loadComments(-1, -1);
			} else {
				alert("댓글 수정에 실패했습니다.");
				loadComments(-1, -1);
			}
		}
	})
}



</script>
</html>