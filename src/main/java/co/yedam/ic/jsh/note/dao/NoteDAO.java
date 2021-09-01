package co.yedam.ic.jsh.note.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import co.yedam.ic.common.BaseDAO;
import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.hjs.passwords.vo.PasswordsVo;
import co.yedam.ic.jsh.note.vo.NoteVO;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;

public class NoteDAO extends BaseDAO {

	static NoteDAO instance;

	public static NoteDAO getInstance() {
		if (instance == null) {
			instance = new NoteDAO();
		}

		return instance;
	}

	private NoteDAO() {
	}

	String INSERT = "insert into Note (NOTECODE,MEMBERNO,TITLE,NDATE, NCONTENT) values(notecode_seq.nextval,?,?,SYSDATE,?)";

	public int insert(Connection conn, NoteVO vo) {
		int result = 0;
		System.out.println("result : " + result);
		System.out.println("memberno:" + vo.getMemberno());
		System.out.println("ncontent:" + vo.getNcontent());
		System.out.println("notetitle:" + vo.getTitle());
		try {
			psmt = conn.prepareStatement(INSERT);
			psmt.setInt(1, vo.getMemberno());
			psmt.setString(2, vo.getTitle());
			psmt.setString(3, vo.getNcontent());
			result = psmt.executeUpdate();
			System.out.println("result : " + result);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;

	}

	String UPDATE = "UPDATE NOTE SET TITLE=?, NCONTENT=? WHERE NOTECODE=?";

	public int update(Connection conn, NoteVO vo) {
		int result = 0;
		System.out.println("여기업데이트확인");
		try {
			System.out.println("여기시작에러");
			psmt = conn.prepareStatement(UPDATE);
			psmt.setString(1, vo.getTitle());
			psmt.setString(2, vo.getNcontent());
			psmt.setInt(3, vo.getNotecode());

			result = psmt.executeUpdate();
			System.out.println("result : " + result);
		} catch (Exception e) {
			System.out.println("다른 에러에용");
			e.printStackTrace();
		}

		return result;

	}

	String SELECT = "select title, ncontent, notecode from note where memberno=?";

	public ArrayList<NoteVO> select(Connection conn, NoteVO vo) {
		ArrayList<NoteVO> list = new ArrayList<NoteVO>();

		try {
			psmt = conn.prepareStatement(SELECT);
			psmt.setInt(1, vo.getMemberno());
			rs = psmt.executeQuery();

			while (rs.next()) {
				NoteVO noteVO = new NoteVO();
				noteVO.setTitle(rs.getString("title"));
				noteVO.setNcontent(rs.getString("ncontent"));
				noteVO.setNotecode(rs.getInt("notecode"));
				list.add(noteVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	String DELETE = "delete from note where notecode = ?";

	public int delete(Connection conn, NoteVO vo) {
		int result=0;
		try {

			psmt = conn.prepareStatement(DELETE);
			psmt.setInt(1, vo.getNotecode());
			result = psmt.executeUpdate();

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	String SELECTONE = "SELECT * FROM NOTE WHERE NOTECODE = ?";

	public NoteVO selectone(Connection conn, NoteVO vo) {
		NoteVO nvo = null;
		try {
			psmt = conn.prepareStatement(SELECTONE);
			psmt.setInt(1, vo.getNotecode());
			rs = psmt.executeQuery();

			if (rs.next()) {
				nvo = new NoteVO();
				nvo.setTitle(rs.getString("title"));
				nvo.setNcontent(rs.getString("ncontent"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return nvo;

	}
//	

}
