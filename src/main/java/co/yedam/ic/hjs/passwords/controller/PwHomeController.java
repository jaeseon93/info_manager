package co.yedam.ic.hjs.passwords.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.hjs.passwords.dao.PasswordsDAO;
import co.yedam.ic.hjs.passwords.vo.PasswordsVo;


@WebServlet("/pwHome.do")
public class PwHomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		ArrayList<PasswordsVo> list;
		PasswordsDAO dao = PasswordsDAO.getInstance();
		PasswordsVo vo = new PasswordsVo();
		vo.setMemberno((int)request.getSession().getAttribute("memberno"));
		Connection conn = ConnectionManager.getConnection();
		list = dao.select_all(conn,vo);
		ConnectionManager.close(conn);
	
		int i = 1;
		HashMap<String,Integer > map = new HashMap<String,Integer>();
		System.out.println("call");
		JsonArray array = new JsonArray();
		for( PasswordsVo pw : list) {
			JsonObject object = new JsonObject();
			String key = String.format("%s%d", "password", i);
			System.out.println("InKey : " + key);
			map.put(key, pw.getIdxno());
			object.addProperty("sitename", pw.getSitename());
			object.addProperty("url", pw.getUrl());
			object.addProperty("cardKey", key );
			array.add(object);
			++i;
		}
		
			request.getSession().setAttribute("pwMap", map);
			
			//밑에 부분들은 JSON에 배열 넣는방법
			GsonBuilder builder = new GsonBuilder();
			//builder.setPrettyPrinting().serializeNulls();
			Gson gson = builder.create();

			JsonElement result = gson.toJsonTree(array);
			JsonObject outside = new JsonObject();
			outside.add("list", result);
			response.getWriter().print(gson.toJson(outside));
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
