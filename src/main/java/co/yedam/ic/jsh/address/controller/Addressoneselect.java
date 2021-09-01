package co.yedam.ic.jsh.address.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.jsh.address.dao.AddressDAO;
import co.yedam.ic.jsh.address.vo.AddressVO;

/**
 * Servlet implementation class Addressoneselect
 */
@WebServlet("/addoneselect.do")
public class Addressoneselect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Addressoneselect() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		AddressVO vo = new AddressVO();

		String key = (String) request.getSession().getAttribute("selectedString");
		HashMap<String, Integer> map = (HashMap) request.getSession().getAttribute("addMap");
		System.out.println("여기 add키" + key);
		vo.setAddno(map.get(key));
		System.out.println("여기 mapKEY가 dao에넘어가니" + map.get(key));
		AddressVO addvo = new AddressVO();
		Connection conn = ConnectionManager.getConnection();
		try {
			conn.setAutoCommit(false);
			addvo = AddressDAO.getInstance().selectone(conn, vo);
			conn.commit();
			System.out.println("여기addvo" + addvo);
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			ConnectionManager.close(conn);
		}
		request.setAttribute("selectone", addvo);
		String view = "views/address/addUpdateBody.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);

	}
}
