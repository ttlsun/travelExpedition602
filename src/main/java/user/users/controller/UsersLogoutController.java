package user.users.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import user.users.model.UsersDao;

@Controller
public class UsersLogoutController {
	private final String COMMAND = "/logout.do";
	/*
	 * private final String LOGINALREADY = "redirect:/login.do"; private final
	 * String GOTOPAGE = "redirect:/main.do";
	 */
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value=COMMAND)
	public void doAction(PrintWriter pw, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		System.out.println(this.getClass()); //추후 삭제 가능
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		if(request.getParameter("channel") == "" || request.getParameter("channel") == null) {
			pw.println("<script>if(!confirm('로그아웃 하시겠습니까?')){history.go(-1);}else{location.replace('logout.do?channel=logout');}</script>");
		} else {
			if(request.getParameter("channel").equals("loginAlready")) {
				//session.removeAttribute("loginInfo");
				session.invalidate();
				pw.println("<script>location.replace('login.do');</script>");
			} else if (request.getParameter("channel").equals("logout")){
				session.invalidate();
				pw.println("<script>location.replace('main.do');</script>");
			}
		}
		pw.flush();
		
		return;
	}
}
