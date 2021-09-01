package co.yedam.ic.jsh.address.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddKey
 */
@WebServlet("/addkey.do")
public class AddKey extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AddKey() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request,response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doAction(request,response);
	}
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String key = request.getParameter("selectedString");
		request.getSession().setAttribute("selectedString",key);
		response.getWriter().print("true");
	}
}
