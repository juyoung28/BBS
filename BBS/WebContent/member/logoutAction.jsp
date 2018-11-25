<%@page import="member.MemberDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class="member.Member" scope="page" />
<jsp:setProperty property="memID" name="member" />
<jsp:setProperty property="memPW" name="member" />
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Logout Action</title>
</head>
<body>
	<%
		//web.xml session 검색 30분
		session.invalidate();//세션 무효화	
	%>
	<script>
	location.href = '/BBS/main.jsp';
	</script>
</body>
</html>