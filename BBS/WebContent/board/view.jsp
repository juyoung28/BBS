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
		} else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href='/BBS/member/login.jsp'");		
			script.println("</script>");
		}
		int bdID = 0;
		if(request.getParameter("bdID") != null){
			bdID = Integer.parseInt(request.getParameter("bdID"));
		}
		
		BoardDAO boardDao = new BoardDAO();
		Board board = boardDao.getBoard(bdID);
		
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
					<table class="table table-striped" style="border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="3">게시판 글보기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>글 제목</td>
								<td colspan="2"><%=board.getBdTitle() %></td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="2"><%=board.getMemID() %></td>
							</tr>
							<tr>
								<td>작성일자</td>
								<td colspan="2"><%=board.getBdDate() %></td>
							</tr>
							<tr>
								<td>글 내용</td>
								<td colspan="2"><%=board.getBdContent() %></td>
							</tr>
						</tbody>
					</table>
					<a href="/BBS/board/board.jsp" class="btn btn-primary" style="margin:2px">목록</a>
					<!-- 수정은 글쓴이만 수정버튼이 생기게 해야함. -->	
					<%
						if(memID != null && memID.equals(board.getMemID()) || memID.equals("admin")){							
					%>
								<a href="/BBS/board/update.jsp?bdID=<%=bdID %>" class="btn btn-primary" style="margin:2px">수정</a>
								<a href="/BBS/board/deleteAction.jsp?bdID=<%=bdID %>" class="btn btn-primary" style="margin:2px">삭제</a>
					<%							
						}					
					%>				
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>




</body>
</html>


