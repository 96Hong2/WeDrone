<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/errorPage.css">
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap" rel="stylesheet">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
  <header class="top-header">
</header>

<!--dust particel-->
<div>
  <div class="starsec"></div>
  <div class="starthird"></div>
  <div class="starfourth"></div>
  <div class="starfifth"></div>
</div>
<!--Dust particle end--->


<div class="lamp__wrap">
  <div class="lamp">
    <div class="cable"></div>
    <div class="cover"></div>
    <div class="in-cover">
      <div class="bulb"></div>
    </div>
    <div class="light"></div>
  </div>
</div>
<!-- END Lamp -->
<section class="error">
  <!-- Content -->
  <div class="error__content">
    <div class="error__message message">
      <h1 class="message__title">Page Not Found</h1>
      <p class="message__text">잘못된 요청입니다. 주소를 확인하거나 고객센터(www.goodee.co.kr)로 문의해주세요.</p>
    </div>
    <div class="error__nav e-nav">
      <a href="https://14de-1-243-186-47.ngrok.io/go/" target="_blanck" class="e-nav__link"></a>
    </div>
  </div>
  <!-- END Content -->

</section>

</body>
</html>