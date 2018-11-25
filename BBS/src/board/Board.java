package board;

public class Board {
	private int bdID;
	private String bdTitle;
	private String memID;
	private String bdDate;
	private String bdContent;
	private int bdUsed; //1: 사용, 0: 삭제
	private String bdIP;
	
	
	public int getBdID() {
		return bdID;
	}
	public void setBdID(int bdID) {
		this.bdID = bdID;
	}
	public String getBdTitle() {
		return bdTitle;
	}
	public void setBdTitle(String bdTitle) {
		this.bdTitle = bdTitle;
	}
	public String getMemID() {
		return memID;
	}
	public void setMemID(String memID) {
		this.memID = memID;
	}
	public String getBdDate() {
		return bdDate;
	}
	public void setBdDate(String bdDate) {
		this.bdDate = bdDate;
	}
	public String getBdContent() {
		return bdContent;
	}
	public void setBdContent(String bdContent) {
		this.bdContent = bdContent;
	}
	public int getBdUsed() {
		return bdUsed;
	}
	public void setBdUsed(int bdUsed) {
		this.bdUsed = bdUsed;
	}
	public String getBdIP() {
		return bdIP;
	}
	public void setBdIP(String bdIP) {
		this.bdIP = bdIP;
	}
	
	
	
	

}
