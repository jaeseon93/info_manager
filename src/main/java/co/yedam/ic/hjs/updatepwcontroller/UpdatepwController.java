package co.yedam.ic.hjs.updatepwcontroller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.util.HashMap;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.hjs.aes256.AES256Util;
import co.yedam.ic.hjs.passwords.dao.PasswordsDAO;
import co.yedam.ic.hjs.passwords.vo.PasswordsVo;


@WebServlet("/updatepw.do")
public class UpdatepwController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터불러오고 값담기
		PasswordsDAO dao = PasswordsDAO.getInstance();
		PasswordsVo requestVo = new PasswordsVo();
		requestVo.setUrl(request.getParameter("url"));
		requestVo.setSitename(request.getParameter("sitename"));
		requestVo.setSiteid(request.getParameter("siteid"));
		String pw = request.getParameter("sitepw");
		requestVo.setNote(request.getParameter("note"));
		String key = (String)request.getSession().getAttribute("selectedString");
		HashMap<String, Integer> map = (HashMap)request.getSession().getAttribute("pwMap");

		requestVo.setIdxno(map.get(key));
		
		//암호화
		String aesKey = "aes256-test-key!!";
		AES256Util aes256 = new AES256Util(aesKey);

		try {
			String encPw = aes256.aesEncode(pw);
			requestVo.setSitepw(encPw);
		} catch (InvalidKeyException|UnsupportedEncodingException|NoSuchAlgorithmException|NoSuchPaddingException|
				InvalidAlgorithmParameterException|IllegalBlockSizeException|BadPaddingException e ) {
			e.printStackTrace();
		}
		
		Connection conn = ConnectionManager.getConnection();

		int updateResult =  dao.update(conn, requestVo);
	
		ConnectionManager.close(conn);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", updateResult);
		
		Gson gson = new Gson();
		String resultString = gson.toJson(json);
		
		response.getWriter().print(resultString); // 다시 ajax로 보냄
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
