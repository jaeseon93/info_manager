package co.yedam.ic.suh.login.controller;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;
import co.yedam.ic.suh.sha256.SHAEncrypt;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/loginCheck.do")
public class LoginCheckController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		MemberDAO dao = MemberDAO.getInstance();
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		MemberVO vo = new MemberVO();
		Connection conn = ConnectionManager.getConnection();
		vo.setEmail(email);
		MemberVO receivedVo = null;
		receivedVo = dao.select(conn, vo);
		ConnectionManager.close(conn);

		boolean result = false;
		if(receivedVo != null ){
			String salt = receivedVo.getSalt();

			String loginPW = SHAEncrypt.getEncrypt(pw, salt);
			String dbPW = receivedVo.getPassword();
			if( loginPW.equals(dbPW)){
				result = true;
			}
		}

		JsonObject json = new JsonObject();
		json.addProperty("result", result);

		response.getWriter().print(json.toString());
	}
}
