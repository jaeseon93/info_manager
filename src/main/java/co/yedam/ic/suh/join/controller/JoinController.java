package co.yedam.ic.suh.join.controller;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.common.Strings;
import co.yedam.ic.jsh.note.dao.NoteDAO;
import co.yedam.ic.jsh.note.vo.NoteVO;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;
import co.yedam.ic.suh.sha256.SHAEncrypt;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class JoinController
 */
@WebServlet("/join.do")
public class JoinController extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public JoinController(){
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// TODO Auto-generated method stub
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// TODO Auto-generated method stub
		doAction(request, response);
	}


	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		MemberDAO dao = MemberDAO.getInstance();
		String email = request.getParameter("email");
		String password = request.getParameter("pw");
		request.getSession().getAttribute("memberno");
		MemberVO requestVo = new MemberVO();
		requestVo.setEmail(email);
		requestVo.setPassword(password);

		MemberVO vo = null;
		Connection conn = ConnectionManager.getConnection();

		vo = dao.select(conn, requestVo);
		String view = "views/join_fail.jsp";

		try{
			conn.setAutoCommit(false);
			// vo가 null이면 해당 계정이 없으니 회원가입 프로세스를 지속하면됨
			if(vo == null){
				String pw = requestVo.getPassword();
				String salt = SHAEncrypt.generateSalt();
				String encrypted = SHAEncrypt.getEncrypt(pw, salt);
				requestVo.setPassword(encrypted);
				requestVo.setSalt(salt);

				int result = dao.insert(conn, requestVo);
				int memberNo = dao.select(conn, requestVo).getMemberNo();
				if(result == 0){
					view = "views/join/join_fail.jsp";

				}else{
					NoteDAO noteDAO = NoteDAO.getInstance();
					NoteVO noteVO = new NoteVO();
					noteVO.setMemberno(memberNo);
					noteVO.setNcontent(Strings.CONTENT_WELCOME);
					noteVO.setTitle(Strings.TITLE_WELCOME);
					result = noteDAO.insert(conn, noteVO);

					if(result == 0){
						conn.rollback();
					}else{
						request.getSession().setAttribute("memberno", memberNo);
						request.getSession().setAttribute("email", email);
						request.setAttribute("hasTwoFactor", false);
						view = Strings.TILES_LOGIN_RESULT;
						conn.commit();
					}
				}

			}

		}catch(SQLException e){
			try{
				conn.rollback();
			}catch(SQLException ex){
				ex.printStackTrace();
			}
		}
		ConnectionManager.close(conn);
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
	}

}
