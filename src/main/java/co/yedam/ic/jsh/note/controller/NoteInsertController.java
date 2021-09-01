package co.yedam.ic.jsh.note.controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
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
 * Servlet implementation class NoteController
 */
@WebServlet("/NoteInsert.do")
public class NoteInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoteInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request,response);
	}
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		NoteDAO dao = NoteDAO.getInstance();
		NoteVO vo = new NoteVO();
		
		HttpSession session = request.getSession();
		int memberno = (int)session.getAttribute("memberno");
		//int memberno = 3;
		vo.setMemberno(memberno);
		//String title = "메롱";
		//vo.setTitle(title);
		vo.setTitle(request.getParameter("title"));
		vo.setNcontent(request.getParameter("ncontent"));
		
		System.out.println("여기가타이틀"+request.getParameter("title"));
		System.out.println("여기가컨텐트 : " + request.getParameter("ncontent"));
		Connection conn = ConnectionManager.getConnection();
		int n = dao.insert(conn , vo);
		
		boolean result = false;
	
		if(n !=0) {
			result = true;
		}
		
		
		ConnectionManager.close(conn);
		JsonObject json = new JsonObject();
	    json.addProperty("result", result);

	    Gson gson = new Gson();
	      String resultString = gson.toJson(json);

	      response.getWriter().print(resultString);

	}
	
	
}
