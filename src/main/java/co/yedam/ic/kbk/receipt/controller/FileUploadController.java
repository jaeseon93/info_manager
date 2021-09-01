package co.yedam.ic.kbk.receipt.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import co.yedam.ic.common.OCRApi;

@WebServlet("/fileUpload.do")
public class FileUploadController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");

		String path = request.getSession().getServletContext().getRealPath("upload");
		int size = 1024 * 1024 * 10;

		MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		String str = (String) files.nextElement();

		String file = multi.getFilesystemName(str); // 저장시 사용될 이름
		
		String result ="";
		try {
			result = upload(path + "/" + file);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.getWriter().append(result);
		
	}

	private String upload(String rctupload) {
		
		ArrayList<String> list = new ArrayList<String>();
		list = OCRApi.detectText(rctupload); //원본
		ArrayList<String> result = new ArrayList<String>();
		
		for (String s : list) {
			String[] data = new String[100];
			data = s.split("\n");
			result.addAll(Arrays.asList(data));
		}
		int i = 0;
		for (String s : result) {
		//	System.out.println(i++ +":" + s + ":"); 
		}
		Map<String, String> fresult = new HashMap<>();
		fresult.put("place",result.get(result.indexOf("회사명")+1));
		fresult.put("total",result.get(result.indexOf("합계")+1));
		
		//json변환 map'
		Gson gson = new Gson();
		
		return gson.toJson(fresult);
	}

}