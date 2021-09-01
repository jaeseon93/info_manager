package co.yedam.ic.hjs.passwords.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.hjs.passwords.dao.PasswordsDAO;
import co.yedam.ic.hjs.passwords.vo.PasswordsVo;


@WebServlet("/deletepw.do")
public class PwDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PasswordsDAO dao = PasswordsDAO.getInstance();
		PasswordsVo vo = new PasswordsVo();
		
		String key = request.getParameter("pdelete");
		
		HashMap<String, Integer> map = (HashMap)request.getSession().getAttribute("pwMap");

		vo.setIdxno(map.get(key));
		
		Connection conn = ConnectionManager.getConnection();		
		int deleteResult = dao.delete(conn, vo);
		
		if(deleteResult != 0) {
			response.getWriter().print("true");
		} else {
			response.getWriter().print("false");
		}
		
		ConnectionManager.close(conn);

		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
