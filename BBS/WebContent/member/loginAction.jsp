<%@page import="member.MemberDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="member.Member" scope="page"/>
<jsp:setProperty property="memID" name="member"/>
<jsp:setProperty property="memPW" name="member"/>    
<!DOCTYPE html>
<html>
<head>
<meta content="charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Login Action</title>
</head>
<body>
<%	
	String memID = null;

	if(session.getAttribute("memID") != null){
		memID = (String)session.getAttribute("memID");
	}
	
	if(memID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href='/BBS/main.jsp'");
		// 404에러 발생!! f12에서  network에서 f5로 주소 확인 필요!!
		// 앞에 슬러시가 있으면 절대경로 : http://localhost:8000/BBS/main.jsp
		// 앞에 슬러시가 없으면 상대경로 : http://localhost:8000/BBS/member/BBS/main.jsp
		script.println("</script>");
	}
	
	MemberDAO memberDAO = new MemberDAO();
	int result = memberDAO.login(member.getMemID(), member.getMemPW());
	
	//memID와 memPW null값 체크 해야하는데 일단 생략~
	if(result == 1){//정상적인 로그인
		session.setAttribute("memID", member.getMemID());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='/BBS/main.jsp'");
		script.println("</script>");
		System.out.println("session 값 : " +session.getAttribute("memID"));
		
		
		
		
		if(request.getParameter("remID") != null){
			Cookie cookie = new Cookie("cookieID", member.getMemID());
			cookie.setMaxAge(600000);// 초단위
			response.addCookie(cookie);
			System.out.println(cookie.getName() +" : "+ cookie.getValue());						
		}else{
			Cookie c = new Cookie("cookieID", null);
			c.setMaxAge(0);// 초단위
			response.addCookie(c);
		} 

		
	} else if (result == 0){//비밀번호 틀린 것.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디/비밀번호를 다시 확인해 주세요.')");
		script.println("history.back()");
		script.println("</script>");		
	} else if(result == -2){//데이터 베이스 오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터 베이스 오류입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}

%>
  
</body>
</html>