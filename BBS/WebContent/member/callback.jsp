<%@page import="java.io.PrintWriter"%>
<%@page import="naverapi.NaverAPI"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>네이버로그인</title>
</head>
<body>
	<%
		String clientId = "G476mts_Hl7_Q5_k9hD2";//애플리케이션 클라이언트 아이디값";
		String clientSecret = "UP_hbK2Xu_";//애플리케이션 클라이언트 시크릿값";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://13.209.49.133:8080/BBS/member/callback.jsp", "UTF-8");
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;
		String access_token = "";
		String refresh_token = "";
		System.out.println("apiURL=" + apiURL);
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.println("responseCode=" + responseCode);
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {
				out.println(res.toString());
				JSONParser parser = new JSONParser();
				JSONObject json = (JSONObject)parser.parse(res.toString());
				System.out.println(json);
				access_token = json.get("access_token").toString();
				System.out.println("access : " + access_token);
				
				String id = new NaverAPI().access_token(access_token);
				session.setAttribute("memID", id);
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('네이버아이디로 로그인 되었습니다.')");
				script.println("location.href = '/BBS/main.jsp'");
				script.println("</script>");
				
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	%>
</body>
</html>