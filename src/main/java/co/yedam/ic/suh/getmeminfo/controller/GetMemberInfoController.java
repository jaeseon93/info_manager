package co.yedam.ic.suh.getmeminfo.controller;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/getmeminfo.do")
public class GetMemberInfoController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		int num = (int)request.getSession().getAttribute("memberno");
		MemberDAO dao = MemberDAO.getInstance();
		Connection conn = ConnectionManager.getConnection();
		MemberVO vo = new MemberVO();
		vo.setMemberNo(num);
		vo = dao.selectByNum(conn, vo);
		ConnectionManager.close(conn);
		JsonObject jsonObject = new JsonObject();
		if( vo != null ){
			jsonObject.addProperty("email", vo.getEmail());
			jsonObject.addProperty("phone", vo.getPhone());
			if( vo.getGoogleAuth() != null)
				jsonObject.addProperty("hasTwoFactor", true);
			else
				jsonObject.addProperty("hasTwoFactor", false);
		}
		Gson gson = new Gson();


		response.getWriter().print(gson.toJson(jsonObject));


	}
}
