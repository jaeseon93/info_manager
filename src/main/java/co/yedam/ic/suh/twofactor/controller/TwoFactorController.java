package co.yedam.ic.suh.twofactor.controller;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.common.Strings;
import co.yedam.ic.suh.GoogleOTP.GoogleOTP;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;
import com.google.gson.JsonObject;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/twofactor.do")
public class TwoFactorController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		MemberDAO dao = MemberDAO.getInstance();
		Connection conn = ConnectionManager.getConnection();
		String email = request.getParameter("email");
		String auth = request.getParameter("auth");
		MemberVO vo = new MemberVO();
		vo.setEmail(email);
		vo = dao.select(conn, vo);
		ConnectionManager.close(conn);
		boolean result = false;
		result = GoogleOTP.checkCode(auth, vo.getGoogleAuth());


		String view = Strings.TILES_LOGIN_RESULT;
		if( result ){
			//TODO 메인 화면으로 이동
			HttpSession session = request.getSession();
			session.setAttribute("memberno", vo.getMemberNo());
			session.setAttribute("email", vo.getEmail());
			dispatch(request, response, view);
			return;
		}else{
			request.setAttribute("email", email);
		}

		view = Strings.PATH_TWOFACTOR_PAGE;

		dispatch(request,response,view);
	}

	protected void dispatch(HttpServletRequest request, HttpServletResponse response, String view) throws ServletException, IOException{
		request.getRequestDispatcher(view).forward(request, response);
	}
}
