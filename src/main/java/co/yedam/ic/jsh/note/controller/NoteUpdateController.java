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
 * Servlet implementation class NoteUpdateController
 */
@WebServlet("/NoteUpdate.do")
public class NoteUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public NoteUpdateController() {
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

	protected void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NoteDAO dao = NoteDAO.getInstance();
		NoteVO vo = new NoteVO();

		HttpSession session = request.getSession();
		String selectedString = (String)session.getAttribute("selectedString");
		int notevalue = (int)((HashMap)session.getAttribute("noteMap")).get(selectedString);
		vo.setNotecode(notevalue);
		vo.setTitle(request.getParameter("title"));
		vo.setNcontent(request.getParameter("ncontent"));
		
		HashMap<String, Integer> map = (HashMap)request.getSession().getAttribute("noteMap");
		
		Connection conn = ConnectionManager.getConnection();

		int update = dao.update(conn, vo);

		//boolean result = false;

		ConnectionManager.close(conn);
		JsonObject json = new JsonObject();
		json.addProperty("result", update);

		Gson gson = new Gson();
		String resultString = gson.toJson(json);
		System.out.println("여기 update확인 : "+resultString);
		response.getWriter().print(resultString);

	}

}
