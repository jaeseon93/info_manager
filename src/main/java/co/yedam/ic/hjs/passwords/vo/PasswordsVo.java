package co.yedam.ic.hjs.passwords.vo;

import java.util.Date;

public class PasswordsVo {
	private int idxno;
	private int memberno;
	private String url;
	private String sitename;
	private String siteid;
	private String sitepw;
	private Date pdate;
	private String note;

	public PasswordsVo() {
		// TODO Auto-generated constructor stub
	}

	public int getIdxno() {
		return idxno;
	}

	public void setIdxno(int idxno) {
		this.idxno = idxno;
	}

	public int getMemberno() {
		return memberno;
	}

	public void setMemberno(int memberno) {
		this.memberno = memberno;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getSitename() {
		return sitename;
	}

	public void setSitename(String sitename) {
		this.sitename = sitename;
	}

	public String getSiteid() {
		return siteid;
	}

	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}

	public String getSitepw() {
		return sitepw;
	}

	public void setSitepw(String sitepw) {
		this.sitepw = sitepw;
	}

	public Date getPdate() {
		return pdate;
	}

	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@Override
	public String toString() {
		return "PasswordsVo [idxno=" + idxno + ", memberno=" + memberno + ", url=" + url + ", sitename=" + sitename
				+ ", siteid=" + siteid + ", sitepw=" + sitepw + ", pdate=" + pdate + ", note=" + note + "]";
	}



}
