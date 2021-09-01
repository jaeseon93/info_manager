package co.yedam.ic.suh.sha256;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/pw.do")
public class ChangePWServlet extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doAction(request, response);
	}
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String pw = request.getParameter("pw");
		String salt = request.getParameter("salt");

		String encrypt = SHAEncrypt.getEncrypt(pw, salt);


		response.getWriter().print(encrypt);
	}
}
