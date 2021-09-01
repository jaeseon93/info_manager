package co.yedam.ic.hjs.passwords.controller;

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

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.hjs.aes256.AES256Util;
import co.yedam.ic.hjs.passwords.dao.PasswordsDAO;
import co.yedam.ic.hjs.passwords.vo.PasswordsVo;


@WebServlet("/pwselect.do")
public class PwSelectController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		PasswordsVo vo = new PasswordsVo();

		String key = (String)request.getSession().getAttribute("selectedString");
		HashMap<String, Integer> map = (HashMap)request.getSession().getAttribute("pwMap");


		vo.setIdxno(map.get(key));
				
		PasswordsVo voSel = new PasswordsVo();
		Connection conn = ConnectionManager.getConnection();
		try {
			conn.setAutoCommit(false);
			voSel = PasswordsDAO.getInstance().select(conn, vo);		
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch(SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			ConnectionManager.close(conn);
		}
		
		//복호화
		String Aeskey = "aes256-test-key!!";
		AES256Util aes256 = new AES256Util(Aeskey);
		String pw = voSel.getSitepw();
		
		try {
			String decPw = aes256.aesDecode(pw);
			voSel.setSitepw(decPw);
		} catch (InvalidKeyException|UnsupportedEncodingException|NoSuchAlgorithmException|NoSuchPaddingException|
				InvalidAlgorithmParameterException|IllegalBlockSizeException|BadPaddingException e ) {
			e.printStackTrace();
		}
		
		request.setAttribute("select", voSel);
		String view = "views/passwords/pwModifyBody.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	
}