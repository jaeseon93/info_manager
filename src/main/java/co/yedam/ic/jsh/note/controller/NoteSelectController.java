package co.yedam.ic.jsh.note.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.RequestDispatcher;
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
import co.yedam.ic.hjs.aes256.AES256Util;
import co.yedam.ic.hjs.passwords.dao.PasswordsDAO;
import co.yedam.ic.hjs.passwords.vo.PasswordsVo;
import co.yedam.ic.jsh.note.dao.NoteDAO;
import co.yedam.ic.jsh.note.vo.NoteVO;

/**
 * Servlet implementation class NoteSelectController
 */
@WebServlet("/NoteSelect.do")
public class NoteSelectController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		ArrayList<NoteVO> list;
		NoteVO vo = new NoteVO();

		NoteDAO dao = NoteDAO.getInstance();
		Connection conn = ConnectionManager.getConnection();
		HttpSession session = request.getSession();
		int memberno = (int)session.getAttribute("memberno");
		//int memberno = 3;
		vo.setMemberno(memberno);
		list = dao.select(conn, vo);
		ConnectionManager.close(conn);; 
		int i = 1;
		//int x = 11;
		
		HashMap<String, Integer> map = new HashMap<>();
		JsonArray array = new JsonArray();
		for(NoteVO nvo : list) {
			JsonObject object = new JsonObject();
			String key = String.format("%s%d", "notecode", i);
			
			map.put(key,nvo.getNotecode());
			object.addProperty("title", nvo.getTitle());
			object.addProperty("ncontent",nvo.getNcontent());
			object.addProperty("index", key);
			array.add(object);
			++i;
			//x++;
		}
		request.getSession().setAttribute("noteMap", map);
		
		
		GsonBuilder builder = new GsonBuilder();
		//builder.setPrettyPrinting().serializeNulls();
		Gson gson = builder.create();
		
		JsonElement result = gson.toJsonTree(array);
		JsonObject outside = new JsonObject();
		outside.add("list", result);
		response.getWriter().print(gson.toJson(outside));

	}
}
