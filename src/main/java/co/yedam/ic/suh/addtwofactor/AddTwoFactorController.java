package co.yedam.ic.suh.addtwofactor;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.suh.GoogleOTP.GoogleOTP;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/addtwofactor.do")
public class AddTwoFactorController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String encryptKey  = request.getParameter("encryptKey");
		String numberKey = request.getParameter("numberKey");
		int memberNo = (int)request.getSession().getAttribute("memberno");
		MemberDAO dao = MemberDAO.getInstance();
		Connection conn = ConnectionManager.getConnection();
		boolean resultOTP = GoogleOTP.checkCode(numberKey, encryptKey);
		MemberVO vo = new MemberVO();
		vo.setMemberNo(memberNo);
		vo.setGoogleAuth(encryptKey);

		boolean resultUpdate = (dao.updateOTPKey(conn, vo) != 0);
		ConnectionManager.close(conn);

		JsonObject object = new JsonObject();
		object.addProperty("result", (resultOTP&&resultUpdate));
		Gson gson = new Gson();
		String json = gson.toJson(object);
		System.out.println(json);
		response.getWriter().print(json);

	}
}
