package tilesTest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/GetBoardList.do")
public class GetBoardListServlet extends HttpServlet{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request,response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

		//String path = "member/login.jsp";
		String path = "member/login.tiles";
		//String path = "admin/member/login.tiles";
		request.getRequestDispatcher(path).forward(request,response);

	}
}
