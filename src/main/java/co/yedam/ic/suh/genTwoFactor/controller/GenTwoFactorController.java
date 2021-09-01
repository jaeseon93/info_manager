package co.yedam.ic.suh.genTwoFactor.controller;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.suh.GoogleOTP.GoogleOTP;
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
import java.util.HashMap;
import java.util.Random;

@WebServlet("/gentwofactor.do")
public class GenTwoFactorController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		response.setCharacterEncoding("utf-8");
		int memberno = (int)request.getSession().getAttribute("memberno");
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO vo = new MemberVO();
		vo.setMemberNo(memberno);
		Connection conn = ConnectionManager.getConnection();
		vo = dao.selectByNum(conn, vo);
		ConnectionManager.close(conn);
		String email = vo.getEmail();
		byte[] hostName = new byte[8];

		Random random = new Random();
		random.nextBytes(hostName);
		HashMap<String, String> map = GoogleOTP.generate(email, hostName.toString());

		String key = map.get("encodedKey");
		String url = map.get("url");

		Gson gson = new Gson();
		JsonObject object = new JsonObject();
		object.addProperty("key", key);
		object.addProperty("url", url);

		String json = gson.toJson(object);

		response.getWriter().print(json);
	}
}
