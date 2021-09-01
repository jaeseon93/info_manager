package co.yedam.ic.suh.login.controller;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.common.Strings;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;
import co.yedam.ic.suh.sha256.SHAEncrypt;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/login.do")
public class LoginController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request,response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request,response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		MemberDAO dao = MemberDAO.getInstance();
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		MemberVO vo = new MemberVO();;
		String view = "";
		vo.setEmail(email);
		Connection conn = ConnectionManager.getConnection();
		MemberVO checkVo = dao.select(conn, vo);
		if( checkVo == null ){
			view = "views/login/login_fail.jsp";
			ConnectionManager.close(conn);
			dispatch(request,response, view);
			return;
		}

		String salt = checkVo.getSalt();
		String encPw = SHAEncrypt.getEncrypt(pw, salt);

		//로그인 성공
		if( encPw.equals(checkVo.getPassword())){

			if( checkVo.getGoogleAuth() == null ){
				view = Strings.TILES_LOGIN_RESULT;
				HttpSession session = request.getSession();
				session.setAttribute("memberno", checkVo.getMemberNo());
				session.setAttribute("email", checkVo.getEmail());
				request.setAttribute("hasTwoFactor", false);
			}else{
				request.getSession().setAttribute("memberno", checkVo.getMemberNo());
				request.setAttribute("email", email);
				view = Strings.PATH_TWOFACTOR_PAGE;
			}
		}else{
			view = "views/login/login_fail.jsp";
		}
		ConnectionManager.close(conn);
		dispatch(request,response,view);
	}

	private void dispatch(HttpServletRequest request, HttpServletResponse response, String view) throws ServletException, IOException{

		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
	}
}
