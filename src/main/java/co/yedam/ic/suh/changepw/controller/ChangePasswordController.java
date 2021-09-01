package co.yedam.ic.suh.changepw.controller;


import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.common.Strings;
import co.yedam.ic.suh.member.dao.MemberDAO;
import co.yedam.ic.suh.member.vo.MemberVO;
import co.yedam.ic.suh.sha256.SHAEncrypt;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/changepw.do")
public class ChangePasswordController extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String curPw = request.getParameter("curPw");
		curPw = curPw.trim();
		String changePw = request.getParameter("pw");
		changePw = changePw.trim();
		String phone = request.getParameter("phone");
		phone = phone.trim();
		int memberNo = (int)request.getSession().getAttribute("memberno");
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO vo = new MemberVO();
		Connection conn = ConnectionManager.getConnection();
		vo.setMemberNo(memberNo);
		vo = dao.selectByNum(conn, vo);
		String result = Strings.RESULT_ERROR_DB;

		if( !phone.equals("")){
			vo.setPhone(phone);
		}else{
			vo.setPhone(null);
		}


		if( !changePw.equals("")){
			String salt = vo.getSalt();
			String encryptCurPw = SHAEncrypt.getEncrypt(curPw, salt);
			String storedPw = vo.getPassword();
			if(encryptCurPw.equals(storedPw)){
				salt= SHAEncrypt.generateSalt();
				vo.setSalt(salt);
				String encryptChanged = SHAEncrypt.getEncrypt(changePw, salt);
				vo.setPassword(encryptChanged);
				int queryResult = dao.update(conn, vo);
				result = (queryResult == 0? Strings.RESULT_ERROR_DB : Strings.RESULT_OK);
			}else{
				result = Strings.RESULT_WRONG_PASSWORD;
			}
		}



		ConnectionManager.close(conn);
		JsonObject json = new JsonObject();
		json.addProperty("result", result);

		Gson gson = new Gson();
		String resultString = gson.toJson(json);

		response.getWriter().print(resultString);
	}
}
