<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- google jquery file -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/BBS/js/bootstrap.js"></script>

<!-- bootstrap file -->
<link rel="stylesheet" href="/BBS/css/bootstrap.css">
<link rel="stylesheet" href="/BBS/css/custom.css">

<title>Login</title>
</head>
<body>
	<%
		//세션확인
		String memID = null;
		if (session.getAttribute("memID") != null) {
			memID = (String) session.getAttribute("memID");
		}
		
		//쿠키 확인
		String cookieID = null;
		Cookie[] cookies = request.getCookies();
		for (Cookie c : cookies) {
			if (c.getName().equals("cookieID")) {
				//element 찾아서 넣어줌
				cookieID = c.getValue();
			}
		}
	    String clientId = "G476mts_Hl7_Q5_k9hD2";//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode("http://54.180.80.8:8080/BBS/member/callback.jsp", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    // session.setAttribute("state", state);
	%>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<a class="navbar-brand" href="/BBS/main.jsp">JSP Web</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav">
				<li class="nav-item active"><a class="nav-link"
					href="/BBS/main.jsp">메인</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/BBS/board/board.jsp">게시판</a></li>
			</ul>
			<%
				//세션 (회원가입 후)
				if (memID == null) {
			%>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbardrop"
					data-toggle="dropdown">접속하기</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="/BBS/member/login.jsp">로그인</a> <a
							class="dropdown-item" href="/BBS/member/join.jsp">회원가입</a>
					</div></li>
			</ul>
			<%
				} else {
			%>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbardrop"
					data-toggle="dropdown">회원관리</a>
					<div class="dropdown-menu">
						<% if(memID.equals("admin")){ %>
							<a class="dropdown-item" href="/BBS/member/list.jsp">회원목록</a> 
						<%} else{ %>
						<a class="dropdown-item" href="/BBS/member/info.jsp">회원정보</a> 
						<%} %>
						<a class="dropdown-item" href="/BBS/member/logoutAction.jsp">로그아웃</a>
						
					</div>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<br>

	<!-- 로그인 화면 만들기(그리드 시스템) -->
	<div class="container">
		<!-- container-fluid -->
		<div class="row">
			<!-- 12칸 분할 -->
			<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<form action="/BBS/member/loginAction.jsp" method="post">
					<h1 style="text-align: center">로그인</h1>
					<%
						if (cookieID != null) {
					%>
					<input id="id" value="<%=cookieID %>" class="form-control" type="text" name="memID" placeholder="Your id" maxlength="20" required autofocus>
					<%
						} else {						
					%>
					<input id="id" class="form-control" type="text" name="memID" placeholder="Your id" maxlength="20" required autofocus>
					<%
						}
					%>
					<input class="form-control" type="password" name="memPW" placeholder="Your password" maxlength="20" required>
					<div style = "padding-top: 10px">
					<a href="<%=apiURL%>" style="text-align: left"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>					
					<button class="btn btn-primary float-right" type="submit" style="text-align: right">Login</button>
					<label for="remID" style="text-align: right">
					<input type="checkbox" name="remID" value="remID" checked>Remember ID
					</label>					
					</div>
					
					<!-- <img src="/BBS/img/naver.PNG"> -->
				</form>
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>


</body>
</html>