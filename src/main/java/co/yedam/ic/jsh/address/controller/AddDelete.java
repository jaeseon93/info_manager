package co.yedam.ic.jsh.address.controller;

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
import co.yedam.ic.jsh.address.dao.AddressDAO;
import co.yedam.ic.jsh.address.vo.AddressVO;

/**
 * Servlet implementation class AddDelete
 */
@WebServlet("/adddelete.do")
public class AddDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AddDelete() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AddressDAO dao=  AddressDAO.getInstance();
		AddressVO vo = new AddressVO();
		
		HttpSession session = request.getSession();
		String selectedString = request.getParameter("adelete");
		HashMap<String,Integer> map = (HashMap)request.getSession().getAttribute("addMap");
	
		int addvalue = map.get(selectedString);
		vo.setAddno(addvalue);
		
		Connection conn = ConnectionManager.getConnection();
		int delete = dao.delete(conn,vo);
		
		ConnectionManager.close(conn);
		JsonObject json = new JsonObject();
		json.addProperty("result", delete);
		
		Gson gson = new Gson();
		String resultString = gson.toJson(json);
		response.getWriter().print(resultString);
	}
}
