<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<title>위드론</title>
<body>
	<!-- 상단 메뉴바 -->
	<!-- 섹션에 아이디가 있다면 -->
	<c:if test="${sessionScope.loginId ne null}">

	</c:if>
	<!-- 섹션에 아이디가 없다면 -->
	<c:if test="${sessionScope.loginId eq null}">

	</c:if>



	<!-- 들어갈 내용 -->
	<div class="wrap">
		<div class="container px-4 py-4 my-4 border shadow-lg" id="cont">
			<h4 class="mb-3 fw-bold">회원가입</h4>
			<hr />
			<form action="join" method="post" class="needs-validation"
				novalidate>
				<div class="form-floating col-md-9 mb-3">
					<input type="text" class="form-control" name="userId" id="userId"
						placeholder="아이디(4~10자)" maxlength="10" value="" required>
					<label for="validationTooltip01" class="fw-bold"></label>									
					<input type="button" class="btn btn-dark btn-sm mt-2" id="idCheck"
						value="중복확인">					
					
				</div>
				<div class="form-floating col-md-9 mb-3">
					<input type="password" class="nullchecks form-control" name="pw"
						id="pw" placeholder="비밀번호(6~20자)" maxlength="20" value="" required>
					<label for="validationTooltip02" class="fw-bold"></label>
					<div class="invalid-feedback">필수 정보입니다</div>
				</div>
				<div class="form-floating col-md-9 mb-3">
					<input type="password" class="form-control" id="UserPwch"
						name="pwch" placeholder="비밀번호확인" maxlength="20" value="" required>
					<label for="validationTooltip02" class="fw-bold"></label>
					<div class="invalid-feedback">동일한지 확인해주세요</div>
				</div>
				<div class="form-floating col-md-9 mb-3">
					<input type="text" class="nullchecks nullcheck form-control"
						id="nickName" name="nickName" placeholder="닉네임(2~7자)"
						maxlength="7" required> <label for="validationTooltip04"
						class="fw-bold"></label>					
					<input type="button" class="btn btn-dark btn-sm mt-2" id="nickCheck"
						value="중복확인">					
				</div>

				<div class="col-md-9 mb-3">
					<label for="validationTooltip05" class="fw-bold">메시지 좋아요 알림
						수신 여부</label>
					<div class="form-check form-check-inline mx-3">
						<input class="form-check-input" type="radio" name="alertradio"
							id="alertradio1" value="Y" checked> <label
							class="form-check-label" for="alertradio">동의 </label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="alertradio"
							id="alertradio2" value="N"> <label
							class="form-check-label" for="alertradio2"> 거부 </label>
					</div>
				</div>

				<hr />
				<div class="col text-center">
					<input class="btn btn-dark" type="button" id="joinBtn"
						value="가입하기" onclick="join()">
				</div>
			</form>
		</div>
	</div>
	<script>
	
	var idCheck = false;
	var nickCheck = false;
	
		function join(){
			var $userId = $("input[name='userId']");
			var $pw = $("input[name='pw']");
			var $nickName = $("input[name='nickName']");
			var chkAlert = $('input:radio[name="alertradio"]:checked');
			
			if($userId.val() == ""||$pw.val()==""||$nickName.val() == ""){         
			      alert("빈칸을 입력해 주세요.");
		}else/* (nickCheck==true && idCheck==true) */{
	         console.log('save!!')
	         var param = {};
	         param.userId = $userId.val();
	         param.pw = $pw.val();	         
	         param.nickName = $nickName.val();
	         param.chkAlert = chkAlert.val();
	        
	         $.ajax({
	             type:'POST',
	             url:'join',
	             data:param,
	             dataType:'JSON',
	             success:function(data){
	                console.log(data);
	                if(data.success > 0){
	                   alert('가입이 완료되었습니다.');	                  
	                }else{              
	               	alert('가입에 실패했습니다.')
	             }
	          },
	            error:function(e){
	                console.log(e);
	             }
	          });
		}
		}
	      /*  }else if(nickCheck==true && idCheck==false){
	     	  alert('아이디 중복체크를 진행해주세요.');
	     	  return;
	       }else if(idCheck==true && nickCheck==false){
	     	  alert('닉네임 중복체크를 진행해주세요.');
	     	  return;
	        }else if(idCheck==false && nickCheck==false){
	      	  alert('아이디와 닉네임 중복체크를 진행해주세요.');
	      	  return;
	        } */         
		
		
		
	



	/*  $("#idCheck").click(function(){
	    var userId = $("input[name='userId']").val();
	    console.log(userId);
	    $.ajax({
	       type:'post',
	       url:'idCheck',
	       data:{'userId':userId},
	       dataType:'JSON',
	       success:function(data){
	          console.log(data);
	          if(!data.success){
	             alert("처리중 문제가 발생 했습니다. 다시 시도해 주세요!");
	          }else{
	             if(data.idCheck){
	                alert("중복된 아이디입니다.");
	                 $("input[name='userId']").val("");
	             }else{
	                alert("아이디를 사용할 수 있습니다.");
	                overChk = true;
	             }
	          }            
	       },
	       error:function(e){
	          console.log(e);
	       }         
	    });
	 });

	 $("#nickCheck").click(function(){
	    var nickName = $("input[name='nickName']").val();
	    console.log(nickName);
	    $.ajax({
	       type:'post',
	       url:'nickCheck',
	       data:{'nickName':nickName},
	       dataType:'JSON',
	       success:function(data){
	          console.log(data);
	          if(!data.success){
	             alert("처리중 문제가 발생 했습니다. 다시 시도해 주세요!");
	          }else{
	             if(data.overlay1){
	                alert("중복된 닉네임입니다.");
	                 $("input[name='nickName']").val("");
	             }else{
	                alert("닉네임을 사용할 수 있습니다.");
	                nickChk = true;
	             }
	          }            
	       },
	       error:function(e){
	          console.log(e);
	       }         
	    });
	 }); */
	
	</script>
</body>

</html>