package co.yedam.ic.jsh.note.controller;

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
import co.yedam.ic.jsh.note.dao.NoteDAO;
import co.yedam.ic.jsh.note.vo.NoteVO;

/**
 * Servlet implementation class NoteDeleteController
 */
@WebServlet("/notedelete.do")
public class NoteDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doAction(request, response);
	}
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		NoteDAO dao = NoteDAO.getInstance();
		NoteVO vo = new NoteVO();
		
		HttpSession session = request.getSession();
		String selectedString = request.getParameter("ndelete");
		HashMap<String, Integer> map = (HashMap)request.getSession().getAttribute("noteMap");
		int notevalue = map.get(selectedString);
		vo.setNotecode(notevalue);
		

		Connection conn = ConnectionManager.getConnection();
		int delete = dao.delete(conn, vo);
		
		ConnectionManager.close(conn);
		JsonObject json = new JsonObject();
		json.addProperty("result", delete);

		Gson gson = new Gson();
		String resultString = gson.toJson(json);
		System.out.println("여기 update확인 : "+resultString);
		response.getWriter().print(resultString);
	}
}
