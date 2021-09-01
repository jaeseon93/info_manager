package co.yedam.ic.kbk.receipt.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.kbk.receipt.dao.ReceiptDAO;
import co.yedam.ic.kbk.receipt.vo.ReceiptVO;

@WebServlet("/rctDelete.do")
public class ReceiptDeleteController extends HttpServlet {
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
		
		String key = (String)request.getParameter("selectedString");
		HashMap<String, Integer> map = (HashMap)request.getSession().getAttribute("rctMap");
		System.out.println("key : "+key);
		vo.setMembercode(map.get(key));
		
		Connection conn= ConnectionManager.getConnection();
		int deleteResult = dao.delete(conn, vo);
		ConnectionManager.close(conn);
		
		if(deleteResult != 0) {
			response.getWriter().print("true");
		} else {
			response.getWriter().print("false");
		}
		
	}
}
