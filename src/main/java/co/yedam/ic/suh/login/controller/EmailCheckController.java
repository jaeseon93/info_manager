package co.yedam.ic.suh.login.controller;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/emailExistCheck.do")
public class EmailCheckController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request,response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request,response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("Start");
		MemberDAO dao = MemberDAO.getInstance();
		Connection conn = ConnectionManager.getConnection();
		String email = request.getParameter("email");
		MemberVO vo = new MemberVO();
		vo.setEmail(email);
		vo = dao.select(conn, vo);
		ConnectionManager.close(conn);
		JsonObject json = new JsonObject();
		boolean result = false;
		if( vo == null ){
			result = true;
		}

		json.addProperty("result", result);
		System.out.println(json.toString());
		response.getWriter().print(json.toString());

	}
}
