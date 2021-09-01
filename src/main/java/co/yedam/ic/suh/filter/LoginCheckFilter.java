package co.yedam.ic.suh.filter;

import co.yedam.ic.common.Strings;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("*.do")
public class LoginCheckFilter implements Filter{
	private static String[] aryCheckExclude = {
			Strings.CON_LOGIN,
			Strings.CON_LOGOUT_PAGE,
			Strings.CON_LOGIN_PAGE,
			Strings.CON_LOGIN_CHECK,
			Strings.CON_JOIN_PAGE,
			Strings.CON_EMAIL_CHECK,
			Strings.CON_JOIN_RESULT
	};


	public void destroy(){
	}

	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException{

		HttpServletRequest request = (HttpServletRequest)req;
		String requestURI = request.getRequestURI();
		System.out.println(requestURI);
		String[] ary = requestURI.split("/");
		String requestDo = ary[ary.length-1];
		System.out.println(requestDo);
		boolean checkLogin = true;
		for(String s : aryCheckExclude){
			if(s.equals(requestDo)){
				checkLogin = false;
				break;
			}
		}
		HttpSession session = ((HttpServletRequest)req).getSession();
		if( checkLogin && session.getAttribute("memberno") == null){
			req.getRequestDispatcher(Strings.CON_LOGIN_PAGE).forward(req, resp);
		}else{
			chain.doFilter(req, resp);
		}
	}

	public void init(FilterConfig config) throws ServletException{

	}

}
