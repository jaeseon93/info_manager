package co.yedam.ic.kbk.receipt.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import co.yedam.ic.common.BaseDAO;
import co.yedam.ic.kbk.receipt.vo.ReceiptVO;

public class ReceiptDAO extends BaseDAO {

	static ReceiptDAO instance;
	public static ReceiptDAO getInstance(){
		if(instance == null){
			instance = new ReceiptDAO();
		}

		return instance;
	}
	
	String SELECT_MEMBERNO = "SELECT * FROM receipt WHERE memberno = ?";
	String SELECT_MEMBERCODE= "SELECT title, place, stuff, total, note, img, to_char(rctdate,'YYYY-MM-DD') as rctdate FROM receipt WHERE membercode = ? ORDER BY membercode ASC";
	String INSERT = "INSERT INTO receipt (membercode, memberno, title, place, stuff, total, note, img, rctdate, uploaddate)"
					+ "VALUES (RCT_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?, to_date(?,'YYYY-MM-DD'), SYSDATE)";
	String UPDATE = "UPDATE receipt SET title = ?, place = ?, stuff=?, total = ?, note= ?, rctdate = to_date(?,'YYYY-MM-DD') WHERE membercode = ?" ;
	String DELETE = "DELETE FROM receipt WHERE membercode = ?";
	
	
	public ArrayList<ReceiptVO> select_all(Connection conn, ReceiptVO vo) { //홈화면에 뿌려줄 여러개 영수증 배열
		ArrayList<ReceiptVO> list = new ArrayList<ReceiptVO>();
		
		try {
			psmt = conn.prepareStatement(SELECT_MEMBERNO);
			psmt.setInt(1, vo.getMemberno());
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ReceiptVO allVo = new ReceiptVO();
				allVo.setTitle(rs.getString("title"));
				allVo.setTotal(rs.getString("total"));
				allVo.setMembercode(rs.getInt("membercode"));
				list.add(allVo);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return list; 
		
	}
	
	public ReceiptVO select(Connection conn, ReceiptVO vo) {  // 한 사람의 여러개 영수증 중에서 1개만 가지고 옴
		ReceiptVO receipt = null;
		
		try {
			psmt = conn.prepareStatement(SELECT_MEMBERCODE);
			psmt.setInt(1, vo.getMembercode());
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				receipt = new ReceiptVO();
				
				receipt.setTitle(rs.getString("title"));
				receipt.setPlace(rs.getString("place"));
				receipt.setStuff(rs.getString("stuff"));
				receipt.setTotal(rs.getString("total"));
				receipt.setNote(rs.getString("note"));
				receipt.setImg(rs.getString("img"));
				receipt.setRctdate(rs.getString("rctdate"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return receipt;
		
	}
 	public int insert(Connection conn, ReceiptVO vo ) {
		
		int result = 0;
		try {
			
			psmt = conn.prepareStatement(INSERT);
			psmt.setInt(1, vo.getMemberno());
			psmt.setString(2, vo.getTitle());
			psmt.setString(3, vo.getPlace());
			psmt.setString(4, vo.getStuff());
			psmt.setString(5, vo.getTotal());
			psmt.setString(6, vo.getNote());
			psmt.setString(7, vo.getImg());
			psmt.setString(8, vo.getRctdate());
			result = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int update(Connection conn, ReceiptVO vo) {
		
		int result = 0;
		
		try {
			System.out.println("테스트트트");
			psmt = conn.prepareStatement(UPDATE);
			psmt.setString(1, vo.getTitle());
			psmt.setString(2, vo.getPlace());
			psmt.setString(3, vo.getStuff());
			psmt.setString(4, vo.getTotal());
			psmt.setString(5, vo.getNote());
			psmt.setString(6, vo.getRctdate());
			psmt.setInt(7, vo.getMembercode());
			result = psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(result);
		return result;
	}
	
	public int delete(Connection conn, ReceiptVO vo) {
		
		int result = 0;
		try {
			
			psmt = conn.prepareStatement(DELETE);
			psmt.setInt(1, vo.getMembercode());
			result = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
}

