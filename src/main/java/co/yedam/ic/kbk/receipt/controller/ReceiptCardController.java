package co.yedam.ic.kbk.receipt.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.conscrypt.ct.DigitallySigned.HashAlgorithm;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.kbk.receipt.dao.ReceiptDAO;
import co.yedam.ic.kbk.receipt.vo.ReceiptVO;

@WebServlet("/rctCard.do")
public class ReceiptCardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		
		ArrayList<ReceiptVO> list;
		ReceiptDAO dao = ReceiptDAO.getInstance();
		ReceiptVO vo = new ReceiptVO();
		vo.setMemberno((int)request.getSession().getAttribute("memberno"));
		Connection conn = ConnectionManager.getConnection();
		list = dao.select_all(conn,vo);
		ConnectionManager.close(conn); 
		
		int i =1;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
	//	System.out.println("call");
		
		JsonArray array = new JsonArray();
		for( ReceiptVO rct : list) {
			JsonObject object = new JsonObject();
			String key = String.format("%s%d", "receipt", i);
			System.out.println("InKey : " + key);
			map.put(key, rct.getMembercode());
			object.addProperty("title", rct.getTitle());
			object.addProperty("total", rct.getTotal());
			object.addProperty("cardKey", key );
			array.add(object);
			++i;
		}
		
		request.getSession().setAttribute("rctMap", map);
		
		//밑에 부분들은 JSON에 배열 넣는방법
		GsonBuilder builder = new GsonBuilder();
		//builder.setPrettyPrinting().serializeNulls();
		Gson gson = builder.create();

		JsonElement result = gson.toJsonTree(array);
		JsonObject outside = new JsonObject();
		outside.add("list", result);
		response.getWriter().print(gson.toJson(outside));
		
	}

}
