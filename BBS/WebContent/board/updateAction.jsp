<%@page import="java.net.InetAddress"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page"></jsp:useBean>
<jsp:setProperty property="bdTitle" name="board"/>
<jsp:setProperty property="bdContent" name="board"/>
<jsp:setProperty property="bdID" name="board"/>

<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Update Action</title>
</head>
<body>
<%
	String memID = null;
	if(session.getAttribute("memID") != null){
		memID = (String)session.getAttribute("memID");
	}
	
	if(memID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href='/BBS/member/login.jsp'");		
		script.println("</script>");
	}else {
		
		BoardDAO boardDAO = new BoardDAO();
		//update 함수 구현
		int result = boardDAO.update(board);
		if(result ==1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글이 정상적으로 수정되었습니다.')");
			script.println("location.href='/BBS/board/board.jsp'");		
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 수정에 실패하였습니다.')");
			script.println("history.back()");		
			script.println("</script>");
		}
		
		
	}
	

%>
  
</body>
</html>