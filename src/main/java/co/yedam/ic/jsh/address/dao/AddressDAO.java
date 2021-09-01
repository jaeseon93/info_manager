package co.yedam.ic.jsh.address.dao;

import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.jsp.tagext.TryCatchFinally;

import co.yedam.ic.common.BaseDAO;
import co.yedam.ic.jsh.address.vo.AddressVO;
import co.yedam.ic.jsh.note.vo.NoteVO;

public class AddressDAO extends BaseDAO {
	static AddressDAO instance;

	public static AddressDAO getInstance() {
		if ( instance == null ) {
			instance = new AddressDAO();
		}
		return instance;
	}

	private AddressDAO() {

	}

	String INSERT = "insert into address(addno,memberno,aname,agender,abirth,address,aphone,aemaile,acompany,grade,adate,amemo)  values(addno_seq.nextval,"
			+ "?,?,?,?,?,?,?,?,?,to_date(?,'YYYY-MM-DD'),?)";

	public int ainsert(Connection conn,AddressVO vo) {
		int result = 0;
		try {
			System.out.println("aDate : " + vo.getAdate());
			psmt = conn.prepareStatement(INSERT);
			psmt.setInt(1, vo.getMemberno());
			psmt.setString(2, vo.getAname());
			psmt.setString(3, vo.getAgender());
			psmt.setString(4, vo.getAbirth());
			psmt.setString(5, vo.getAddress());
			psmt.setString(6, vo.getAphone());
			psmt.setString(7, vo.getAemaile());
			psmt.setString(8, vo.getAcompany());
			psmt.setString(9, vo.getGrade());
			psmt.setString(10, vo.getAdate());
			psmt.setString(11,vo.getAmemo());
			result = psmt.executeUpdate();   
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	String SELECT ="select aname,agender,abirth,address,aphone,aemaile,acompany,grade,adate,amemo,addno from address where memberno = ?";
	public ArrayList<AddressVO> select (Connection conn , AddressVO vo){
		ArrayList<AddressVO> list = new ArrayList<AddressVO>();
		
		try {
			psmt = conn.prepareStatement(SELECT);
			psmt.setInt(1, vo.getMemberno());
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				AddressVO aVO = new AddressVO();
				aVO.setAname(rs.getString("aname"));
				aVO.setAgender(rs.getString("agender"));
				aVO.setAbirth(rs.getString("abirth"));
				aVO.setAddress(rs.getString("address"));
				aVO.setAphone(rs.getString("aphone"));
				aVO.setAemaile(rs.getString("aemaile"));
				aVO.setAcompany(rs.getString("acompany"));
				aVO.setGrade(rs.getString("grade"));
				aVO.setAdate(rs.getString("adate"));
				aVO.setAmemo(rs.getString("amemo"));
				aVO.setAddno(rs.getInt("addno"));
				list.add(aVO);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	String SELECTONE = "SELECT ANAME,AGENDER,ABIRTH,ADDRESS,APHONE,AEMAILE,ACOMPANY,GRADE,to_char(ADATE,'YYYY-MM-DD') as ADATE, AMEMO FROM ADDRESS WHERE ADDNO=?";
	public AddressVO selectone(Connection conn, AddressVO vo) {
		AddressVO aVO = null;
		try {
			psmt = conn.prepareStatement(SELECTONE);
			psmt.setInt(1, vo.getAddno());
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				aVO = new AddressVO();
				aVO.setAname(rs.getString("aname"));
				aVO.setAgender(rs.getString("agender"));
				aVO.setAbirth(rs.getString("abirth"));
				aVO.setAddress(rs.getString("address"));
				aVO.setAphone(rs.getString("aphone"));
				aVO.setAemaile(rs.getString("aemaile"));
				aVO.setAcompany(rs.getString("acompany"));
				aVO.setGrade(rs.getString("grade"));
				aVO.setAdate(rs.getString("adate"));
				aVO.setAmemo(rs.getString("amemo"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return aVO;

	}
	String UPDATE = "UPDATE ADDRESS SET ANAME=?,AGENDER=?,ABIRTH=?,ADDRESS=?,APHONE=?,AEMAILE=?,ACOMPANY=?,GRADE=?,ADATE = to_date(?,'YYYY-MM-DD'),AMEMO=?  WHERE ADDNO =?";
	public int update(Connection conn, AddressVO vo) {
		int result = 0;
		System.out.println();
		try {
			psmt=conn.prepareStatement(UPDATE);
			psmt.setString(1, vo.getAname());
			psmt.setString(2, vo.getAgender());
			psmt.setString(3, vo.getAbirth());
			psmt.setString(4, vo.getAddress());
			psmt.setString(5, vo.getAphone());
			psmt.setString(6, vo.getAemaile());
			psmt.setString(7, vo.getAcompany());
			psmt.setString(8, vo.getGrade());
			psmt.setString(9, vo.getAdate());
			psmt.setString(10,vo.getAmemo());
			psmt.setInt(11, vo.getAddno());
			result = psmt.executeUpdate();
			System.out.println("업데이트문 result"+result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	
	}
	String DELETE = "delete from address where addno = ?";
	public int delete(Connection conn, AddressVO vo) {
		int result = 0;
		try {
			psmt = conn.prepareStatement(DELETE);
			psmt.setInt(1, vo.getAddno());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
}
