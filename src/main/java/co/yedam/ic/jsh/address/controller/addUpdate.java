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
 * Servlet implementation class addUpdate
 */
@WebServlet("/addUpdate.do")
public class addUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public addUpdate() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AddressDAO dao = AddressDAO.getInstance();
		AddressVO vo = new AddressVO();
		
		HttpSession session = request.getSession();
		String selectedString = (String)session.getAttribute("selectedString"); 

		int addvalue = (int)((HashMap)session.getAttribute("addMap")).get(selectedString);
		System.out.println("addvalue:"+addvalue);
		vo.setAddno(addvalue);
		vo.setAname(request.getParameter("aname"));
		vo.setAgender(request.getParameter("agender"));
		vo.setAbirth(request.getParameter("abirth"));
		vo.setAddress(request.getParameter("address"));
		vo.setAphone(request.getParameter("aphone"));
		vo.setAemaile(request.getParameter("aemaile"));
		vo.setAcompany(request.getParameter("acompany"));
		vo.setGrade(request.getParameter("grade"));
		vo.setAdate(request.getParameter("adate"));
		vo.setAmemo(request.getParameter("amemo"));
		HashMap<String, Integer>map = (HashMap)request.getSession().getAttribute("addMap");
		Connection conn = ConnectionManager.getConnection();
		int update = dao.update(conn,vo);
		System.out.println("업데이트확인"+update);
		ConnectionManager.close(conn);
		JsonObject json = new JsonObject();
		json.addProperty("result", update);
		
		
		Gson gson = new Gson();
		String resultString = gson.toJson(json);
		System.out.println("여기 update확인 : "+resultString);
		response.getWriter().print(resultString);
	}
}
