package co.yedam.ic.jsh.address.controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.jsh.address.dao.AddressDAO;
import co.yedam.ic.jsh.address.vo.AddressVO;

/**
 * Servlet implementation class AddressInsertController
 */
@WebServlet("/aInsert.do")
public class AddressInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddressInsertController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);

	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws IOException {
			
		AddressDAO dao = AddressDAO.getInstance();
		AddressVO vo = new AddressVO();
		
		HttpSession session = request.getSession();
		int memberno = (int)session.getAttribute("memberno");
		vo.setMemberno(memberno);
		System.out.println("여기멤버넘버"+memberno);
		vo.setAname(request.getParameter("aname"));
		System.out.println("여기aname"+request.getParameter("aname"));
		vo.setAgender(request.getParameter("agender"));
		vo.setAbirth(request.getParameter("abirth"));
		vo.setAddress(request.getParameter("address"));
		vo.setAphone(request.getParameter("aphone"));
		vo.setAemaile(request.getParameter("aemaile"));
		vo.setAcompany(request.getParameter("acompany"));
		vo.setGrade(request.getParameter("grade"));
		vo.setAdate(request.getParameter("adate"));
		vo.setAmemo(request.getParameter("amemo"));
		System.out.println("이름 주소 :"+request.getParameter("aname")+request.getParameter("address"));
		Connection conn = ConnectionManager.getConnection();
		
		int n = dao.ainsert(conn, vo);
		
		boolean result = false;
		
		if(n != 0 ) {
			result = true;
		}
		ConnectionManager.close(conn);
		JsonObject json = new JsonObject();
	    json.addProperty("result" , result);

	    Gson gson = new Gson();
	      String resultString = gson.toJson(json);

	      response.getWriter().print(resultString);
	}
		
}
