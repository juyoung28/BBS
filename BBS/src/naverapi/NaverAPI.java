package naverapi;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import member.Member;
import member.MemberDAO;

public class NaverAPI {
	public String access_token(String access_token) {
		String token = access_token;// 네이버 로그인 접근 토큰;
        String header = "Bearer " + token; // Bearer 다음에 공백 추가
        
        try {
            String apiURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", header);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
            
            Member m = new Member();           
            
            JSONParser parser = new JSONParser();
            JSONObject json = (JSONObject)parser.parse(response.toString());
            JSONObject res = (JSONObject)json.get("response");
            
            String id = res.get("email").toString();
        	int index = id.indexOf("@");
        	id = id.substring(0, index)+"(Naver)";
        	
            Member mm = new MemberDAO().selectOne(id); //정보가 있는지 확인
            if(mm == null) {            	
	            m.setMemID(id);
	            m.setMemName(res.get("name").toString());
	            m.setMemGender(res.get("gender").toString());
	            m.setMemEmail(res.get("email").toString());
	            int a = new MemberDAO().join(m);
	            if(a == 1) {
	            	System.out.println("네이버로 가입 성공");
	            } else {
	            	System.out.println("네이버로 가입 실패");
	            }
            	return id;
            }else {
            	System.out.println("이미 가입된 내역");
            	return id;
            }
        } catch (Exception e) {
        	System.out.println("회원정보 가져오기 실패");
            e.printStackTrace();
        }
        return null;
	}
}
