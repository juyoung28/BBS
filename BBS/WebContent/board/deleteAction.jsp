<%@page import="java.net.InetAddress"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Delete Action</title>
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
		int bdID = 0;
		if(request.getParameter("bdID") != null){
			bdID = Integer.parseInt(request.getParameter("bdID"));			
		}
		BoardDAO boardDAO = new BoardDAO();
		//delete 함수 구현
		int result = boardDAO.delete(bdID);
		
		if(result ==1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글이 정상적으로 삭제되었습니다.')");
			script.println("location.href = '/BBS/board/board.jsp'");		
			script.println("</script>");			
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글이 정상적으로 삭제되지 않았습니다.')");
			script.println("history.back()");		
			script.println("</script>");
		}
	}
	

%>
  
</body>
</html>