package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public MemberDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/TestDB");
			conn = ds.getConnection();
			System.out.println("DBCP 연결 성공");
			// etc.
		} catch (Exception e) {
			System.out.println("DBCP 연결 오류");
			e.printStackTrace();
		}
	}// end of constructor

	public int join(Member member) {
		String sql = "insert into member_1 values(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemID());
			pstmt.setString(2, member.getMemPW());
			pstmt.setString(3, member.getMemName());
			pstmt.setString(4, member.getMemGender());
			pstmt.setString(5, member.getMemEmail());
			
			pstmt.executeUpdate();
			return 1; // 회원가입 성공
		} catch (Exception e) {
			System.out.println("join sql error");
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}// end of join

	public int login(String memID, String memPW) {
		String sql = "select mempw from member_1 where memid = ? and mempw=?";
		System.out.println("login sql : " + sql);

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memID);
			pstmt.setString(2, memPW);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return 1; // 로그인 성공
			} else {
				return 0; // 로그인 실패
			}
		} catch (Exception e) {
			System.out.println("login sql error");
			e.printStackTrace();
		}

		return -2; // 데이터 베이스 오류
	}// end of login
	
	public Member selectOne(String memID) {		
		String sql = "select memname, memgender, mememail from member_1 where memid = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memID);
			rs = pstmt.executeQuery(); //rs의 커서가 0번지에 있음
			//rs.next() 함수 호출 커서가 1씩 증가
			//rs.next() 함수는 boolean 값을 리턴
			if(rs.next()) { //데이터가 1행 이상이라면 if가 아니라 while문을 써야 함.
				Member member = new Member();
				member.setMemID(memID);
				member.setMemName(rs.getString("memname"));
				member.setMemGender(rs.getString("memgender"));
				member.setMemEmail(rs.getString("mememail"));
				return member;
			}else {
				
			}
			
		} catch (Exception e) {
			System.out.println("selectOne sql error");
			e.printStackTrace();
		}

		return null;
	}//end of selectOne
	
	public ArrayList<Member> getList(int pageNum){
		ArrayList<Member> list = new ArrayList<>();
		String sql = "select * from member_1 limit ?,10";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pageNum*10-10);	
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member member = new Member();
				member.setMemID(rs.getString("memid"));
				member.setMemName(rs.getString("memname"));
				member.setMemGender(rs.getString("memgender"));
				member.setMemEmail(rs.getString("mememail"));
				list.add(member);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getList sql error");
			return null;
		}
		
		return list;
	}//end of getList
	
	public boolean nextPage(int pageNum){		
		String sql = "select * from member_1 limit ?,10";
		try {
			pstmt = conn.prepareStatement(sql);			
			pstmt.setInt(1, pageNum*10-10);			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			System.out.println("nextPage sql error");
			e.printStackTrace();			
		}
		return false;
	}//end of nextPage

}
