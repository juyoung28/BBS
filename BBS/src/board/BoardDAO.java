package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public BoardDAO() {
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

	//paging 10개씩
	public ArrayList<Board> getList(int pageNum){
		ArrayList<Board> list = new ArrayList<>();
		String sql = "select bdid, bdtitle, memid, bddate, bdcontent, bdused, bdip " + 
				"from board_1 " + 
				"where bdused=1 " + 
				"order by bdid desc " + 
				"limit ?,10";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pageNum*10-10);						
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				board.setBdID(rs.getInt("bdid"));
				board.setBdTitle(rs.getString("bdtitle"));
				board.setMemID(rs.getString("memid"));
				board.setBdDate(rs.getString("bddate"));
				board.setBdContent(rs.getString("bdcontent"));				
				list.add(board);				
			}			
			
		} catch (Exception e) {
			System.out.println("getList sql error");
			e.printStackTrace();
			return null;
		}
		return list;
	}//end of getList
	
	public ArrayList<Board> getListAd(int pageNum){
		ArrayList<Board> list = new ArrayList<>();
		String sql = "select bdid, bdtitle, memid, bddate, bdcontent, bdused, bdip " + 
				"from board_1 " +				
				"order by bdid desc " + 
				"limit ?,10";
		try {
			pstmt = conn.prepareStatement(sql);			
			pstmt.setInt(1, pageNum*10-10);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				board.setBdID(rs.getInt("bdid"));
				board.setBdTitle(rs.getString("bdtitle"));
				board.setMemID(rs.getString("memid"));
				board.setBdDate(rs.getString("bddate"));
				board.setBdContent(rs.getString("bdcontent"));
				board.setBdUsed(rs.getInt("bdused"));
				list.add(board);				
			}			
			
		} catch (Exception e) {
			System.out.println("getList sql error");
			e.printStackTrace();
			return null;
		}
		return list;
	}//end of getListAd
	
	public int write(Board board) {
		String sql = "insert into board_1(bdtitle, memid, bddate, bdcontent, bdused, bdip) values(?,?,now(),?,1,?);";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getBdTitle());
			System.out.println("아이디 : " + board.getMemID());
			pstmt.setString(2, board.getMemID());
			pstmt.setString(3, board.getBdContent());
			pstmt.setString(4, board.getBdIP());
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			System.out.println("write sql error");
			e.printStackTrace();
			
		}
		return -2;
	}//end of write
	
	public boolean nextPage(int pageNum){		
		String sql = "select bdid, bdtitle, memid, bddate, bdcontent, bdused, bdip " + 
				"from board_1 " + 
				"where bdused=1 " + 
				"order by bdid desc " + 
				"limit ?,10";
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
	
	public Board getBoard(int bdID) {
		String sql = "select * from board_1 where bdid = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bdID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Board board = new Board();
				board.setBdTitle(rs.getString("bdtitle"));
				board.setMemID(rs.getString("memid"));
				board.setBdDate(rs.getString("bddate"));
				board.setBdContent(rs.getString("bdcontent"));
				
				return board;
			}
					
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public int delete(int bdID) {
		String sql = "update board_1 set bdused = 0 where bdid= ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bdID);
			pstmt.executeUpdate();
			return 1; //정상
			
		} catch (Exception e) {
				System.out.println("delete sql error");
				e.printStackTrace();
		}
		
		return -1; //실패
	}
	
	public int update(Board board) {
		String sql = "update board_1 set bdtitle =?, bdcontent =? where bdid =?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getBdTitle());
			pstmt.setString(2, board.getBdContent());
			pstmt.setInt(3, board.getBdID());
			pstmt.executeUpdate();
			return 1; //정상
			
		} catch (Exception e) {
			System.out.println("update sql error");
			e.printStackTrace();
		}
		
		return -1; //실패
	}
	
	public ArrayList<Board> getRealTimeData() {
		ArrayList<Board> list = new ArrayList<>();
		String sql = "select bdid, bdtitle, memid, bddate, bdcontent, bdused, bdip " + 
				"from board_1 " + 
				"where bdused=1 " + 
				"order by bdid desc " + 
				"limit 0, 3";
		
		System.out.println("getRealTime : " + sql);
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board b = new Board();
				b.setBdID(rs.getInt("bdid"));
				b.setBdTitle(rs.getString("bdtitle"));
				b.setMemID(rs.getString("memid"));
				b.setBdDate(rs.getString("bddate"));
				list.add(b);
			}
			pstmt.close();
			rs.close();
			conn.close();
			
			return list;
		} catch (Exception e) {
			e.printStackTrace();			
		}
		return null;
		
	}
	
	public ArrayList<Board> search(String word, int pageNum){
		ArrayList<Board> list = new ArrayList<>();
		String sql = "select bdid, bdtitle, memid, bddate, bdcontent, bdused, bdip " + 
				"from board_1 " + 
				"where bdused=1 and (bdtitle like ? or bdcontent like ?) " + 
				"order by bdid desc" + 
				"limit ?,10";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+word+"%");
			pstmt.setString(2, "%"+word+"%");			
			pstmt.setInt(3, pageNum*10-10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				board.setBdID(rs.getInt("bdid"));
				board.setBdTitle(rs.getString("bdtitle"));
				board.setMemID(rs.getString("memid"));
				board.setBdDate(rs.getString("bddate"));
				board.setBdContent(rs.getString("bdcontent"));
				list.add(board);				
			}			
			
		} catch (Exception e) {
			System.out.println("search sql error");
			e.printStackTrace();
			return null;
		}
		return list;
	}//end of search
	
	public ArrayList<Board> searchName(String word, int pageNum){
		ArrayList<Board> list = new ArrayList<>();
		String sql = "select bdid, bdtitle, memid, bddate, bdcontent, bdused, bdip " + 
				"from board_1 " + 
				"where bdused=1 and (memid like ? or memid like upper(?) or memid like lower(?)) " + 
				"order by bdid desc " + 
				"limit ?,10";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+word+"%");
			pstmt.setString(2, "%"+word+"%");
			pstmt.setString(3, "%"+word+"%");			
			pstmt.setInt(4, pageNum*10-10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				board.setBdID(rs.getInt("bdid"));
				board.setBdTitle(rs.getString("bdtitle"));
				board.setMemID(rs.getString("memid"));
				board.setBdDate(rs.getString("bddate"));
				board.setBdContent(rs.getString("bdcontent"));
				list.add(board);				
			}			
			
		} catch (Exception e) {
			System.out.println("searchName sql error");
			e.printStackTrace();
			return null;
		}
		return list;
	}//end of searchName
	
	public boolean nextPageSN(String word, int pageNum){		
		String sql = "select bdid, bdtitle, memid, bddate, bdcontent, bdused, bdip " + 
				"from board_1 " + 
				"where bdused=1 and (memid like ? or memid like upper(?) or memid like lower(?)) " + 
				"order by bdid desc " + 
				"limit ?,10";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+word+"%");
			pstmt.setString(2, "%"+word+"%");
			pstmt.setString(3, "%"+word+"%");
			pstmt.setInt(4, pageNum*10-10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			System.out.println("nextPageSN sql error");
			e.printStackTrace();			
		}
		return false;
	}//end of nextPage
	
	public boolean nextPageS(String word, int pageNum){		
		String sql = "select bdid, bdtitle, memid, bddate, bdcontent, bdused, bdip " + 
				"from board_1 " + 
				"where bdused=1 and (bdtitle like ? or bdcontent like ?) " + 
				"order by bdid desc" + 
				"limit ?,10";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+word+"%");
			pstmt.setString(2, "%"+word+"%");
			pstmt.setInt(3, pageNum*10-10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
			
		} catch (Exception e) {
			System.out.println("nextPageS sql error");
			e.printStackTrace();			
		}
		return false;
	}//end of nextPage
	
	

}
