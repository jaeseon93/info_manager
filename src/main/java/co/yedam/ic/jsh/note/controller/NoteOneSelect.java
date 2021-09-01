package co.yedam.ic.jsh.note.controller;

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
import co.yedam.ic.jsh.note.dao.NoteDAO;
import co.yedam.ic.jsh.note.vo.NoteVO;

/**
 * Servlet implementation class NoteOneSelect
 */
@WebServlet("/noteoneselect.do")
public class NoteOneSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public NoteOneSelect() {
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

		request.setCharacterEncoding("utf-8");
		NoteVO vo = new NoteVO();
		
	
		String key = (String)request.getSession().getAttribute("selectedString");
		System.out.println("key:"+key);
		HashMap<String, Integer> map = (HashMap) request.getSession().getAttribute("noteMap");
		System.out.println("여기맵:"+map);
//여기질무우우우우우우운
		
//		if (map == null) {
//			System.out.println("맵이 없습니다");
//		}
		//여가ㅣ서 map.get(key) 는 map에저장된 모든값을 반환해서 Notecode에 넣는것이아닌가???
		vo.setNotecode(map.get(key));
		System.out.println("여기 notevo:"+vo.getNotecode());

		NoteVO notevo = new NoteVO();
		Connection conn = ConnectionManager.getConnection();
		try {
			conn.setAutoCommit(false);
			notevo = NoteDAO.getInstance().selectone(conn,vo);
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}finally {
			ConnectionManager.close(conn);
		}
		request.setAttribute("selectone",notevo );
		String view = "views/note/noteUpdateBOdy.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
	}
		
}
