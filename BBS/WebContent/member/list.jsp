<%@page import="member.Member"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="util.ReplaceHtml"%>
<%@page import="java.util.ArrayList"%>
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


<title>Member List</title>
</head>
<body>

	<%
		String memID = null;
		if (session.getAttribute("memID").equals("admin")) {
			memID = (String) session.getAttribute("memID");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근권한이 없습니다.')");
			script.println("location.href='/BBS/main.jsp'");		
			script.println("</script>");
		}

		//2. 페이지 넘버 만들기
		int pageNum = 1;
		if (request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
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
							<th>아이디</th>
							<th>이름</th>
							<th>성별</th>
							<th>이메일</th>
						</tr>
					</thead>
					<tbody>
						<%
							MemberDAO memberDAO = new MemberDAO();							
							ArrayList<Member> list = memberDAO.getList(pageNum);
							

							for (Member m : list) {
						%>
						<tr>
							<td><%=m.getMemID()	%></td>
							<td><%=m.getMemName()	%></td>
							<td><%=m.getMemGender()	%></td>
							<td><%=m.getMemEmail()	%></td>							
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				

				<% if(pageNum != 1){ %>
				<a class="btn btn-success"
					href="/BBS/board/list.jsp?pageNum=<%=pageNum - 1%>"
					style="margin: 2px">이전</a>
				<%}
				
				
				if(memberDAO.nextPage(pageNum+1)){
				%>
				
				<a class="btn btn-success"
					href="/BBS/board/list.jsp?pageNum=<%=pageNum + 1%>"
					style="margin: 2px">다음</a>
				<%} %>

				
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>




</body>
</html>


