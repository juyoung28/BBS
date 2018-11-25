<%@page import="java.io.PrintWriter"%>
<%@page import="board.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
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


<title>Board</title>
</head>
<body>
	<%
		String memID = null;
		if (session.getAttribute("memID") != null) {
			memID = (String) session.getAttribute("memID");
		}
		
		if(memID ==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href='/BBS/member/login.jsp'");		
			script.println("</script>");
		}
		
		int bdID = 0;
		if(request.getParameter("bdID") !=null){
			bdID = Integer.parseInt(request.getParameter("bdID"));
		}
		
		BoardDAO boardDAO = new BoardDAO();
		Board board = boardDAO.getBoard(bdID);
		
		if(board == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('해당 글이 없습니다.')");
			script.println("location.href='/BBS/board/board.jsp'");		
			script.println("</script>");
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

	<div class="container">
		<div class="row">
			<!-- 12개의 칼럼 -->
			<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<form action="/BBS/board/updateAction.jsp" method="post">
					<table class="table table-striped" style="border: 1px solid #dddddd">
						<thead>
							<tr>
								<th>수정하기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>									
									<input type="text" class="form-control" value="<%=board.getBdTitle() %>" name="bdTitle" maxlength="50">									
								</td>
							</tr>
							<tr>
								<td>
									<textarea class="form-control" name="bdContent" maxlength="2048" style="height:350px;"><%=board.getBdContent() %></textarea>							
								</td>
							</tr>
							<tr>
								<td><input type="hidden" name="bdID" value="<%=bdID%>"></td>
							</tr>
						</tbody>
					</table>
					<button class="btn btn-primary float-right" type="submit">수정하기</button>
				</form>
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>




</body>
</html>


