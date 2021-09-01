package co.yedam.ic.jsh.address.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.jsh.address.dao.AddressDAO;
import co.yedam.ic.jsh.address.vo.AddressVO;

/**
 * Servlet implementation class selectAll
 */
@WebServlet("/aSelectall.do")
public class selectAll extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public selectAll() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doAction(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request,response);
	}
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		ArrayList<AddressVO> list;
		AddressVO vo = new AddressVO();
		AddressDAO dao = AddressDAO.getInstance();
		
		Connection conn = ConnectionManager.getConnection();
		HttpSession session = request.getSession();
		int memberno  = (int)session.getAttribute("memberno");
		vo.setMemberno(memberno);
		list = dao.select(conn,vo);
		ConnectionManager.close(conn);
		int i = 1;
		
		HashMap<String, Integer> map = new HashMap<>();
		JsonArray array = new JsonArray();
		for(AddressVO avo : list) {
			JsonObject object = new JsonObject();
			String key = String.format("%s%d","addcode",i);
			
			map.put(key,avo.getAddno());
			object.addProperty("aname", avo.getAname());
			object.addProperty("agender", avo.getAgender());
			object.addProperty("abirth", avo.getAbirth());
			object.addProperty("address",avo.getAddress());
			object.addProperty("aphone",avo.getAphone());
			object.addProperty("aemaile",avo.getAemaile());
			object.addProperty("acompany",avo.getAcompany());
			object.addProperty("grade",avo.getGrade() );
			object.addProperty("adate",avo.getAdate() );
			object.addProperty("amemo",avo.getAmemo() );
			object.addProperty("aindex", key);
			System.out.println("aindex:"+key);
			array.add(object);
			++i;

		}
			request.getSession().setAttribute("addMap", map);
			GsonBuilder builder = new GsonBuilder();

			Gson gson = builder.create();
			
			JsonElement result = gson.toJsonTree(array);
			JsonObject outside = new JsonObject();
			outside.add("list", result);
			response.getWriter().print(gson.toJson(outside));
	}
	
}
