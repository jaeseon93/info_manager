package co.yedam.ic.kbk.receipt.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.kbk.receipt.dao.ReceiptDAO;
import co.yedam.ic.kbk.receipt.vo.ReceiptVO;

@WebServlet("/rctUpdate.do")
public class ReceiptUpdateController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ReceiptDAO dao = ReceiptDAO.getInstance();
		ReceiptVO vo = new ReceiptVO();

		// 파라미터불러오기
		int no = (int)request.getSession().getAttribute("memberno");
		vo.setMemberno(no);
		vo.setTitle(request.getParameter("title"));
		vo.setPlace(request.getParameter("place"));
		vo.setStuff(request.getParameter("stuff"));
		vo.setTotal(request.getParameter("total"));		
		vo.setNote(request.getParameter("note"));
		vo.setRctdate(request.getParameter("rctdate"));
		String key = (String)request.getSession().getAttribute("selectedString");
		HashMap<String, Integer> map = (HashMap)request.getSession().getAttribute("rctMap");

		vo.setMembercode(map.get(key));
		
		Connection conn = ConnectionManager.getConnection();
		int updateResult =  dao.update(conn, vo);
		
		boolean n = false;
		System.out.println(vo);
		
		if (updateResult != 0) {
			n = true;
		} 
		
		ConnectionManager.close(conn);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", updateResult);

		Gson gson = new Gson();
		String resultString = gson.toJson(json);
		response.getWriter().print(resultString); // 다시 ajax로 보냄

	}
}
