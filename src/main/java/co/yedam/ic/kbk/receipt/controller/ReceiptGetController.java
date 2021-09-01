package co.yedam.ic.kbk.receipt.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.kbk.receipt.dao.ReceiptDAO;
import co.yedam.ic.kbk.receipt.vo.ReceiptVO;

@WebServlet("/rctGet.do")
public class ReceiptGetController extends HttpServlet {
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

		response.setContentType("text/html; charset=UTF-8");
		ReceiptDAO dao = ReceiptDAO.getInstance();
		ReceiptVO requestVo = new ReceiptVO();
		
		String key = (String)request.getSession().getAttribute("selectedString");
		System.out.println("key : " + key);
		HashMap<String, Integer> map = (HashMap)request.getSession().getAttribute("rctMap");
		
		requestVo.setMembercode(map.get(key));
		System.out.println(requestVo.getMembercode());
		
		ReceiptVO svo = new ReceiptVO();
		Connection conn = ConnectionManager.getConnection();
		try {
			conn.setAutoCommit(false);
			svo = ReceiptDAO.getInstance().select(conn, requestVo);
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
		} finally {
			ConnectionManager.close(conn);
		}

		
//		requestVo.setMembercode(Integer.parseInt(request.getParameter("membercode")));
//		requestVo = dao.select(conn, requestVo);
//		System.out.println(requestVo); //확인 후 삭제
		request.setAttribute("select", svo);

		String view = "views/receipt/rctModifyBody.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);

	}
}