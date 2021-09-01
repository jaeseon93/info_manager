package co.yedam.ic.jsh.address.body;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddressInsertBody
 */
@WebServlet("/ainsertbody.do")
public class AddressInsertBody extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public AddressInsertBody() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doAction(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doAction(request,response);

	}
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String path = "views/address/addressinsert.jsp";
		System.out.println(path);
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);
	}
}
