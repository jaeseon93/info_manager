package co.yedam.ic.jsh.note.vo;

import java.sql.Date;

public class NoteVO {

	private int notecode;
	private int memberno;
	private String title;
	private Date ndate;
	private String ncontent;
	private int key;	
	
	
	public Integer getKey() {
		return key;
	}
	public void setKey(Integer key) {
		this.key = key;
	}
	public void setNotecode(int notecode) {
		this.notecode = notecode;
	}
	public int getNotecode() {
		return notecode;
	}
	public void setNoteno(int notecode) {
		this.notecode = notecode;
	}
	public int getMemberno() {
		return memberno;
	}
	public void setMemberno(int memberno) {
		this.memberno = memberno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getNdate() {
		return ndate;
	}
	public void setNdate(Date ndate) {
		this.ndate = ndate;
	}
	public String getNcontent() {
		return ncontent;
	}
	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}
	
	
}
