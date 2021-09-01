package co.yedam.ic.hjs.passwords.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import co.yedam.ic.common.BaseDAO;
import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.hjs.passwords.vo.PasswordsVo;

public class PasswordsDAO extends BaseDAO {
	String SELECT_BY_MEMBERNO = "SELECT * FROM PASSWORDS WHERE MEMBERNO = ?";
	String SELECT_BY_IDXNO = "SELECT * FROM PASSWORDS WHERE IDXNO = ? ORDER BY idxno ASC";
	String INSERT = "INSERT INTO PASSWORDS (IDXNO, MEMBERNO, URL, SITENAME, SITEID, SITEPW, PDATE,NOTE)" 
				  + "values(pw_seq.NEXTVAL,?,?,?,?,?,SYSDATE,?)";
	String UPDATE = "UPDATE PASSWORDS SET URL=?, SITENAME=?, SITEID=?, SITEPW=?, NOTE=? WHERE IDXNO=?"; 
	String DELETE = "DELETE FROM PASSWORDS WHERE IDXNO=?";
	
	static PasswordsDAO instance = new PasswordsDAO();
	public static PasswordsDAO getInstance() {
		return instance;
	}
	
	public ArrayList<PasswordsVo> select_all(Connection conn, PasswordsVo vo) { // 비밀번호 홈부분에서 뿌려줄거
		ArrayList<PasswordsVo> list = new ArrayList<PasswordsVo>();
		
		try {
			psmt = conn.prepareStatement(SELECT_BY_MEMBERNO);
			psmt.setInt(1, vo.getMemberno());
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				PasswordsVo pwVo = new PasswordsVo(); 
				pwVo.setSitename(rs.getString("sitename"));
				pwVo.setUrl(rs.getString("url"));
				pwVo.setIdxno(rs.getInt("idxno"));
				list.add(pwVo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public PasswordsVo select(Connection conn, PasswordsVo vo) { // 한개의 값만 가지고오는거
		PasswordsVo pw = null;
		try {
			psmt = conn.prepareStatement(SELECT_BY_IDXNO);
			psmt.setInt(1, vo.getIdxno());
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				pw = new PasswordsVo();
				pw.setUrl(rs.getString("url"));
				pw.setSiteid(rs.getString("siteid"));
				pw.setSitename(rs.getString("sitename"));
				pw.setSitepw(rs.getString("sitepw"));
				pw.setNote(rs.getString("note"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return pw;
	}


	public int insert (Connection conn, PasswordsVo vo) {
		int n = 0;
		try {
			psmt = conn.prepareStatement(INSERT);
			psmt.setInt(1, vo.getMemberno());
			psmt.setString(2, vo.getUrl());
			psmt.setString(3, vo.getSitename());
			psmt.setString(4, vo.getSiteid());
			psmt.setString(5, vo.getSitepw());
			psmt.setString(6, vo.getNote());
			n = psmt.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
	
	public int update (Connection conn, PasswordsVo vo) {
		int n = 0;
		try {
			psmt = conn.prepareStatement(UPDATE);
			psmt.setString(1, vo.getUrl());
			psmt.setString(2, vo.getSitename());
			psmt.setString(3, vo.getSiteid());
			psmt.setString(4, vo.getSitepw());
			psmt.setString(5, vo.getNote());
			psmt.setInt(6, vo.getIdxno());
			n = psmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
	
	public int delete (Connection conn, PasswordsVo vo) {
		int n = 0;
		try {
			psmt = conn.prepareStatement(DELETE);
			psmt.setInt(1, vo.getIdxno());
			n = psmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return n;
	}
	
	
}
