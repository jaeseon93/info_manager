package co.yedam.ic.suh.member.dao;

import co.yedam.ic.common.BaseDAO;
import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.suh.member.vo.MemberVO;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberDAO extends BaseDAO{

	static MemberDAO instance;
	public static MemberDAO getInstance(){
		if(instance == null){
			instance = new MemberDAO();
		}

		return instance;
	}

	private MemberDAO(){}

	String SELECT = "SELECT * FROM MEMBER WHERE EMAIL = ?";
	String SELECT_BY_MEMBERNO = "SELECT * FROM MEMBER WHERE MEMBERNO = ?";
	String INSERT = "insert into member (MEMBERNO, EMAIL, PASSWORD, SALT) values (member_seq.nextval, ?, ?, ?)";
	String UPDATE = "UPDATE MEMBER SET email = ?, password = ?, phone = ?, salt = ? WHERE memberno = ?";
	String UPDATE_PASSWORD = "UPDATE member SET password = ? WHERE memberno = ? ";
	String UPDATE_OTP_KEY = "UPDATE MEMBER SET GOOGLEAUTH = ? WHERE MEMBERNO = ?";
	String SELECT_ALL = "SELECT * FROM MEMBER";

	public ArrayList<MemberVO> select_all(Connection conn){
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		try{
			psmt = conn.prepareStatement(SELECT_ALL);
			rs = psmt.executeQuery();

			while(rs.next()){
				MemberVO memberVO = new MemberVO();
				memberVO.setEmail(rs.getString("email"));
				memberVO.setPassword(rs.getString("password"));
				memberVO.setPhone(rs.getString("phone"));
				list.add(memberVO);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return list;
	}

	public MemberVO select(Connection conn, MemberVO vo){
		MemberVO member = null;
		try{
			psmt = conn.prepareStatement(SELECT);
			psmt.setString(1, vo.getEmail() );
			rs = psmt.executeQuery();

			if( rs.next() ){
				member = new MemberVO();

				member.setMemberNo(rs.getInt("memberNo"));
				member.setEmail(rs.getString("email"));
				member.setPassword(rs.getString("password"));
				member.setSalt(rs.getString("salt"));
				member.setPhone(rs.getString("phone"));
				member.setGoogleAuth(rs.getString("googleAuth"));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return member;
	}

	public MemberVO selectByNum(Connection conn, MemberVO vo){
		MemberVO member = null;
		try{

			psmt = conn.prepareStatement(SELECT_BY_MEMBERNO);
			psmt.setInt(1, vo.getMemberNo() );
			rs = psmt.executeQuery();

			if( rs.next() ){
				member = new MemberVO();

				member.setMemberNo(rs.getInt("memberNo"));
				member.setEmail(rs.getString("email"));
				member.setPassword(rs.getString("password"));
				member.setSalt(rs.getString("salt"));
				member.setPhone(rs.getString("phone"));
				member.setGoogleAuth(rs.getString("googleAuth"));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return member;
	}

	public int insert(Connection conn,  MemberVO vo ){
		int result = 0;
		try{
			psmt = conn.prepareStatement(INSERT);
			psmt.setString(1, vo.getEmail());
			psmt.setString(2, vo.getPassword());
			psmt.setString(3, vo.getSalt());
			result = psmt.executeUpdate();

		}catch(SQLException e){
			e.printStackTrace();
		}
		return result;
	}

	public int updateOTPKey(Connection conn , MemberVO vo ){
		int result = 0;
		try{
			psmt = conn.prepareStatement(UPDATE_OTP_KEY);
			psmt.setString(1, vo.getGoogleAuth());
			psmt.setInt(2, vo.getMemberNo());
			result = psmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}

		return result;
	}

	public int update(Connection conn, MemberVO vo){
		int result = 0;
		try{
			psmt = conn.prepareStatement(UPDATE);
			psmt.setString(1, vo.getEmail());
			psmt.setString(2, vo.getPassword());
			psmt.setString(3, vo.getPhone());
			psmt.setString(4, vo.getSalt());
			psmt.setInt(5, vo.getMemberNo());

			result = psmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}

		return result;
	}
}
