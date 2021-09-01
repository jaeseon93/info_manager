package co.yedam.ic.kbk.receipt.vo;

import java.sql.Date;

public class ReceiptVO {
	private int membercode;
	private int memberno;
	private String title;
	private String place;
	private String stuff;
	private String total;
	private String note;
	private String img;
	private String rctdate;
	private Date uploaddate;

	public int getMembercode() {
		return membercode;
	}

	public void setMembercode(int membercode) {
		this.membercode = membercode;
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

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getStuff() {
		return stuff;
	}

	public void setStuff(String stuff) {
		this.stuff = stuff;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getRctdate() {
		return rctdate;
	}

	public void setRctdate(String rctdate) {
		this.rctdate = rctdate;
	}

	public Date getUploaddate() {
		return uploaddate;
	}

	public void setUploaddate(Date uploaddate) {
		this.uploaddate = uploaddate;
	}

	@Override
	public String toString() {
		return "ReceiptVO [membercode=" + membercode + ", memberno=" + memberno + ", title=" + title + ", place="
				+ place + ", stuff=" + stuff + ", total=" + total + ", note=" + note + ", img=" + img + ", rctdate="
				+ rctdate + ", uploaddate=" + uploaddate + "]";
	}
	
	

}