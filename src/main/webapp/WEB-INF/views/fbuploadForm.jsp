<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<style></style>
	</head>
	<body>
		<form action="upload" method="post" enctype="multipart/form-data">
			<input type="file" name="file" onchange="ckUpload()"/>
		</form>
	</body>
	<script>
		var path = "${path}"
		console.log("path : "+path);
		if(path != ""){
			var elem = opener.document.getElementById("editable");
			var content = "";
			content += "<a href='#' id='${path}' onclick='del(this)'>";
			content +="<img src='${path}' width='250'/>";
			content +="<b>X</b></a>";			
			elem.innerHTML += content;
			self.close();
		}
		
		function checkSize(input) {
				console.log("checkSize :",input);
		       if (input.files && input.files[0].size > (10)) {
		           alert("이미지 용량은 10MB까지만 첨부 가능합니다.");
		           input.value = null;
		           return;
		       }
		}
		
		function ckUpload(){
			$('form').submit();
		}


	</script>
</html>