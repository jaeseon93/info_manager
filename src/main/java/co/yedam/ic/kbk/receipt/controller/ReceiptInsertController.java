package co.yedam.ic.kbk.receipt.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import co.yedam.ic.common.ConnectionManager;
import co.yedam.ic.kbk.receipt.dao.ReceiptDAO;
import co.yedam.ic.kbk.receipt.vo.ReceiptVO;

@WebServlet("/rctInsert.do")
public class ReceiptInsertController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("인설트트으으ㅡ");
		String path = request.getSession().getServletContext().getRealPath("upload"); // 서버의 저장공간
		int size = 1024 * 1024 * 10; // 업로드될 파일의 최대 사이즈
		String file = ""; //저장시 사용될 이름
		String oriFile = ""; //원래 파일명
		
		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		String str = (String)files.nextElement();
		
		
		file = multi.getFilesystemName(str); //저장시 사용될 이름
		oriFile = multi.getOriginalFileName(str); //원래 파일명
		
		request.setCharacterEncoding("utf-8");
		ReceiptDAO dao = ReceiptDAO.getInstance();
		ReceiptVO requestVo = new ReceiptVO();
		//request.getSession().getAttribute("memberNo");
		
		requestVo.setMemberno((int)request.getSession().getAttribute("memberno"));
		requestVo.setTitle(multi.getParameter("title"));
		requestVo.setPlace(multi.getParameter("place"));
		requestVo.setStuff(multi.getParameter("stuff"));
		requestVo.setTotal(multi.getParameter("total"));
		requestVo.setNote(multi.getParameter("note"));
		requestVo.setImg(file);
		requestVo.setRctdate(multi.getParameter("rctdate"));

		Connection conn = ConnectionManager.getConnection();
		int insertResult = dao.insert(conn, requestVo);
		
		boolean n = false;
		System.out.println(requestVo);
		
		if (insertResult != 0) {
			n = true;
		} 
		
		ConnectionManager.close(conn);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", insertResult);
		
		Gson gson = new Gson();
		String resultString = gson.toJson(json);
		response.getWriter().print(resultString);

	}
}