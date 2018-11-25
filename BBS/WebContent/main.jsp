<%@page import="board.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<meta name="viewport" content="width=device-width, inintial-scale=1">
<!--  google jquery file -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!--  bootstrap file -->
<link rel="stylesheet" href="/BBS/css/bootstrap.css">
<link rel="stylesheet" href="/BBS/css/custom.css">
<script src="/BBS/js/bootstrap.js"></script>


<title>Main</title>
</head>
<body>
	<%
		//세션확인
		String memID = null;
		if (session.getAttribute("memID") != null) {
			memID = (String) session.getAttribute("memID");
		}
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
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbardrop"
					data-toggle="dropdown">회원관리</a>
					<div class="dropdown-menu">
						<%
							if (memID.equals("admin")) {
						%>
						<a class="dropdown-item" href="/BBS/member/list.jsp">회원목록</a>
						<%
							} else {
						%>
						<a class="dropdown-item" href="/BBS/member/info.jsp">회원정보</a>
						<%
							}
						%>
						<a class="dropdown-item" href="/BBS/member/logoutAction.jsp">로그아웃</a>

					</div></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<br>

	<div class="container">
		<div class="jumbotron">
			<h1>Ryan's WEB PAGE</h1>
			<p>해당 페이지는 부트스트랩4와 JSP를 이용한 테스트 홈페이지입니다. 오라클, 이클립스, 윈도우, CSS, HTML,
				JS, Jquery를 이용하였습니다.</p>
			<p>
				<a class="btn btn-success float_left" href="https://www.w3schools.com/">함께 배워보기</a>
			</p>
		</div>
	</div>
	<div class="container">
		<button class="btn btn-primary float-right" type="button"
			onclick="location.href='/BBS/board/board.jsp'">더보기</button>
	</div>

	<div id="realtime" class="container">
		<h2>최근 게시글</h2>

		<ul class="list-group">
			<a id="link1" href="#"><li class="list-group-item">First
					item</li></a>
			<a id="link2" href="#"><li class="list-group-item">Second
					item</li></a>
			<a id="link3" href="#"><li class="list-group-item">Third
					item</li></a>
		</ul>
	</div>
	<br>

	<div class="container">
		<div id="demo" class="carousel slide" data-ride="carousel">

			<!-- Indicators -->
			<ul class="carousel-indicators">
				<li data-target="#demo" data-slide-to="0" class="active"></li>
				<li data-target="#demo" data-slide-to="1"></li>
				<li data-target="#demo" data-slide-to="2"></li>
			</ul>

			<!-- The slideshow -->
			<div class="carousel-inner" responsive: true>
				<div class="carousel-item active">
					<img src="img/img1.jpg" alt="Ryan" width="1100" height="500">
				</div>
				<div class="carousel-item">
					<img src="img/img2.jpg" alt="Ryan" width="1100" height="500">
				</div>
				<div class="carousel-item">
					<img src="img/img3.jpg" alt="Ryan" width="1100" height="500">
				</div>
			</div>

			<!-- Left and right controls -->
			<a class="carousel-control-prev" href="#demo" data-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</a> <a class="carousel-control-next" href="#demo" data-slide="next">
				<span class="carousel-control-next-icon"></span>
			</a>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			getAjaxList();
		});
		function getAjaxList() {
			$.ajax({
				type : "GET",
				url : "ABoardList",
				dataType : "json",
				success : function(data) {
					//console.log(data);
					//console.log(data[0].bdTitle);
					var list = document
							.querySelectorAll('#realtime .list-group-item');
					list[0].textContent = data[0].bdTitle;
					list[1].textContent = data[1].bdTitle;
					list[2].textContent = data[2].bdTitle;

					var link1 = $('#link1');
					link1.click(function() {
						link1.attr('href', '/BBS/board/view.jsp?bdID='
								+ data[0].bdID);
					});
					var link2 = $('#link2');
					link2.click(function() {
						link2.attr('href', '/BBS/board/view.jsp?bdID='
								+ data[1].bdID);
					});
					var link3 = $('#link3');
					link3.click(function() {
						link3.attr('href', '/BBS/board/view.jsp?bdID='
								+ data[2].bdID);
					});

				}
			});
		}

		setInterval(getAjaxList, 5000);
	</script>




</body>
</html>