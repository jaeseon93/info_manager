package co.yedam.ic.suh.myt;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;
import com.google.gson.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

@WebServlet( "/test.do")
public class TestController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		ArrayList<MemberVO> list;
		MemberDAO dao = MemberDAO.getInstance();
		Connection conn = ConnectionManager.getConnection();
		list = dao.select_all(conn);
		ConnectionManager.close(conn);


		JsonArray array = new JsonArray();
		for(MemberVO mem : list){
			JsonObject object = new JsonObject();
			object.addProperty("email", mem.getEmail());
			object.addProperty("password", mem.getPassword());
			object.addProperty("phone", mem.getPhone());
			array.add(object);
		}


		//밑에 부분들은 JSON에 배열 넣는방법
		GsonBuilder builder = new GsonBuilder();
		//builder.setPrettyPrinting().serializeNulls();
		Gson gson = builder.create();

		JsonElement result = gson.toJsonTree(list);
		JsonObject outside = new JsonObject();
		outside.add("list", result);
		response.getWriter().print(gson.toJson(outside));

	}
}
