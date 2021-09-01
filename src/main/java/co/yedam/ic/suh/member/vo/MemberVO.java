package co.yedam.ic.suh.member.vo;

public class MemberVO{
	private int memberNo;
	private String email;
	private String password;
	private String salt;
	private String phone;
	private String googleAuth;

	public int getMemberNo(){
		return memberNo;
	}

	public void setMemberNo(int memberNo){
		this.memberNo = memberNo;
	}

	public String getEmail(){
		return email;
	}

	public void setEmail(String email){
		this.email = email;
	}

	public String getPassword(){
		return password;
	}

	public void setPassword(String password){
		this.password = password;
	}

	public String getSalt(){
		return salt;
	}

	public void setSalt(String salt){
		this.salt = salt;
	}

	public String getPhone(){
		return phone;
	}

	public void setPhone(String phone){
		this.phone = phone;
	}

	public String getGoogleAuth(){
		return googleAuth;
	}

	public void setGoogleAuth(String googleAuth){
		this.googleAuth = googleAuth;
	}
}
