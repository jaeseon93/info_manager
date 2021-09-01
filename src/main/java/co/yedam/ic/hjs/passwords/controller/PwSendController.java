package co.yedam.ic.hjs.passwords.controller;

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

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.hjs.aes256.AES256Util;
import co.yedam.ic.hjs.passwords.dao.PasswordsDAO;
import co.yedam.ic.hjs.passwords.vo.PasswordsVo;


@WebServlet("/pwSend.do")
public class PwSendController extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		PasswordsDAO dao = PasswordsDAO.getInstance();
		PasswordsVo vo = new PasswordsVo();
		
		String key = request.getParameter("pwkey");
		HashMap<String, Integer> map = (HashMap)request.getSession().getAttribute("pwMap");

		vo.setIdxno(map.get(key));
		
		Connection conn = ConnectionManager.getConnection();	
		
		PasswordsVo Vosel = new PasswordsVo();
		Vosel = dao.select(conn, vo);
		
		//복호화
		String Aeskey = "aes256-test-key!!";
		AES256Util aes256 = new AES256Util(Aeskey);
		String pw = Vosel.getSitepw();
		
		
		String decPw = "";
		try {
			decPw = aes256.aesDecode(pw);
		} catch (InvalidKeyException|UnsupportedEncodingException|NoSuchAlgorithmException|NoSuchPaddingException|
				InvalidAlgorithmParameterException|IllegalBlockSizeException|BadPaddingException e ) {
			e.printStackTrace();
		}
		
		response.getWriter().print(decPw);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
