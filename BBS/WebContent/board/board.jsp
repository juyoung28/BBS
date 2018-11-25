<%@page import="java.io.PrintWriter"%>
<%@page import="util.ReplaceHtml"%>
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
		//1.세션받기
		String memID = null;
		if (session.getAttribute("memID") != null) {
			memID = (String) session.getAttribute("memID");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href='/BBS/member/login.jsp'");		
			script.println("</script>");
		}

		//2. 페이지 넘버 만들기
		int pageNum = 1;
		if (request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		//3. 검색조건으로 접근했는지 확인
		String word = null;
		String col = null;
		if (request.getParameter("word") != null && !request.getParameter("word").equals("")) {
			word = request.getParameter("word");
			if (request.getParameter("col") == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('검색조건이 올바르지 않습니다.')");
				script.println("location.href = '/BBS/board/board.jsp'");
				script.println("</script>");
			} else {
				col = request.getParameter("col");
			}

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

				<table class="table table-striped" style="border: 1px solid #dddddd">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<%if(memID.equals("admin")){ %>
							<th>노출</th>
							<%} %>
						</tr>
					</thead>
					<tbody>
						<%
							BoardDAO boardDAO = new BoardDAO();
							ArrayList<Board> list = null;
							if (word == null) {
								if(memID.equals("admin")){
									list = boardDAO.getListAd(pageNum);
								}else{
									list = boardDAO.getList(pageNum);
								}
							} else {

								if (col.equals("rname")) {
									
									list = boardDAO.searchName(word, pageNum);

								} else if (col.equals("title_content")) {
									
									list = boardDAO.search(word, pageNum);
								}
							}

							for (Board b : list) {
						%>
						<tr>
							<td><%=b.getBdID()%></td>
							<td><a href="/BBS/board/view.jsp?bdID=<%=b.getBdID()%>">
									<%=ReplaceHtml.getCode(b.getBdTitle())%>
							</a></td>
							<td><%=b.getMemID()%></td>
							<td><%=b.getBdDate()%></td>
							<%if(memID.equals("admin")){ %>
							<td><%=b.getBdUsed() %></td>
							<%} %>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<div class='container'>
					<form name='frm' method='GET' action='/BBS/board/board.jsp'>
						<aside style='float: right;'>
							<select name='col'>
								<!-- 검색 컬럼 -->
								<option value='rname'>이름</option>
								<option value='title_content'>제목+내용</option>
							</select> <input type='text' name='word' value=''>							
								
							<button class="btn btn-success" type='submit'>검색</button>
						</aside>
					</form>
					<div class='menu_line' style='clear: both;'></div>
				</div>

				<%
					if (pageNum != 1) {
						if (word != null && col != null) {
				%>
				<a class="btn btn-success"
					href="/BBS/board/board.jsp?pageNum=<%=pageNum - 1%>&col=<%=col%>&word=<%=word%>"
					style="margin: 2px">이전</a>
				<%
					} else {
				%>
				<a class="btn btn-success"
					href="/BBS/board/board.jsp?pageNum=<%=pageNum - 1%>"
					style="margin: 2px">이전</a>
				<%
					}
					}
					if (word != null && col != null) {
						if (col.equals("rname") && boardDAO.nextPageSN(word, pageNum + 1)) {							
				%>
				<a class="btn btn-success"
					href="/BBS/board/board.jsp?pageNum=<%=pageNum + 1%>&col=<%=col%>&word=<%=word%>"
					style="margin: 2px">다음</a>
				<%					
						} else if (col.equals("title_content") && boardDAO.nextPageS(word, pageNum + 1)) {						
				%>
				<a class="btn btn-success"
					href="/BBS/board/board.jsp?pageNum=<%=pageNum + 1%>&col=<%=col%>&word=<%=word%>"
					style="margin: 2px">다음</a>
				<%					
						}
					} else if (boardDAO.nextPage(pageNum + 1)) {
				%>
				<a class="btn btn-success"
					href="/BBS/board/board.jsp?pageNum=<%=pageNum + 1%>"
					style="margin: 2px">다음</a>
				<%
					}					
				%>
				
				<a class="btn btn-primary float-right" href="/BBS/board/write.jsp"
					style="margin: 2px">글쓰기</a>
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>




</body>
</html>


